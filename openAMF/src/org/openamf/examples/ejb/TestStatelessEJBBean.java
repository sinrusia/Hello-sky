/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.examples.ejb;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @author Roberto Saccon <saccon@users.sourceforge.net>
 * @ejb.bean name="TestStatelessEJB"
 *	jndi-name="TestStatelessEJBBean"
 *	type="Stateless" 
**/
public class TestStatelessEJBBean implements SessionBean {

	private static Log log = LogFactory.getLog(TestStatelessEJBBean.class);
	private SessionContext sessionContext;
	private int invokeCount;

	/**
	 * @ejb:create-method
	 */
	public void ejbCreate() throws CreateException {
		log.debug("TestStatelessEJBBean ejbCreate() invoked");
		sessionContext = null;
		invokeCount = 0;
	}

	/**
	 * @ejb.interface-method
	 *	view-type="remote" 
	**/
	public String getEcho(String value) {
		invokeCount++;
		log.debug("TestStatelessEJBBean value: " + value + "; invokeCount = " + invokeCount);
		return "TestStatelessEJBBean: " + value + "; invokeCount = " + invokeCount;
	}

	// -------------------------------------------------------------------------
	// Framework Callbacks
	// -------------------------------------------------------------------------
	public void setSessionContext(SessionContext sessionContext)
		throws EJBException {
		log.debug("TestStatelessEJBBean.setSessionContext: " + sessionContext);
		this.sessionContext = sessionContext;
	}

	public void ejbActivate() throws EJBException {
	}

	public void ejbPassivate() throws EJBException {
	}

	public void ejbRemove() throws EJBException {
	}

}
