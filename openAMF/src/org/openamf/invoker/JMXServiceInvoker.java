/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.invoker;

import java.util.List;

import javax.management.MBeanServer;
import javax.management.MBeanServerFactory;
import javax.management.ObjectName;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openamf.ServiceRequest;

/**
 * Simple JMX Service Invoker
 *
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @author Roberto Saccon <saccon@users.sourceforge.net>
 * @version $Revision: 1.11 $, $Date: 2003/11/29 20:18:03 $
 */
public class JMXServiceInvoker extends ServiceInvoker {

	private static Log log = LogFactory.getLog(JMXServiceInvoker.class);

	public JMXServiceInvoker(
		ServiceRequest request,
		HttpServletRequest httpServletRequest,
		ServletContext servletContex) {
			
		super(request, httpServletRequest, servletContex);
	}

	public Object invokeService() throws ServiceInvocationException {

		Object serviceResult = null;
		try {
            List serverList = MBeanServerFactory.findMBeanServer(null);
            if (serverList == null || serverList.size()==0) {
                throw new Exception("MBeanServers not found");
            }
            MBeanServer server = (MBeanServer) serverList.get(0);
			ObjectName objectName = new ObjectName(request.getServiceName());
			Object[] parameters = request.getParameters().toArray();
			String[] signature = new String[parameters.length];

			for (int i = 0; i < parameters.length; i++) {
				signature[i] = parameters[i].getClass().getName();
			}
			serviceResult =
				server.invoke(
					objectName,
					request.getServiceMethodName(),
					parameters,
					signature);
		} catch (Exception e) {
			throw new ServiceInvocationException(request, e);
		}

		return serviceResult;
	}

	public boolean getPersistService() {
		return false;
	}

	public String getPersistentServiceName() {
		return null;
	}

	public boolean supports(ServiceRequest request) {
		return (request.getServiceName().lastIndexOf(":") != -1);
	}

}
