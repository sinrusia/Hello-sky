/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.invoker;

import java.util.StringTokenizer;

import javax.servlet.GenericServlet;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.tools.ant.BuildEvent;
import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.BuildListener;
import org.apache.tools.ant.util.StringUtils;


/**
 * @author Adrian Roston <akroston@users.sourceforge.net >
 * @version $Revision: 1.1 $, $Date: 2003/11/29 17:04:04 $
 */
class WebServiceBuildLogger implements BuildListener {
    private GenericServlet servlet;
    private long startTime = System.currentTimeMillis();
    
    //use WebServiceInvoker's log since this class is package protected
	private static Log log = LogFactory.getLog(WebServiceInvoker.class);

    public void buildStarted(BuildEvent event) {
        startTime = System.currentTimeMillis();
        log.debug("build started");
    }

    public void buildFinished(BuildEvent event) {
        Throwable error = event.getException();
        StringBuffer message = new StringBuffer();

        if (error == null) {
            message.append(StringUtils.LINE_SEP);
            message.append("BUILD SUCCESSFUL");

        } else {
            message.append(StringUtils.LINE_SEP);
            message.append("BUILD FAILED");
            message.append(StringUtils.LINE_SEP);

            if (!(error instanceof BuildException)) {
                message.append(StringUtils.getStackTrace(error));

            } else {
                if (error instanceof BuildException) {
                    message.append(error.toString()).append(StringUtils.LINE_SEP);
                } else {
                    message.append(error.getMessage()).append(StringUtils.LINE_SEP);
                }
            }

        }
        message.append(StringUtils.LINE_SEP);
        message.append("Total time: ");
        message.append((System.currentTimeMillis() - startTime) / 1000);

		log.debug( message.toString());
    }

    public void messageLogged(BuildEvent event) {
        StringBuffer message = new StringBuffer();
        if (event.getTask() != null) {
            // Print out the name of the task if we're in one
            String name = event.getTask().getTaskName();
            String label = "[" + name + "] ";
            int size = 10 - label.length();
            StringBuffer tmp = new StringBuffer();
            for (int i = 0; i < size; i++) tmp.append(" ");
            tmp.append(label);
            label = tmp.toString();

            StringTokenizer tok = new StringTokenizer(event.getMessage(), "\r\n", false);
            boolean first = true;
            while (tok.hasMoreTokens()) {
                if (!first) message.append(StringUtils.LINE_SEP);
                first = false;
                message.append(label);
                message.append(tok.nextToken());
            }
        } else {
            message.append(event.getMessage());
        }
		log.debug(message.toString());
    }

	public void targetStarted(BuildEvent arg0) {
	}

	public void targetFinished(BuildEvent arg0) {
	}

	public void taskStarted(BuildEvent arg0) {
	}

	public void taskFinished(BuildEvent arg0) {
	}
}
