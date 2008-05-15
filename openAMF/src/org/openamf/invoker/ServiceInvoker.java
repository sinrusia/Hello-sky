/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.invoker;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.openamf.ServiceRequest;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.14 $, $Date: 2003/12/26 20:16:19 $
 */
public abstract class ServiceInvoker {

	protected ServiceRequest request;
	protected HttpServletRequest httpServletRequest;
	protected ServletContext servletContext;
	protected Object persistentServiceObject;

	public ServiceInvoker(
		ServiceRequest request,
		HttpServletRequest httpServletRequest,
		ServletContext servletContext) {

		this.request = request;
		this.httpServletRequest = httpServletRequest;
		this.servletContext = servletContext;
	}

	public abstract Object invokeService() throws ServiceInvocationException;

	public ServiceRequest getRequest() {
		return request;
	}

	public void setRequest(ServiceRequest request) {
		this.request = request;
	}

	public HttpServletRequest getHttpServletRequest() {
		return httpServletRequest;
	}

	public void setHttpServletRequest(HttpServletRequest httpServletRequest) {
		this.httpServletRequest = httpServletRequest;
	}

	public ServletContext getServletContext() {
		return servletContext;
	}

	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	public boolean getPersistService() {
		return false;
	}

	public String getPersistentServiceName() {
		return null;
	}

	public Object getPersistentServiceObject() {
		return persistentServiceObject;
	}

	public void setPersistentServiceObject(Object persistentServiceObject) {
		this.persistentServiceObject = persistentServiceObject;
	}

	public abstract boolean supports(ServiceRequest request);

	/**
	 * Called before invokeService and after supports (if you're using the DefaultGateway)
	 * Can be used to determine if the service should be persisted 
	 * @param request
	 */
	public void prepare(ServiceRequest request) {
	}

	public static ServiceInvoker load(
		String className,
		ServiceRequest request,
		HttpServletRequest httpServletRequest,
		ServletContext servletContext)
		throws
			ClassNotFoundException,
			NoSuchMethodException,
			InstantiationException,
			IllegalAccessException,
			InvocationTargetException {

		Class serviceInvokerClass = Thread.currentThread().getContextClassLoader().loadClass(className);

		Constructor constructor =  serviceInvokerClass.getConstructor(
				new Class[] {
					ServiceRequest.class,
					HttpServletRequest.class,
					ServletContext.class });

        ServiceInvoker serviceInvoker = (ServiceInvoker) constructor.newInstance(
                new Object[] { request, httpServletRequest, servletContext });
		return serviceInvoker;
	}
	
	public String toString()
	{
		StringBuffer sb = new StringBuffer();
		sb.append("ServiceRequest=" + String.valueOf(getRequest()));
		sb.append("\n");
		sb.append("persistService=" + getPersistService());
		return sb.toString();
	}
}
