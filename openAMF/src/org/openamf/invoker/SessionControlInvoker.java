/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.invoker;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openamf.ServiceRequest;

/**
 * Simple Session management Service
 *
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.10 $, $Date: 2004/08/14 03:58:35 $
 */
public class SessionControlInvoker extends ServiceInvoker {

	private static Log log = LogFactory.getLog(SessionControlInvoker.class);

	public SessionControlInvoker(
		ServiceRequest request,
		HttpServletRequest httpServletRequest,
		ServletContext servletContex) {

		super(request, httpServletRequest, servletContex);
	}

	public Object invokeService() throws ServiceInvocationException {
		Object result = Boolean.FALSE;
		String serviceMethodName = getRequest().getServiceMethodName(); 
		if ("close".equals(serviceMethodName)) {
			getHttpServletRequest().getSession().invalidate();
			log.info("Current Session closed by user");
			result = Boolean.TRUE;
		} else if ("getId".equals(serviceMethodName)) {
			result = getHttpServletRequest().getSession().getId();
		}
		return result;

	}

	public boolean supports(ServiceRequest request) {
		return SessionControlInvoker.class.getName().equals(request.getServiceName());
	}

}
