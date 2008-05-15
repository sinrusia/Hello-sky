/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.config;

/**
 * Contains configuration parameters for AMF message serialization
 *
 * @author Darin Wilson <darin@apmindsf.com>
 */
public class AMFSerializerConfig {

    private boolean forceLowerCaseKeys = true;

    public boolean forceLowerCaseKeys() {
        return forceLowerCaseKeys;
    }

    public void setForceLowerCaseKeys(boolean forceLowerCaseKeys) {
        this.forceLowerCaseKeys = forceLowerCaseKeys;
    }

    public String toString() {
        return "forceLowerCaseKeys: " + forceLowerCaseKeys;
    }

}
