/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.config;

/**
 * Method access constraint configuration
 *
 * @version $Revision: 1.3 $, $Date: 2003/08/09 16:59:22 $
 */
public class ServiceMethodAccessConstraintConfig {
	
	private String roleName;
	
	public String getRoleName() {
		return roleName; 
	}
	
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String toString() {
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("\t\t\tRoleName: ");
		sb.append(getRoleName());
		sb.append('\n');

		return sb.toString();
	}

}
