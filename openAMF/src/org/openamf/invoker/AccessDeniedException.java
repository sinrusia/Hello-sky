/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.invoker;

import org.apache.commons.lang.exception.NestableException;

/**
  * Exception class for indicationg that a service may not be accessed.
  * @author Richard Kunze
  * @version $Revision: 1.4 $, $Date: 2003/08/09 16:59:22 $
  */

public class AccessDeniedException extends NestableException {

	public AccessDeniedException() {
		super();
	}

	public AccessDeniedException(String message) {
		super(message);
	}

	public AccessDeniedException(String message, Throwable cause) {
		super(message, cause);
	}

	public AccessDeniedException(Throwable cause) {
		super(cause);
	}

}
