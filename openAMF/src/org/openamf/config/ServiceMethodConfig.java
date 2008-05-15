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
 * @version $Revision: 1.8 $, $Date: 2003/08/09 16:59:22 $
 */
public class ServiceMethodConfig {
	
	private String name;
	private List stateBeanRefs = new ArrayList();
	private List stateBeanConfigs = new ArrayList();
	private boolean stateBeanConfigsLoaded = false;
	private List parameterConfigs = new ArrayList();
	private List accessConstraintConfigs = new ArrayList();
	private List resultFilterConfigs = new ArrayList();
	private ServiceConfig serviceConfig;
	
	private static Log log = LogFactory.getLog(ServiceMethodConfig.class);

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void addStateBeanRef(String name) {
		log.debug("Adding stateBeanRef");
		stateBeanRefs.add(name);
	}
	
	public Iterator getStateBeanConfigs() {
		
		if (getConfig() == null) {
			return null;
		}
		
		if (!stateBeanConfigsLoaded) {
			for (Iterator iterator = stateBeanRefs.iterator(); iterator.hasNext();) {
				String name = (String) iterator.next();
				StateBeanConfig stateBeanConfig = getConfig().getStateBeanConfig(name);
				stateBeanConfigs.add(stateBeanConfig);
			}
			stateBeanConfigsLoaded = true;
		}
		return stateBeanConfigs.iterator();
	}
	
	public Iterator getParameterConfigs() {
		return parameterConfigs.iterator();
	}
	
	public void addParameterConfig(ServiceMethodParameterConfig parameterConfig) {
		parameterConfigs.add(parameterConfig);
	}

	public Iterator getAccessConstraintConfigs() {
		return accessConstraintConfigs.iterator();
	}
	
	public void addAccessConstraintConfig(ServiceMethodAccessConstraintConfig config) {
		accessConstraintConfigs.add(config);
	}

	public Iterator getResultFilterConfigs() {
		if (getServiceConfig() == null) {
			return null;
		}
		return resultFilterConfigs.iterator();
	}

	public void  addResultFilterConfig(FilterConfig resultFilterConfig) {
		resultFilterConfigs.add(resultFilterConfig);
	}

	public OpenAMFConfig getConfig() {
		if (getServiceConfig() == null) {
			return null;
		}
		return getServiceConfig().getConfig();
	}
	
	public ServiceConfig getServiceConfig() {
		return serviceConfig;
	}
	
	public void setServiceConfig(ServiceConfig serviceConfig) {
		this.serviceConfig = serviceConfig;
	}

	public String toString() {
		
		if (getServiceConfig() == null) {
			return super.toString();
		}
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("\tName: ");
		sb.append(getName());
		sb.append('\n');

		sb.append("\t-----------------\n");
		sb.append("\tSTATE BEANS\n");
		sb.append("\t-----------------\n");
		for (Iterator i = getStateBeanConfigs(); i.hasNext();) {
			StateBeanConfig sbc = (StateBeanConfig)i.next();
			sb.append(sbc.getName());
		}
		
		sb.append("\t-----------------\n");
		sb.append("\tPARAMETERS\n");
		sb.append("\t-----------------\n");
		for (Iterator i = getParameterConfigs(); i.hasNext();) {
			ServiceMethodParameterConfig smpc = (ServiceMethodParameterConfig)i.next();
			sb.append(smpc);
		}

		sb.append("\t-----------------\n");
		sb.append("\tRESULT FILTERS:\n");
		sb.append("\t-----------------\n");
		for (Iterator i = getResultFilterConfigs(); i.hasNext();) {
			FilterConfig fc = (FilterConfig)i.next();
			sb.append(fc);
		}

		sb.append("\t-----------------\n");
		sb.append("\tACCESS CONSTRAINTS:\n");
		sb.append("\t-----------------\n");
		for (Iterator i = getAccessConstraintConfigs(); i.hasNext();) {
			sb.append(i.next());
		}
		return sb.toString();
	}

}
