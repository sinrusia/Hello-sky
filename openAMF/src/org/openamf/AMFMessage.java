/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.io.Serializable;

/**
 * AMF Message
 *
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @author Pat Maddox <pergesu@users.sourceforge.net>
 * @see AMFHeader
 * @see AMFBody
 * @version $Revision: 1.13 $, $Date: 2003/11/30 02:25:00 $
 */
public class AMFMessage implements Serializable {
    private static final int CURRENT_VERSION = 0;

    /**
     * version
     */
    protected int version = CURRENT_VERSION;
    /**
     * The headers
     */
    protected List headers = new ArrayList();

    /**
     * The body objects
     */
    protected List bodies = new ArrayList();

    public void addHeader(String key, boolean required, Object value) {
        addHeader(new AMFHeader(key, required, value));
    }

    public void addHeader(AMFHeader header) {
        headers.add(header);
    }

    public int getHeaderCount() {
        return headers.size();
    }

    public AMFHeader getHeader(int index) {
        return (AMFHeader) headers.get(index);
    }

    /**
     *  
     * @return a List that contains zero or more {@link AMFHeader} objects
     * 
     */
    public List getHeaders() {
        return headers;
    }

    public void addBody(String target, String response, Object value, byte type) {

        addBody(new AMFBody(target, response, value, type));
    }

    public void addBody(AMFBody body) {
        bodies.add(body);
    }

    public int getBodyCount() {
        return bodies.size();
    }

    public AMFBody getBody(int index) {
        return (AMFBody) bodies.get(index);
    }

    public Iterator getBodies() {
        return bodies.iterator();
    }

    public int getVersion() {
        return version;
    }

    public void setVersion(int version) {
        this.version = version;
    }
    
    public String getBodiesString() {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < bodies.size(); i++) {
			if (i > 0) {
				sb.append('\n');
			}
			AMFBody amfBody = (AMFBody) bodies.get(i);
			sb.append(amfBody);
		}
		return sb.toString();
    }

    /**
     * AMFMessage content
     * @return
     */
    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("[AMFMessage: {version=");
        sb.append(version);
		sb.append(", headers={");
		for (int i = 0; i < headers.size(); i++) {
			AMFHeader amfHeader = (AMFHeader) headers.get(i);
			sb.append(amfHeader);
		}
        sb.append("}, bodies={");
        for (int i = 0; i < bodies.size(); i++) {
            AMFBody amfBody = (AMFBody) bodies.get(i);
            sb.append(amfBody);
        }
        sb.append("}}]");
        return sb.toString();
    }

}
