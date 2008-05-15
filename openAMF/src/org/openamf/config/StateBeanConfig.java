/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.config;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.7 $, $Date: 2003/08/09 16:59:22 $
 */
public class StateBeanConfig {
	
	private String name;
	private String className;
	private String scope;
	
		
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
	
	public String getScope() {
		return scope;
	}
	
	public void setScope(String scope) {
		this.scope = scope;
	}
	
	public boolean isSessionScope() {
		return scope.toLowerCase().equals("session");
	}

	public boolean isApplicationScope() {
		return scope.toLowerCase().equals("application");
	}

	public String toString() {
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("Name: ");
		sb.append(getName());
		sb.append('\n');
		
		sb.append("Class Name: ");
		sb.append(getClassName());
		sb.append('\n');
		
		sb.append("Scope: ");
		sb.append(getScope());
		sb.append('\n');
		
		return sb.toString();
	}


}
