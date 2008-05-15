/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf;

import org.openamf.config.ServiceConfig;
import org.openamf.config.ServiceMethodConfig;

import java.util.List;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.10 $, $Date: 2004/08/24 19:42:23 $
 */
public class ServiceRequest {

	private AMFBody requestBody;
	private ServiceConfig serviceConfig;
	private ServiceMethodConfig methodConfig;
	private String target;
	private String serviceName;
	private String serviceMethodName;
	private List parameters;

	public ServiceRequest(AMFBody requestBody) {
		this(requestBody, null);
	}

	public ServiceRequest(AMFBody requestBody, ServiceConfig serviceConfig) {
		this.requestBody = requestBody;
		this.serviceConfig = serviceConfig;
		this.target = requestBody.getTarget();
		if (serviceConfig == null) {
			this.serviceName = requestBody.getServiceName();
		} else {
			this.serviceName = serviceConfig.getServiceLocation();
		}
		this.serviceMethodName = requestBody.getServiceMethodName();

		Object value = requestBody.getValue();
		if (value != null && value instanceof List) {
			this.parameters = (List) value;
		}
	}

	public AMFBody getRequestBody() {
		return requestBody;
	}

	public void setRequestBody(AMFBody body) {
		requestBody = body;
	}
	
	public ServiceConfig getServiceConfig() {
		return serviceConfig;
	}

	public ServiceMethodConfig getServiceMethodConfig() {
		return methodConfig;
	}
	
	void setServiceMethodConfig(ServiceMethodConfig methodConfig) {
		this.methodConfig = methodConfig;
	}
	
	public String getTarget() {
		return target;
	}

	public void setTarget(String string) {
		target = string;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String string) {
		serviceName = string;
	}

	public String getServiceMethodName() {
		return serviceMethodName;
	}

	public void setServiceMethodName(String string) {
		serviceMethodName = string;
	}

	public List getParameters() {
		return parameters;
	}

	public void setParameters(List list) {
		parameters = list;
	}

	public void addParameter(Object stateBean) {
		parameters.add(stateBean);
	}


	public String toString()
	{
		return String.valueOf(this.requestBody);
	}
}
