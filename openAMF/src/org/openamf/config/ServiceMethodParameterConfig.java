/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.config;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.4 $, $Date: 2003/08/09 16:59:22 $
 */
public class ServiceMethodParameterConfig {
	
	private String type;
	
	public String getType() {
		return type; 
	}
	
	public void setType(String type) {
		this.type = type;
	}

	public String toString() {
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("\t\t\tType: ");
		sb.append(getType());
		sb.append('\n');

		return sb.toString();
	}


}
