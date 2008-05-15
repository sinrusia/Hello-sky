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
public class ServiceInvokerConfig {

	private String name;
	private String className;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String toString() {
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("Name: ");
		sb.append(getName());
		sb.append('\n');
		
		sb.append("Class Name: ");
		sb.append(getClassName());
		sb.append('\n');
		
		return sb.toString();
	}

}
