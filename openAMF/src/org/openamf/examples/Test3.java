/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.examples;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.w3c.dom.Document;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.1 $, $Date: 2003/08/20 19:32:21 $
 */
public class Test3
{
	public Double getNumber(Double value)
	{
		return value;
	}

	public List getNumberArray(List value)
	{
		return value;
	}
	
	public String getString(String value)
	{
		return value;
	}

	public Date getDate(Date value)
	{
		return value;
	}
	
	public Document getXML(Document value)
	{
		return value;
	}

	public Map getPOJO(Map value)
	{
		return value;
	}	

}
