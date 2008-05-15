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
public class FilterParameterConfig {
	
	private String name;
	private String value;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String toString() {
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("\t\t\tName: ");
		sb.append(getName());
		sb.append('\n');
		
		sb.append("\t\t\tValue: ");
		sb.append(getValue());
		sb.append('\n');
		return sb.toString();
	}


}
