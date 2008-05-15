/*
 * www.openamf.org
 * 
 * Distributable under LGPL license. See terms of license at gnu.org.
 */

package org.openamf.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author Jason Calabrese <mail@jasoncalabrese.com>
 * @version $Revision: 1.9 $, $Date: 2004/02/06 02:49:00 $
 */
public class OpenAMFConfig {

    private static Log log = LogFactory.getLog(OpenAMFConfig.class);
    private static OpenAMFConfig config;

    private Map serviceConfigs = new HashMap();
    private List customClassMappingConfigs = new ArrayList();
    private PageableRecordsetConfig pageableRecordsetConfig;
    private List serviceInvokerConfigs = new ArrayList();
    private Map stateBeanConfigs = new HashMap();
    private AMFSerializerConfig amfSerializerConfig = new AMFSerializerConfig();

    private OpenAMFConfig() {
        //no public create
    }

    public static synchronized OpenAMFConfig getInstance() {
        if (config == null) {
            config = new OpenAMFConfig();
        }
        return config;
    }

    public void addServiceInvokerConfig(ServiceInvokerConfig serviceInvokerConfig) {
        serviceInvokerConfigs.add(serviceInvokerConfig);
    }

    public ServiceInvokerConfig getServiceInvokerConfig(String name) {

        ServiceInvokerConfig serviceInvokerConfig = null;

        for (Iterator i = getServiceInvokerConfigs(); i.hasNext();) {
            ServiceInvokerConfig sic = (ServiceInvokerConfig) i.next();
            if (sic.getName().equals(name)) {
                serviceInvokerConfig = sic;
                break;
            }
        }
        return serviceInvokerConfig;
    }

    public Iterator getServiceInvokerConfigs() {
        return serviceInvokerConfigs.iterator();
    }

    public void addCustomClassMappingConfig(CustomClassMappingConfig customClassMappingConfig) {
        customClassMappingConfigs.add(customClassMappingConfig);
    }

    public Iterator getCustomClassMappingConfigs() {
        return customClassMappingConfigs.iterator();
    }

    public String getCustomClassName(String javaClassName) {
        String customClassName = null;

        for (Iterator i = customClassMappingConfigs.iterator(); i.hasNext();) {
            CustomClassMappingConfig ccm = (CustomClassMappingConfig) i.next();

            if (ccm.getJavaClassName().equals(javaClassName)) {
                customClassName = ccm.getCustomClassName();
                break;
            }
        }

        return customClassName;
    }

    public String getJavaClassName(String customClassName) {
        String javaClassName = null;

        for (Iterator i = customClassMappingConfigs.iterator(); i.hasNext();) {
            CustomClassMappingConfig ccm = (CustomClassMappingConfig) i.next();

            if (ccm.getCustomClassName().equals(customClassName)) {
                javaClassName = ccm.getJavaClassName();
                break;
            }
        }

        return javaClassName;
    }

    public PageableRecordsetConfig getPageableRecordsetConfig() {
        return pageableRecordsetConfig;
    }

    public void setPageableRecordsetConfig(PageableRecordsetConfig pageableRecordsetConfig) {
        this.pageableRecordsetConfig = pageableRecordsetConfig;
    }

    public void addServiceConfig(ServiceConfig serviceConfig) {
        serviceConfig.setConfig(this);
        serviceConfigs.put(serviceConfig.getName(), serviceConfig);
    }

    public ServiceConfig getServiceConfig(String name) {
        return (ServiceConfig) serviceConfigs.get(name);
    }

    public Iterator getServiceConfigs() {
        return serviceConfigs.values().iterator();
    }

    public void addStateBeanConfig(StateBeanConfig stateBeanConfig) {
        stateBeanConfigs.put(stateBeanConfig.getName(), stateBeanConfig);
    }

    public StateBeanConfig getStateBeanConfig(String name) {
        return (StateBeanConfig) stateBeanConfigs.get(name);
    }

    public Iterator getStateBeanConfigs() {
        return stateBeanConfigs.values().iterator();
    }

    public AMFSerializerConfig getAMFSerializerConfig() {
        return amfSerializerConfig;
    }

    public void setAMFSerializerConfig(AMFSerializerConfig config) {
        this.amfSerializerConfig = config;
    }

    public String toString() {

        StringBuffer sb = new StringBuffer();

        sb.append("\n=================\n");
        sb.append("SERVICE INVOKERS\n");
        sb.append("=================\n");
        for (Iterator i = getServiceInvokerConfigs(); i.hasNext();) {
            ServiceInvokerConfig sic = (ServiceInvokerConfig) i.next();
            sb.append(sic);
        }

        sb.append("\n=======================\n");
        sb.append("CUSTOM CLASS MAPPINGS\n");
        sb.append("=======================\n");
        for (Iterator i = getCustomClassMappingConfigs(); i.hasNext();) {
            CustomClassMappingConfig ccm = (CustomClassMappingConfig) i.next();
            sb.append(ccm);
        }

        sb.append("\n=======================\nPageableRecordsetConfig\n");
        sb.append("=======================\n");
        sb.append(pageableRecordsetConfig);

        sb.append("\n=======================\nAMFSerializerConfig\n");
        sb.append("=======================\n");
        sb.append(amfSerializerConfig);

        sb.append("\n=========\n");
        sb.append("SERVICES\n");
        sb.append("=========\n");
        for (Iterator i = getServiceConfigs(); i.hasNext();) {
            ServiceConfig sc = (ServiceConfig) i.next();
            sb.append(sc);
        }

        sb.append("\n=========\n");
        sb.append("STATE BEANS\n");
        sb.append("=========\n");
        for (Iterator i = getStateBeanConfigs(); i.hasNext();) {
            StateBeanConfig sbc = (StateBeanConfig) i.next();
            sb.append(sbc);
        }

        return sb.toString();
    }

}
