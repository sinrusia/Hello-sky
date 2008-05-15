/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.filter;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openamf.config.FilterConfig;
import org.openamf.recordset.ASRecordSet;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.9 $, $Date: 2003/08/15 18:52:08 $
 */
public class BeanListToRecordSet implements ResultFilter {

	private static Log log = LogFactory.getLog(BeanListToRecordSet.class);

	public Object filter(Object value, FilterConfig config)
		throws FilterException {

		log.info("Translating BeanListToRecordSet");

		ASRecordSet recordSet = null;
		List list = null;
		if (value instanceof List) {
			list = (List) value;
		} else if (value instanceof Iterator) {
			Iterator iterator = (Iterator) value;
			list = new ArrayList();
			while (iterator.hasNext()) {
				list.add(iterator.next());
			}
		} else {
			throw new FilterException("value is not an instance of List or Iterator: "
                    + ((value!=null) ? value.getClass().getName() : "null"));

		}

		recordSet = processList(list, config);

		return recordSet;
	}

	private ASRecordSet processList(List list, FilterConfig config)
		throws FilterException {
		ASRecordSet recordSet;

		recordSet = new ASRecordSet();
		if (list.size() > 0) {
			String[] ignoreProperties = config.getParameterValues("ignore");
			try {
				recordSet.populate(list, ignoreProperties);
			} catch (Exception e) {
				throw new FilterException(e);
			}
		}
		return recordSet;
	}

}
