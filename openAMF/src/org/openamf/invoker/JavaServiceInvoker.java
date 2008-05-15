/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.invoker;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openamf.ServiceRequest;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @author Sean C. Sullivan
 * 
 * @version $Revision: 1.29 $, $Date: 2004/08/15 18:12:30 $
 */
public class JavaServiceInvoker extends ServiceInvoker {

	private static final Log log = LogFactory.getLog(JavaServiceInvoker.class);

	public JavaServiceInvoker(
		ServiceRequest request,
		HttpServletRequest httpServletRequest,
		ServletContext servletContex) {

		super(request, httpServletRequest, servletContex);
	}

	public Object invokeService() throws ServiceInvocationException {
		Class serviceClass = null;
		Object service = null;
		Object serviceResult = null;

		try {
			serviceClass = loadClass(request.getServiceName());
			service = getPersistentServiceObject();
			if (service == null) {
				service = serviceClass.newInstance();
			}
			serviceResult = invokeServiceMethod(
					service,
					serviceClass,
					request.getServiceMethodName(),
					request.getParameters());
			setPersistentServiceObject(service);
		} catch (InvocationTargetException e) {
			//use the cause since the exception is thrown when 
			//the service method throws an exception
			throw new ServiceInvocationException(request, e.getTargetException());
		} catch (Exception e) {
			throw new ServiceInvocationException(request, e);
		}

		return serviceResult;
	}

	public boolean getPersistService() {
		boolean result = false;
		Class serviceClass = null;
		try
		{
			serviceClass = loadClass(request.getServiceName());
			if (java.io.Serializable.class.isAssignableFrom(serviceClass))
			{
				result = true;
			}
			else
			{
				result = false;
			}
		}
		catch (ClassNotFoundException ex)
		{
			result = false;
		}
		return result;
	}

	public String getPersistentServiceName() {
		return request.getServiceName();
	}

	protected Object invokeServiceMethod(
		Object service,
		Class serviceClass,
		String methodName,
		List parameters)
		throws
			SecurityException,
			NoSuchMethodException,
			IllegalArgumentException,
			IllegalAccessException,
			InvocationTargetException {

		RankedMethod serviceMethod = getServiceMethod(serviceClass, methodName, parameters);
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

		log.debug("REQUESTED methodName: " + methodName);

		for (int i = 0; i < methods.length; i++) {
			Method method = methods[i];
			RankedMethod rankedMethod =
				new RankedMethod(method, methodName, parameters);
			if (rankedMethod.isInvokable()) {
				//only added invokable methods to list
				rankedMethods.add(rankedMethod);
			}
		}

		if (rankedMethods.size() > 0) {
			Collections.sort(rankedMethods);
			RankedMethod topRankedMethod = (RankedMethod) rankedMethods.get(0);
			log.info(
				"topRankedMethod: name="
					+ topRankedMethod.getMethod().getName()
					+ " rank="
					+ topRankedMethod.getRank());
			serviceMethod = topRankedMethod;
		}

		if (serviceMethod == null) {
			String errorDesc = serviceClass + "." + methodName + "(" + parameters + ")";
			log.warn("Method Not Found: " + errorDesc);
			throw new NoSuchMethodException(errorDesc);
		}

		return serviceMethod;
	}

	static private Class loadClass(String className) throws ClassNotFoundException
	{
		Class cl = null;
		
		cl = Thread.currentThread().getContextClassLoader().loadClass(className);
		
		return cl;
	}
	
	public boolean supports(ServiceRequest request) {
        if (request!=null) {
            log.debug("check supports "+ request.getServiceName());
        }
		boolean supports = false;
		try {
			loadClass(request.getServiceName());
			supports = true;
		} catch (Exception e) {
            log.debug("exception", e);
		}
		return supports;
	}

}
