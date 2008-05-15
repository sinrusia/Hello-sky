/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.examples;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author Radoslaw Sliwinski <madlyr at users.sourceforge.net>
 * @version $Revision: 1.1 $, $Date: 2003/08/20 19:32:21 $
 */
public class RefsTester {
	
	private static Log log = LogFactory.getLog(RefsTester.class);
	
	public void testReferences(List refs) {
		
		log.debug("refs.size(): " + refs.size());

		if (refs.size() == 2) {
			log.debug("Object 1 = Object2 ?: " + refs.get(0).equals(refs.get(1)));
		}

		
	}

}
