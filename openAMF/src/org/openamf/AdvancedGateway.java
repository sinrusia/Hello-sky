/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf;

import java.security.Principal;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openamf.config.FilterConfig;
import org.openamf.config.OpenAMFConfig;
import org.openamf.config.ServiceConfig;
import org.openamf.config.ServiceMethodAccessConstraintConfig;
import org.openamf.config.ServiceMethodConfig;
import org.openamf.config.ServiceMethodParameterConfig;
import org.openamf.config.StateBeanConfig;
import org.openamf.filter.FilterException;
import org.openamf.filter.ResultFilter;
import org.openamf.invoker.AccessDeniedException;
import org.openamf.invoker.ServiceInvocationException;
import org.openamf.invoker.ServiceInvoker;


/**
 * Extends the behavior of the DefaultGateway to allow more advanced
 * configuration such as selecting the invoker, adding access control, storing
 * state-beans in the request/session, and filtering the results.
 * 
 * For more information about the config options see the config-overview.txt
 * file the docs directory
 * 
 * @author <a href="mailto:mail@jasoncalabrese.com">Jason Calabrese </a>
 * @version $Revision: 1.32 $, $Date: 2004/08/27 02:26:12 $
 */
public class AdvancedGateway extends DefaultGateway {

	private static Log log = LogFactory.getLog(AdvancedGateway.class);

	/**
	 * Uses the setting in openamf-config.xml to gets the correct invoker,
	 * enforce access control, and store state-beans in the request/session
	 * 
	 * @see org.openamf.DefaultGateway#getServiceInvoker(org.openamf.AMFBody,
	 *         javax.servlet.http.HttpServletRequest)
	 */
	protected ServiceInvoker getServiceInvoker(
		AMFBody requestBody,
		HttpServletRequest httpServletRequest)
		throws ServiceInvocationException {

		ServiceInvoker serviceInvoker = null;

		try {
			ServiceConfig serviceConfig = getServiceConfig(requestBody);
			
			if (serviceConfig == null)
			{
				throw new AccessDeniedException(
							"could not find service configuration for '"
							+ requestBody.getServiceName()
							+ "'");
			}
			
			ServiceRequest request = new ServiceRequest(requestBody, serviceConfig);
			ServiceMethodConfig methodConfig = getMethodConfig(serviceConfig, request);
			// abort if no method config is found. This allows us to restrict
			// access to the service in the openamf configuration.
			if (methodConfig == null) {
				NoSuchMethodException e =
					new NoSuchMethodException(request.getRequestBody().toString());

				log.warn("Method config not found: "+ request.getRequestBody().toString());
				throw e;
			}

			// store methodConfig for later use
			request.setServiceMethodConfig(methodConfig);

			// Check access permissions if there are any in the configuration
			Iterator constraints = methodConfig.getAccessConstraintConfigs();
			if (constraints.hasNext()) {
				boolean accessDenied = true;
				while (accessDenied && constraints.hasNext()) {
					ServiceMethodAccessConstraintConfig constraint =
						(ServiceMethodAccessConstraintConfig) constraints
							.next();
					accessDenied =
						!httpServletRequest.isUserInRole(
							constraint.getRoleName());
				}
				if (accessDenied) {
					Principal user = httpServletRequest.getUserPrincipal();
					throw new AccessDeniedException(
						(user == null ? "<anonymous user>" : user.getName()));
				}
			}

			addStateBeansToParams(httpServletRequest, request, methodConfig);

			serviceInvoker =
				ServiceInvoker.load(
					serviceConfig.getServiceInvokerConfig().getClassName(),
					request,
					httpServletRequest,
					getServletContext());

			serviceInvoker.prepare(request);

		} catch (Exception e) {
			throw new ServiceInvocationException(requestBody, e);
		}

		return serviceInvoker;
	}

	private void addStateBeansToParams(
		HttpServletRequest httpServletRequest,
		ServiceRequest request,
		ServiceMethodConfig methodConfig)
		throws
			ClassNotFoundException,
			InstantiationException,
			IllegalAccessException {

		if (methodConfig != null) {
			Iterator stateBeans = methodConfig.getStateBeanConfigs();
			while (stateBeans.hasNext()) {

				Object stateBean = null;
				StateBeanConfig stateBeanConfig =
					(StateBeanConfig) stateBeans.next();

				if (stateBeanConfig.isApplicationScope()) {
					stateBean =
						getServletContext().getAttribute(
							stateBeanConfig.getClassName());
				} else {
					stateBean =
						httpServletRequest.getSession().getAttribute(
							stateBeanConfig.getClassName());
				}

				if (stateBean == null) {
					log.info("Loading " + stateBeanConfig.getClassName());
					Class stateBeanClass =
						Thread
							.currentThread()
							.getContextClassLoader()
							.loadClass(
							stateBeanConfig.getClassName());
					stateBean = stateBeanClass.newInstance();

					if (stateBeanConfig.isApplicationScope()) {
						log.info(
							"Storing "
								+ stateBeanConfig.getClassName()
								+ " in ServletContext");
						getServletContext().setAttribute(
							stateBeanConfig.getClassName(),
							stateBean);
					} else {
						log.info(
							"Storing "
								+ stateBeanConfig.getClassName()
								+ " in HttpSession");
						httpServletRequest.getSession().setAttribute(
							stateBeanConfig.getClassName(),
							stateBean);
					}
				} else {
					if (stateBeanConfig.isApplicationScope()) {
						log.info(
							"Got "
								+ stateBeanConfig.getClassName()
								+ " from ServletContext");
					} else {
						log.info(
							"Got "
								+ stateBeanConfig.getClassName()
								+ " from HttpSession");
					}
				}

				request.addParameter(stateBean);
			}
		}
	}

