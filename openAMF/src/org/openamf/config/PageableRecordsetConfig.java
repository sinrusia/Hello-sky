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
public class PageableRecordsetConfig {
	
	private int initialDataRowCount;

	public int getInitialDataRowCount() {
		return initialDataRowCount;
	}

	public void setInitialDataRowCount(int initialDataRowCount) {
		this.initialDataRowCount = initialDataRowCount;
	}

	public String toString() {
		return "initialDataRowCount: " + initialDataRowCount;
	}

}
