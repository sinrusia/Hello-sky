/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf;

import java.io.Serializable;

import flashgateway.io.ASObject;

/**
 * AMF Error object
 *
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.12 $, $Date: 2004/02/04 03:47:04 $
 */
public class AMFError extends ASObject implements Serializable {
    public static final String CODE = "code";
    public static final String LEVEL = "level";
    public static final String DESCRIPTION = "description";
    public static final String DETAILS = "details";
    public static final String TYPE = "type";
    public static final String LEVEL_ERROR = "error";
    public static final String LEVEL_STATUS = "status";
    public static final String LEVEL_WARNING = "warning";
    public static final String SERVER_PROCESSING = "SERVER.PROCESSING";
    public static final String SERVER_RESOURCE_NOTFOUND = "SERVER.RESOURCE_NOT_FOUND";
    public static final String SERVER_RESOURCE_UNAVAILABLE = "SERVER.RESOURCE_UNAVAILABLE";

    /**
     * Returns code
     * @return
     */
    public String getCode() {
        return (String) get(CODE);
    }

    public void setCode(String code) {
        put(CODE, code);
    }

    public void setLevel(String level) {
        put(LEVEL, level);
    }

    public void setDetails(String details) {
        put(DETAILS, details);
    }

    public void setDescription(String description) {
        put(DESCRIPTION, description);
    }

    public void setType(String type) {
        put(TYPE, type);
    }
    
    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("[AMFError: {");
        sb.append(super.toString());
        sb.append("}]");
        return sb.toString();
    }
}
