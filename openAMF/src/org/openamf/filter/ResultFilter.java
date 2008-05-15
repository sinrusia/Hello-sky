/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.filter;

import org.openamf.config.FilterConfig;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.4 $, $Date: 2003/08/09 16:59:23 $
 */
public interface ResultFilter {
	
	public Object filter(Object value, FilterConfig config) throws FilterException;

}
