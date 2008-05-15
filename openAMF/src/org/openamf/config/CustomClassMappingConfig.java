/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.config;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.5 $, $Date: 2003/09/10 23:18:07 $
 */
public class CustomClassMappingConfig {

	private String javaClassName;
	private String customClassName;

	public String getJavaClassName() {
		return javaClassName;
	}

	public void setJavaClassName(String javaClassName) {
		this.javaClassName = javaClassName;
	}

	public String getCustomClassName() {
		return customClassName;
	}

	public void setCustomClassName(String customClassName) {
		this.customClassName = customClassName;
	}

	public String toString() {
		return "javaClassName: "
			+ javaClassName
			+ "\ncustomClassName: "
			+ customClassName + "\n";
	}
}
