/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.config;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.11 $, $Date: 2003/08/09 16:59:22 $
 */
public class ServiceConfig {
	
	private String name;
	private String serviceLocation;
	private String serviceInvokerRef;
	private ServiceInvokerConfig serviceInvokerConfig;
	private OpenAMFConfig config;
	private List methodConfigs = new ArrayList();
	
	private static Log log = LogFactory.getLog(ServiceConfig.class);

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public String getServiceLocation() {
		return serviceLocation;
	}

	public void setServiceLocation(String string) {
		serviceLocation = string;
	}

	public String getServiceInvokerRef() {
		return serviceInvokerRef;
	}

	public void setServiceInvokerRef(String serviceInvokerRef) {
		this.serviceInvokerRef = serviceInvokerRef;
	}
	
	public ServiceInvokerConfig getServiceInvokerConfig() {
		
		if (config == null) {
			return null;
		}
		
		if (serviceInvokerConfig == null) {
			serviceInvokerConfig = config.getServiceInvokerConfig(serviceInvokerRef);
		}
		
		return serviceInvokerConfig;
	}

	public OpenAMFConfig getConfig() {
		return config;
	}

	public void setConfig(OpenAMFConfig config) {
		this.config = config;
	}
	
	public Iterator getMethodConfigs() {
		return methodConfigs.iterator();
	}
	
	public void addMethodConfig(ServiceMethodConfig methodConfig) {
		methodConfig.setServiceConfig(this);
		methodConfigs.add(methodConfig);
	}
	
	public String toString() {
		
		if (config == null) {
			return super.toString();
		}
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("\n**************************\n");
		
		sb.append("Name: ");
		sb.append(getName());
		sb.append('\n');
		
		sb.append("Service Location: ");
		sb.append(getServiceLocation());
		sb.append('\n');
		
		sb.append("Service Invoker Ref: ");
		sb.append(getServiceInvokerRef());
		sb.append('\n');

		if (getServiceInvokerConfig() != null) {
			sb.append("Service Invoker:\n");
			sb.append(getServiceInvokerConfig().getName());
			sb.append('\n');
		}
		
		sb.append("-----------------\n");
		sb.append("METHODS\n");
		sb.append("-----------------\n");
		for (Iterator i = getMethodConfigs(); i.hasNext();) {
			ServiceMethodConfig soc = (ServiceMethodConfig)i.next();
			sb.append(soc);
		}
		
		return sb.toString();
	}

}
