/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf;

import java.io.Serializable;

/**
 * AMF Header
 *
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @author Pat Maddox <pergesu@users.sourceforge.net>
 * @see AMFBody
 * @see AMFMessage
 * @version $Revision: 1.8 $, $Date: 2003/08/16 13:11:16 $
 */
public class AMFHeader implements Serializable {
    protected String key;
    protected boolean required;
    protected Object value;

    public AMFHeader(String key, boolean required, Object value) {
        this.key = key;
        this.required = required;
        this.value = value;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public boolean isRequired() {
        return required;
    }

    public void setRequired(boolean required) {
        this.required = required;
    }

    public Object getValue() {
        return value;
    }

    public void setValue(Object value) {
        this.value = value;
    }

    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("[AMFHeader: {key=");
        sb.append(key);
        sb.append(", required=");
        sb.append(required);
        sb.append(", value=");
        sb.append(value);
        sb.append("}]");
        return sb.toString();
    }

}
