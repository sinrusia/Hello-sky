/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * This class allows web applications to 
 * easily access the HttpServletRequest and HttpServletResponse objects.
 *
 * OpenAMF's RequestContext class was inspired by the example code 
 * in chapter 7 of "Flash Remoting: The Definitive Guide"
 * by Tom Muck.
 * 
 * This class uses thread local storage.
 *  
 * To learn more about thread local storage, read this 
 * article:
 *  <a href="http://www-106.ibm.com/developerworks/java/library/j-threads3.html">
 *  http://www-106.ibm.com/developerworks/java/library/j-threads3.html</a>
 *  
 * @author Sean C. Sullivan
 * 
 */
public class RequestContext
{
	static private ThreadLocal httpRequestLocal = new ThreadLocal();
	static private ThreadLocal httpResponseLocal = new ThreadLocal();
	static private ThreadLocal requestMsgLocal = new ThreadLocal();
	
    private RequestContext()
    {
        // private constructor
    }
    
    /**
     *  
     * @param req the servlet request object
     * 
     * @see #getHttpServletRequest()
     * 
     */
    static public void setHttpServletRequest(HttpServletRequest req)
	{
    	httpRequestLocal.set(req);
    }

    /**
     *  
     * @param resp the servlet response object
     * 
     * @see #getHttpServletResponse()
     * 
     */
    static public void setHttpServletResponse(HttpServletResponse resp)
	{
    	httpResponseLocal.set(resp);
    }

    /** 
     * 
     * clears the request context data
     *
     */
    static public void clear()
	{
    	httpRequestLocal.set(null);
    	httpResponseLocal.set(null);
    	requestMsgLocal.set(null);
    }
    
    /**
     * 
     * 
     * @return may return null
     * 
     * @see #setHttpServletRequest(HttpServletRequest)
     * 
     */
    static public HttpServletRequest getHttpServletRequest()
	{
    	HttpServletRequest req = (HttpServletRequest) httpRequestLocal.get();
    	return req;
    }

    /**
     * 
     * 
     * @return may return null
     * 
     * @see #setHttpServletResponse(HttpServletResponse)
     * 
     */
    static public HttpServletResponse getHttpServletResponse()
	{
    	HttpServletResponse resp = (HttpServletResponse) httpResponseLocal.get();
    	return resp;
    }
    

    /**
     *  
     * @return a non-null value
     *
     * @see #getHttpSession(boolean)
     * @see #getHttpServletRequest
     * 
     */
    static public HttpSession getHttpSession()
	{
    	return getHttpSession(true);
    }
    
    /**
     *  
     * @return may return null
     *
     * @param create
     * 
     * @see #getHttpSession()
     * @see #getHttpServletRequest
     * 
     */
    static public HttpSession getHttpSession(boolean create)
	{
    	HttpServletRequest req = getHttpServletRequest();
    	if (req == null)
    	{
    		throw new IllegalStateException("HttpServletRequest is null");
    	}
    	return req.getSession(create);
    }
    
    /**
     * 
     * @return may return null 
     * 
     */
    static public AMFMessage getRequestMessage()
    {
    	return (AMFMessage) requestMsgLocal.get();
    }

    /**
     * 
     */
    static public void setRequestMessage(AMFMessage m)
    {
    	requestMsgLocal.set(m);
    }

}
