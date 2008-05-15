/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.invoker;

import java.lang.reflect.Method;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.commons.lang.exception.NestableException;
import org.openamf.AMFBody;
import org.openamf.AMFError;
import org.openamf.ServiceRequest;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @author Sylwester Lachiewicz <matrix@users.sourceforge.net>
 * @version $Revision: 1.21 $, $Date: 2004/08/04 05:15:44 $
 */
public class ServiceInvocationException extends NestableException {
    protected AMFBody requestBody;
    protected ServiceRequest request;

    public ServiceInvocationException(AMFBody requestBody, Throwable cause) {
        super(cause);
        this.requestBody = requestBody;
    }

    public ServiceInvocationException(ServiceRequest request, Throwable cause) {
        super(cause);
        this.request = request;
    }

    public AMFBody getAMFBody()
    {
    	return requestBody;
    }
    
    public ServiceRequest getServiceRequest()
    {
    	return request;
    }
    
    public AMFError getAMFError() {
        AMFError amfError = new AMFError();
        Throwable rootCause = getCause();
        amfError.setCode(getErrorValue(rootCause, "getCode", AMFError.SERVER_PROCESSING));
        amfError.setLevel(getErrorValue(rootCause, "getError", "error"));
        amfError.setType(rootCause.getClass().getName());
        amfError.setDetails(ExceptionUtils.getStackTrace(rootCause));
        amfError.setDescription(getErrorValue(rootCause, "getDescription", rootCause.getMessage()));
        return amfError;
    }

    private String getErrorValue(Throwable cause, String methodName, String defaultValue) {
        String value = null;
        try {
            Method method = cause.getClass().getMethod(methodName, new Class[0]);
            value = (String) method.invoke(cause, new Object[0]);
        } catch (Exception e) {
        }

        if (value == null) {
            value = defaultValue;
        }
        return value;
    }
}
