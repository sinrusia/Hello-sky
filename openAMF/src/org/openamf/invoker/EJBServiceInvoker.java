/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.invoker;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.ejb.EJBHome;
import javax.ejb.EJBMetaData;
import javax.ejb.EJBObject;
import javax.ejb.Handle;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openamf.ServiceRequest;

/**
 * Simple EJB Service Invoker
 *
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @author Roberto Saccon <saccon@users.sourceforge.net>
 * @version $Revision: 1.14 $, $Date: 2003/12/18 02:31:49 $
 */
public class EJBServiceInvoker extends JavaServiceInvoker {

	private static Log log = LogFactory.getLog(EJBServiceInvoker.class);
	
	private Object home = null;
	private boolean persistService = false;

	public EJBServiceInvoker(
		ServiceRequest request,
		HttpServletRequest httpServletRequest,
		ServletContext servletContex) {

		super(request, httpServletRequest, servletContex);
	}

	public Object invokeService() throws ServiceInvocationException {
		Object serviceResult = null;
		try {
			Object ejb = null;
			
			if (persistService) {
				log.debug("Trying to get Handle from persistentObject");
				Handle handle = (Handle)getPersistentServiceObject();
				if (handle != null) {
					log.debug("Got Handle from persistentObject");
					ejb = handle.getEJBObject();
				}
			}
			 
			if (ejb == null) {
				if (home == null) {
					log.warn("Home is NULL - unable to find EJB " + request.getServiceName());
					return null;
				}
				Method ejbCreateMethod =
					home.getClass().getMethod("create", new Class[0]);
				log.info("Calling Create Method: " + request.getServiceName());
				ejb = ejbCreateMethod.invoke(home, new Object[0]);
			}
			
			serviceResult =
				invokeServiceMethod(
					ejb,
					ejb.getClass(),
					request.getServiceMethodName(),
					request.getParameters());

			if (persistService) {
				if (ejb instanceof EJBObject) {
					log.debug("setting persistentObject = Handle");
					setPersistentServiceObject(((EJBObject)ejb).getHandle());
				}
			}

		} catch (InvocationTargetException e) {
			//use the cause since the exception is thrown when 
			//the service method throws an exception
			throw new ServiceInvocationException(request, e.getTargetException());
		} catch (Exception e) {
			throw new ServiceInvocationException(request, e);
		}
		return serviceResult;
	}

	private boolean checkPersistService(Object home) throws Exception {
		boolean persistService = false;
		if (home instanceof EJBHome) {
			EJBMetaData metaData = ((EJBHome)home).getEJBMetaData();
			if (metaData.isSession()) {
				if (metaData.isStatelessSession()) {
					log.debug("Stateless Session Bean");
					persistService = false;
				} else {
					log.debug("Stateful Session Bean");
					persistService = true;
				}
			} else {
				log.debug("Not Session Bean, assume Entity EJB");
				persistService = true;
			}
		}
		
		return persistService;
	}

	public boolean getPersistService() {
		return persistService;
	}

	public boolean supports(ServiceRequest request) {
		boolean supports = false;
		try {
			getHome(request);
			supports = true;
		} catch (Exception e) {
		}

		return supports;
	}

	/* Used to check if this is a persistent service (Stateful Session Bean or Entity Bean)
	 * @see org.openamf.invoker.ServiceInvoker#prepare(org.openamf.ServiceRequest)
	 */
	public void prepare(ServiceRequest request) {
		try {
			persistService = checkPersistService(getHome(request));			
		} catch (Exception e) {
		}
	}
	
	private Object getHome(ServiceRequest request) throws Exception {
		InitialContext context = new InitialContext();
		if (home == null) {
			home = context.lookup(request.getServiceName());
		}
		return home;
	}
}
