/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.config;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.4 $, $Date: 2003/08/09 16:59:22 $
 */
public class FilterConfig {

	private String className;
	private List parameterConfigs = new ArrayList();

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public Iterator getParameterConfigs() {
		return parameterConfigs.iterator();
	}

	public void addParameterConfig(FilterParameterConfig parameterConfig) {
		parameterConfigs.add(parameterConfig);
	}

	public String toString() {

		StringBuffer sb = new StringBuffer();

		sb.append("\t\tClass Name: ");
		sb.append(getClassName());
		sb.append('\n');

		sb.append("\t\t-----------------\n");
		sb.append("\t\tPARAMETERS\n");
		sb.append("\t\t-----------------\n");
		for (Iterator i = getParameterConfigs(); i.hasNext();) {
			FilterParameterConfig tpc =
				(FilterParameterConfig) i.next();
			sb.append(tpc);
		}

		return sb.toString();
	}

	public String[] getParameterValues(String name) {

		List tempList = new ArrayList();
		for (Iterator iter = parameterConfigs.iterator(); iter.hasNext();) {
			FilterParameterConfig parameterConfig =
				(FilterParameterConfig) iter.next();
			if (parameterConfig.getName().equals(name)) {
				tempList.add(parameterConfig.getValue());
			}
		}
		
		String[] values = new String[tempList.size()];
		values = (String[])tempList.toArray(values);

		return values;
	}

}
