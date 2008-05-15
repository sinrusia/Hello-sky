/*
 * www.openamf.org
 * 
 * Distributable under LGPL license. See terms of license at gnu.org.
 */

package org.openamf.config;

import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.digester.Digester;
import org.xml.sax.SAXException;

/**
 * @author Jason Calabrese <mail@jasoncalabrese.com>
 * @version $Revision: 1.16 $, $Date: 2004/02/06 02:49:00 $
 */
public class ConfigDigester extends Digester {

    private static final String INVOKER_PATH = "config/invoker";
    private static final String CUSTOM_CLASS_MAPPING_PATH =
        "config/custom-class-mapping";
    private static final String PAGEABLE_RECORDSET_PATH =
        "config/pageable-recordset";
    private static final String SERVICE_PATH = "config/service";
    private static final String METHOD_PATH = SERVICE_PATH + "/method";
    private static final String METHOD_PARAM_PATH = METHOD_PATH + "/parameter";
    private static final String METHOD_ACCESS_CONSTRAINT_PATH =
        METHOD_PATH + "/access-constraint/role-name";
    private static final String RESULT_FILTER_PATH =
        METHOD_PATH + "/result-filter";
    private static final String RESULT_FILTER_PARAM_PATH =
        RESULT_FILTER_PATH + "/parameter";
    private static final String STATE_BEAN_PATH = "config/state-bean";
    private static final String AMFSERIALIZER_PATH = "config/amf-serializer";

    protected boolean configured = false;

    public Object parse(InputStream input) throws IOException, SAXException {
        configure();
        return (super.parse(input));

    }

    protected void configure() {
        if (configured) {
            return;
        }
        addInvokerRules();
        addCustomClassMappingRules();
        addPageableRecordSetRules();
        addServiceRules();
        addServiceMethodRules();
        addResultTranslatorRules();
        addStateBeanRules();
        addAMFSerializerRules();

        // Mark this digester as having been configured
        configured = true;
    }

    private void addInvokerRules() {
        addObjectCreate(INVOKER_PATH, ServiceInvokerConfig.class);
        addSetNext(
            INVOKER_PATH,
            "addServiceInvokerConfig",
            "org.openamf.config.ServiceInvokerConfig");
        addCallMethod(INVOKER_PATH + "/name", "setName", 0);
        addCallMethod(INVOKER_PATH + "/class", "setClassName", 0);
    }

    private void addCustomClassMappingRules() {
        addObjectCreate(
            CUSTOM_CLASS_MAPPING_PATH,
            CustomClassMappingConfig.class);
        addSetNext(
            CUSTOM_CLASS_MAPPING_PATH,
            "addCustomClassMappingConfig",
            "org.openamf.config.CustomClassMappingConfig");
        addCallMethod(
            CUSTOM_CLASS_MAPPING_PATH + "/java-class",
            "setJavaClassName",
            0);
        addCallMethod(
            CUSTOM_CLASS_MAPPING_PATH + "/custom-class",
            "setCustomClassName",
            0);
    }

    private void addPageableRecordSetRules() {
        addObjectCreate(PAGEABLE_RECORDSET_PATH, PageableRecordsetConfig.class);
        addSetNext(
            PAGEABLE_RECORDSET_PATH,
            "setPageableRecordsetConfig",
            "org.openamf.config.PageableRecordsetConfig");
        addCallMethod(
            PAGEABLE_RECORDSET_PATH + "/initial-data-row-count",
            "setInitialDataRowCount",
            0,
            new Class[] { Integer.TYPE });
    }

    private void addServiceRules() {
        addObjectCreate(SERVICE_PATH, ServiceConfig.class);
        addSetNext(
            SERVICE_PATH,
            "addServiceConfig",
            "org.openamf.config.ServiceConfig");
        addCallMethod(SERVICE_PATH + "/name", "setName", 0);
        addCallMethod(
            SERVICE_PATH + "/service-location",
            "setServiceLocation",
            0);
        addCallMethod(SERVICE_PATH + "/invoker-ref", "setServiceInvokerRef", 0);
    }

    private void addServiceMethodRules() {
        addObjectCreate(METHOD_PATH, ServiceMethodConfig.class);
        addSetNext(
            METHOD_PATH,
            "addMethodConfig",
            "org.openamf.config.ServiceMethodConfig");
        addCallMethod(METHOD_PATH + "/name", "setName", 0);
        addCallMethod(
            METHOD_PATH + "/state-bean-ref/name",
            "addStateBeanRef",
            0);
        addObjectCreate(METHOD_PARAM_PATH, ServiceMethodParameterConfig.class);
        addSetNext(
            METHOD_PARAM_PATH,
            "addParameterConfig",
            "org.openamf.config.ServiceMethodParameterConfig");
        addCallMethod(METHOD_PARAM_PATH + "/type", "setType", 0);

        addObjectCreate(
            METHOD_ACCESS_CONSTRAINT_PATH,
            ServiceMethodAccessConstraintConfig.class);
        addSetNext(
            METHOD_ACCESS_CONSTRAINT_PATH,
            "addAccessConstraintConfig",
            "org.openamf.config.ServiceMethodAccessConstraintConfig");
        addCallMethod(METHOD_ACCESS_CONSTRAINT_PATH, "setRoleName", 0);
    }

    private void addResultTranslatorRules() {
        addObjectCreate(RESULT_FILTER_PATH, FilterConfig.class);
        addSetNext(
            RESULT_FILTER_PATH,
            "addResultFilterConfig",
            "org.openamf.config.FilterConfig");
        addCallMethod(RESULT_FILTER_PATH + "/class", "setClassName", 0);
        addObjectCreate(RESULT_FILTER_PARAM_PATH, FilterParameterConfig.class);
        addSetNext(
            RESULT_FILTER_PARAM_PATH,
            "addParameterConfig",
            "org.openamf.config.FilterParameterConfig");
        addCallMethod(RESULT_FILTER_PARAM_PATH + "/name", "setName", 0);
        addCallMethod(RESULT_FILTER_PARAM_PATH + "/value", "setValue", 0);
    }

    private void addStateBeanRules() {
        addObjectCreate(STATE_BEAN_PATH, StateBeanConfig.class);
        addSetNext(
            STATE_BEAN_PATH,
            "addStateBeanConfig",
            "org.openamf.config.StateBeanConfig");
        addCallMethod(STATE_BEAN_PATH + "/name", "setName", 0);
        addCallMethod(STATE_BEAN_PATH + "/class", "setClassName", 0);
        addCallMethod(STATE_BEAN_PATH + "/scope", "setScope", 0);
    }

    private void addAMFSerializerRules() {
        addObjectCreate(AMFSERIALIZER_PATH, AMFSerializerConfig.class);
        addSetNext(
            AMFSERIALIZER_PATH,
            "setAMFSerializerConfig",
            "org.openamf.config.AMFSerializerConfig");
        addCallMethod(
            AMFSERIALIZER_PATH + "/force-lower-case-keys",
            "setForceLowerCaseKeys",
            0,
            new Class[] { Boolean.TYPE });
    }

}
