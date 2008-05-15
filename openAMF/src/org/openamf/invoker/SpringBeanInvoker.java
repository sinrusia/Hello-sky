/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */
package org.openamf.invoker;

import java.util.List;
import java.util.ArrayList;
import java.util.Collections;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.openamf.ServiceRequest;
import org.openamf.invoker.ServiceInvoker;
import org.openamf.invoker.ServiceInvocationException;
import org.openamf.invoker.RankedMethod;

import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.context.WebApplicationContext;

/**
 * @author Andrew Barnes <andy@geni.com.au>
 * @author Tom McGee <tmcgee@cya.ca.gov>
 * @version $Revision: 1.2 $, $Date: 2006/03/29 06:42:31 $
 */
public class SpringBeanInvoker extends ServiceInvoker {

	private static Log log = LogFactory.getLog(SpringBeanInvoker.class);
	private WebApplicationContext context;

	public SpringBeanInvoker(
		ServiceRequest request,
		HttpServletRequest servletRequest,
		ServletContext servletContext) {
		super(request, servletRequest, servletContext);
		this.context =
			WebApplicationContextUtils.getWebApplicationContext(
				this.getServletContext());
	}

	public Object invokeService() throws ServiceInvocationException {
		Class serviceClass = null;
		Object service = null;
		Object serviceResult = null;
		try {
			service = this.getPersistentServiceObject();
			if (service == null) {
				service =
					this.context.getBean(this.getRequest().getServiceName());
			}
			serviceClass = service.getClass();
			serviceResult =
				invokeServiceMethod(
					service,
					serviceClass,
					this.getRequest().getServiceMethodName(),
					this.getRequest().getParameters());
			this.setPersistentServiceObject(service);
		} catch (InvocationTargetException e) {
			throw new ServiceInvocationException(
				request,
				e.getTargetException());
		} catch (Exception e) {
			throw new ServiceInvocationException(request, e);
		}
		return serviceResult;
	}

	protected Object invokeServiceMethod(
		Object service,
		Class serviceClass,
		String methodName,
		List parameters)
		throws
			SecurityException,
			NoSuchMethodException,
			IllegalAccessException,
			IllegalArgumentException,
			InvocationTargetException {
		RankedMethod serviceMethod =
			getServiceMethod(serviceClass, methodName, parameters);
		return serviceMethod.invoke(service);
	}

	private RankedMethod getServiceMethod(
		Class serviceClass,
		String methodName,
		List parameters)
		throws SecurityException, NoSuchMethodException {

		RankedMethod serviceMethod = null;
		Method[] methods = serviceClass.getMethods();
		List rankedMethods = new ArrayList(methods.length);
		for (int i = 0; i < methods.length; i++) {
			Method method = methods[i];
			RankedMethod rankedMethod =
				new RankedMethod(method, methodName, parameters);
			if (rankedMethod.isInvokable()) {
				rankedMethods.add(rankedMethod);
			}
		}
		if (rankedMethods.size() > 0) {
			Collections.sort(rankedMethods);
			RankedMethod topRankedMethod = (RankedMethod) rankedMethods.get(0);
			serviceMethod = topRankedMethod;
		}
		if (serviceMethod == null) {
			String errorDesc =
				serviceClass + "." + methodName + "(" + parameters + ")";
			throw new NoSuchMethodException(errorDesc);
		}
		return serviceMethod;
	}

	public boolean getPersistService() {
		return false;
	}

	public String getPersistentServiceName() {
		return this.getRequest().getServiceName();
	}

	public boolean supports(ServiceRequest request) {
		boolean supports = false;
		try {
			context.getBean(this.getRequest().getServiceName());
			supports = true;
		} catch (Exception e) {
			if (log.isDebugEnabled()) {
				log.debug(
					this.getClass().getName()
						+ " does not support service request");
			}
		}
		return supports;
	}

}
