/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.invoker;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openamf.ServiceRequest;
import org.openamf.recordset.ASRecordSet;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @author Matthew David Langston
 * @author Sean C. Sullivan
 * 
 * @version $Revision: 1.13 $, $Date: 2006/03/25 22:33:47 $
 * 
 */
public class PageableResultSetServiceInvoker extends ServiceInvoker {

	private static final Log log = LogFactory.getLog(PageableResultSetServiceInvoker.class);
	
	public PageableResultSetServiceInvoker(
		ServiceRequest request,
		HttpServletRequest httpServletRequest,
		ServletContext servletContext) {
		super(request, httpServletRequest, servletContext);
	}

	public Object invokeService() throws ServiceInvocationException {
		Object serviceResult = null;
		String serviceMethodName = request.getServiceMethodName();
		if (serviceMethodName.equalsIgnoreCase("getRecords")) {
			serviceResult = getRecords();
		} else if (serviceMethodName.equalsIgnoreCase("release")) {
			releaseRecordSet();
		}
		return serviceResult;
	}

	/**
	 * 
	 *  @return a java.util.Map object
	 *  
	 */
	private Object getRecords() {
		String rsId = (String)getRequest().getParameters().get(0);
		ASRecordSet recordSet = (ASRecordSet) getHttpServletRequest().getSession().getAttribute(rsId);
		
		if (recordSet == null)
		{
			return new java.util.HashMap();
		}
		
		int from = ((Number)getRequest().getParameters().get(1)).intValue() - 1;
		int count = ((Number)getRequest().getParameters().get(2)).intValue();
		
		//
		// 2004.09.06: Matthew D. Langston <langston@SLAC.Stanford.EDU>
		//
		// I was getting a java.lang.IndexOutOfBoundsException
		// exception when trying to find the RecordSet ID in the
		// session during this call:
		//
		//     String rsId = (String)getRequest().getParameters().get(0);
		//
		// The problem is that Macromedia doesn't send the RecordSet ID
		// when calling RecordSet.release() on the client, which meant
		// there was no request parameter, making the call to
		// getRequest().getParameters().get(0) throw the exception.
		//
		// The solution was to test whether all of the records have
		// been read, and then to remove the ASRecordSet from session
		// scope when they have. This needs to occur on the client's
		// last call to get the remaining records when we still have
		// access to the RecordSet ID.
		//
		// For more information, see the comment on lines 103-104 in
		// C:\Program Files\Macromedia\Flash MX 2004\en\First Run\Classes\mx\remoting\RecordSet.as:
		//
		//     "if id is non-null, there are more records still on the server.
		//     this therefore is a server-associated RecordSet"
		//
		Map records = recordSet.getRecords(from, count);
		int lastRecordIndex = from + count;
		if (lastRecordIndex == recordSet.getTotalCount())
		{
		    log.debug("sent record " + lastRecordIndex + " out of " + recordSet.getTotalCount());
		    log.debug("Releasing RecordSet " + rsId);
			getHttpServletRequest().getSession().removeAttribute(rsId);
		}
		if (lastRecordIndex > recordSet.getTotalCount())
		{
		    log.debug("session scope memory leak");
		}
		return records;
	}

	private void releaseRecordSet() {
		java.util.List parameters = getRequest().getParameters();
		if (parameters.size() > 0)
		{
			String rsId = (String) parameters.get(0);
			getHttpServletRequest().getSession().removeAttribute(rsId);
		}
	}

	public boolean supports(ServiceRequest request) {
		return ASRecordSet.SERVICE_NAME.equals(request.getServiceName());
	}

}
