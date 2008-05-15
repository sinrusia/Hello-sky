/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.filter;

import org.apache.commons.lang.exception.NestableException;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.5 $, $Date: 2003/08/09 16:59:23 $
 */
public class FilterException extends NestableException {
	
	public FilterException(String message) {
		super(message);
	}

	public FilterException(Throwable cause) {
		super(cause);
	}

	public FilterException(String message, Throwable cause) {
		super(message, cause);
	}
	
}