	/**
	 * Preforms any filtering that was defined in openamd-config.xml and then
	 * return control to the DefaultGateway
	 * 
	 * @see org.openamf.DefaultGateway#postInvokeService(javax.servlet.http.HttpServletRequest,
	 *         org.openamf.invoker.ServiceInvoker, java.lang.Object)
	 */
	protected Object postInvokeService(
		HttpServletRequest httpServletRequest,
		ServiceInvoker serviceInvoker,
		Object serviceResult)
		throws ServiceInvocationException {

		ServiceMethodConfig methodConfig =
			serviceInvoker.getRequest().getServiceMethodConfig();

		try {
			if (methodConfig != null) {
				Iterator rfcs = methodConfig.getResultFilterConfigs();
				while (rfcs.hasNext()) {
					FilterConfig fc = (FilterConfig) rfcs.next();
					serviceResult = filterResult(serviceResult, fc);
				}
			}
		} catch (Exception e) {
			throw new ServiceInvocationException(serviceInvoker.getRequest(),e);
		}
		return super.postInvokeService(httpServletRequest, serviceInvoker, serviceResult);
	}

	private Object filterResult(
		Object serviceResult,
		FilterConfig filterConfig)
		throws
			ClassNotFoundException,
			InstantiationException,
			IllegalAccessException,
			FilterException {

		log.debug("loading filter class: " + filterConfig.getClassName());
		Class filterClass =
			Thread.currentThread().getContextClassLoader().loadClass(
				filterConfig.getClassName());

		ResultFilter resultFilter = (ResultFilter) filterClass.newInstance();

		log.info("calling Filter: " + filterConfig.getClassName());
		return resultFilter.filter(serviceResult, filterConfig);

	}

	private ServiceConfig getServiceConfig(AMFBody requestBody) {
		ServiceConfig serviceConfig =
			OpenAMFConfig.getInstance().getServiceConfig(requestBody.getServiceName());
		return serviceConfig;
	}

	private ServiceMethodConfig getMethodConfig(
		ServiceConfig serviceConfig,
		ServiceRequest request)
		throws ClassNotFoundException {

		log.debug("getting MethodConfig for " + request.getServiceMethodName());

		ServiceMethodConfig methodConfig = null;

		List parameters = request.getParameters();

		Iterator smcs = serviceConfig.getMethodConfigs();

		smcsLabel : while (smcs.hasNext()) {

			ServiceMethodConfig smc = (ServiceMethodConfig) smcs.next();
			String smcName = smc.getName();
			log.debug("service method config name: " + smcName);
			if ("*".equals(smcName)
				|| smcName.equals(request.getServiceMethodName())) {
				log.debug("name matches, now to compare params");
				int paramIndex = -1;
				Iterator sopcs = smc.getParameterConfigs();

				smpcsLabel : while (sopcs.hasNext()) {
					paramIndex++;
					ServiceMethodParameterConfig sopc =
						(ServiceMethodParameterConfig) sopcs.next();
					if (sopc.getType().equals("*")) {
						log.debug("matches the rest");
						methodConfig = smc;
						break smcsLabel;
					} else if (
						sopc.getType().equals("?")
							|| typesMatch(parameters, paramIndex, sopc)) {
						if (paramIndex == parameters.size() - 1) {
							log.debug("all parameters match");
							methodConfig = smc;
							break smcsLabel;
						} else {
							log.debug(
								"this parameter matches, contine checking the rest");
							continue smpcsLabel;
						}
					}
				}
			}
		}

		return methodConfig;
	}

	private boolean typesMatch(
		List parameters,
		int paramIndex,
		ServiceMethodParameterConfig sopc)
		throws ClassNotFoundException {

		boolean typesMatch = false;

		Class typeClass =
			Thread.currentThread().getContextClassLoader().loadClass(
				sopc.getType());
		if (typeClass.isInstance(parameters.get(paramIndex))) {
			typesMatch = true;
		}

		return typesMatch;
	}
	
	public String getServletInfo() {
		return "OpenAMF AdvancedGateway servlet, http://www.openamf.org/";
	}

}
