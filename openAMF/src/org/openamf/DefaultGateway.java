/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf;

import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.ResultSet;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.lang.StringUtils;
import org.openamf.config.OpenAMFConfig;
import org.openamf.config.ConfigDigester;
import org.openamf.config.ServiceInvokerConfig;
import org.openamf.invoker.ServiceInvocationException;
import org.openamf.invoker.ServiceInvoker;
import org.openamf.io.AMFDeserializer;
import org.openamf.io.AMFSerializer;
import org.openamf.recordset.ASRecordSet;

/**
 * This is the Default entry for all amf requests
 * 
 * When a request is recieved it will be deserialized, processed, and then the
 * response wil be serialized and sent to the client.
 * 
 * @author <a href="mailto:mail@jasoncalabrese.com">Jason Calabrese </a>
 * @author Sean C. Sullivan
 * 
 * @version $Revision: 1.65 $, $Date: 2005/07/05 22:04:06 $
 */
public class DefaultGateway extends HttpServlet {

	protected static Log log = LogFactory.getLog(DefaultGateway.class);
	protected static Log requestLog =
		LogFactory.getLog("org.openamf.REQUEST");
	protected static Log responseLog =
		LogFactory.getLog("org.openamf.RESPONSE");

	private static final String OPENAMF_CONFIG = "OPENAMF_CONFIG";

	public void init() throws ServletException {
		reloadConfig();
	}

	protected void initializeRequestContext(HttpServletRequest req, HttpServletResponse resp) {
		RequestContext.setHttpServletRequest(req);
		RequestContext.setHttpServletResponse(resp);
	}
	
	protected void clearRequestContext() {
		RequestContext.clear();
	}
	
	/**
	 * Main entry point for the servlet
	 *
	 * @throws ServletException
	 * @throws IOException
	 */
	public void service(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		
		initializeRequestContext(req, resp);
		
		AMFMessage requestMessage = null;
		AMFMessage responseMessage = null;
		
		try {
			requestMessage = deserializeAMFMessage(req);
			// if we are here it's a valid request
			RequestContext.setRequestMessage(requestMessage);

			if (requestLog.isDebugEnabled()) {
				requestLog.debug("REQUEST:\n" + requestMessage + "\n");
			} else if (requestLog.isInfoEnabled()) {
				requestLog.info(
					"REQUEST:\n" + requestMessage.getBodiesString() + "\n");
			}

			responseMessage = processMessage(req, requestMessage);

			if (responseLog.isDebugEnabled()) {
				responseLog.debug("RESPONSE:\n" + responseMessage + "\n");
			} else if (responseLog.isInfoEnabled()) {
				responseLog.info(
					"RESPONSE:\n" + responseMessage.getBodiesString() + "\n");
			}

			serializeAMFMessage(resp, responseMessage);

		} catch (java.io.EOFException ef){
			//Invalid Request: if some other service trys to ping the gateway, but
			// isn't have any valid amf packet.
			// useful for determining if the gateway is down.
			responseLog.info("INVALID_REQUEST:\n Empty service name\n");
		} catch (Exception e) {
			logRequestException(e, requestMessage);
		}
		finally {
			clearRequestContext();
		}
	}

	protected void logRequestException(Exception e, Object detail)
	{
		String msg = "Error in service"; 
		
		if (detail != null)
		{
			msg += ", detail=";
			msg += String.valueOf(detail);
		}
		
		if (e instanceof ServiceInvocationException)
		{
			ServiceInvocationException sie = (ServiceInvocationException) e;
			AMFBody body = sie.getAMFBody();
			ServiceRequest req = sie.getServiceRequest();
			
			if (body != null)
			{
				msg += ", AMFBody=";
				msg += String.valueOf(body);
			}
			
			if (req != null)
			{
				msg += ", ServiceRequest=";
				msg += String.valueOf(req);
			}
		}
		
		log.error(msg, e); 
	}


	/**
	 * Uses the AMFDeserializer to deserialize the request
	 * 
	 * @see org.openamf.io.AMFDeserializer
	 */
	protected AMFMessage deserializeAMFMessage(HttpServletRequest req)
		throws IOException {
		DataInputStream inputStream = new DataInputStream(req.getInputStream());

		AMFDeserializer deserializer = new AMFDeserializer(inputStream);
		AMFMessage message = deserializer.getAMFMessage();
		return message;
	}

	/**
	 * Uses the AMFSerializer to serialize the request
	 *
	 * @see org.openamf.io.AMFSerializer
	 */
	protected void serializeAMFMessage(
		HttpServletResponse resp,
		AMFMessage message)
		throws IOException {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		DataOutputStream dos = new DataOutputStream(baos);
		AMFSerializer serializer = new AMFSerializer(dos);
		serializer.serializeMessage(message);
		resp.setContentType("application/x-amf");
		resp.setContentLength(baos.size());
		ServletOutputStream sos = resp.getOutputStream();
		baos.writeTo(sos);
		sos.flush();
	}

	/**
	 * Iterates through the request message's bodies, invokes each body and
	 * then, builds a message to send as the results
	 */
	protected AMFMessage processMessage(
		HttpServletRequest req,
		AMFMessage message) {
		AMFMessage responseMessage = new AMFMessage();
		for (Iterator bodies = message.getBodies(); bodies.hasNext();) {
			AMFBody requestBody = (AMFBody) bodies.next();
			// invoke
			Object serviceResult = invokeBody(req, requestBody);
			String target = getTarget(requestBody, serviceResult);
			AMFBody responseBody = new AMFBody(target, "null", serviceResult);
			responseMessage.addBody(responseBody);
		}
		return responseMessage;
	}

	protected Object invokeBody(HttpServletRequest req, AMFBody requestBody) {
		Object serviceResult = null;
		try {
			ServiceInvoker serviceInvoker = getServiceInvoker(requestBody, req);
			if (serviceInvoker == null) {
				throw new ServiceInvocationException(
					requestBody,
					new Exception("No service for '"
						+ requestBody.getServiceName()
					    + "'"));
			}
			preInvokeService(req, serviceInvoker);
			serviceResult = serviceInvoker.invokeService();
			serviceResult =
				postInvokeService(req, serviceInvoker, serviceResult);
		} catch (ServiceInvocationException e) {
			serviceResult = e.getAMFError();
			logRequestException(e, requestBody);
		}
		return serviceResult;
	}


	private String getTarget(AMFBody requestBody, Object serviceResult) {
		String target = "/onResult";
		if (serviceResult instanceof AMFError) {
			target = "/onStatus";
		}
		return requestBody.getResponse() + target;
	}

	/**
	 * Called before a body is invoked, if the selected invoker is a persistent
	 * service it's persistent service object will be looked up in the session
	 * 
	 * @throws ServiceInvocationException
	 */
	protected void preInvokeService(
		HttpServletRequest httpServletRequest,
		ServiceInvoker serviceInvoker)
		throws ServiceInvocationException {

		if (serviceInvoker.getPersistService()) {
			Object persistentServiceObject =
				httpServletRequest.getSession().getAttribute(
					serviceInvoker.getPersistentServiceName());

			serviceInvoker.setPersistentServiceObject(persistentServiceObject);
		}
	}

	/**
	 * Called after the body is invoked, if the selected invoker is a persistant
	 * service it's persistent service object will be stored in the session
	 * 
	 * @throws ServiceInvocationException
	 */
	protected Object postInvokeService(
		HttpServletRequest httpServletRequest,
		ServiceInvoker serviceInvoker,
		Object serviceResult)
		throws ServiceInvocationException {

		if (serviceInvoker.getPersistService()) {
			httpServletRequest.getSession().setAttribute(
				serviceInvoker.getPersistentServiceName(),
				serviceInvoker.getPersistentServiceObject());
		}

		serviceResult =
			processRecordSet(httpServletRequest, serviceInvoker, serviceResult);

		return serviceResult;
	}

	private Object processRecordSet(
		HttpServletRequest httpServletRequest,
		ServiceInvoker serviceInvoker,
		Object serviceResult)
		throws ServiceInvocationException {

		if (serviceResult instanceof ResultSet) {
			ASRecordSet asRecordSet = new ASRecordSet();
			try {
				asRecordSet.populate((ResultSet) serviceResult);
				serviceResult = asRecordSet;
			} catch (IOException e) {
				throw new ServiceInvocationException(
					serviceInvoker.getRequest(),
					e);
			}
		}

		if (serviceResult instanceof ASRecordSet) {
			ASRecordSet asRecordSet = (ASRecordSet) serviceResult;
			if (asRecordSet.getTotalCount()
				> asRecordSet.getInitialData().size()) {
				httpServletRequest.getSession().setAttribute(
					asRecordSet.getId(),
					asRecordSet);
			}
		}

		return serviceResult;
	}

	/**
	 * This method is used to find the correct invoker for the request. By
	 * default it just iterates over the service invokers defined in
	 * openamf-config.xml and calls it's supports method.
	 * 
	 * @see org.openamf.invoker.ServiceInvoker#supports(org.openamf.invoker.ServiceInvoker)
	 */
	protected ServiceInvoker getServiceInvoker(
		AMFBody requestBody,
		HttpServletRequest httpServletRequest)
		throws ServiceInvocationException {

		ServiceInvoker serviceInvoker = null;
		ServiceRequest request = new ServiceRequest(requestBody);

		try {
			for (Iterator i =
				OpenAMFConfig.getInstance().getServiceInvokerConfigs();
				i.hasNext();
				) {

				ServiceInvokerConfig invokerConfig =
					(ServiceInvokerConfig) i.next();
				log.debug(
					"Checking if the "
						+ invokerConfig.getName()
						+ " Service Invoker can support the request");
				ServiceInvoker tempInvoker =
					ServiceInvoker.load(
						invokerConfig.getClassName(),
						request,
						httpServletRequest,
						getServletContext());

				if (tempInvoker.supports(request)) {
					serviceInvoker = tempInvoker;
					serviceInvoker.prepare(request);
					log.debug(invokerConfig.getName() + ": YES");
					break;
				} else {
					log.debug(invokerConfig.getName() + ": NO");
				}
			}
		} catch (Exception e) {
			throw new ServiceInvocationException(request, e);
		}

		return serviceInvoker;
	}

	/**
	 * Loads/Reloads OpenAMF COnfiguration from the openamf-config.xml file
	 *
	 * @return
	 */
	protected OpenAMFConfig reloadConfig() {
		OpenAMFConfig config = OpenAMFConfig.getInstance();
		ConfigDigester configDigester = new ConfigDigester();
		configDigester.setUseContextClassLoader(true);

		String configParam =
			getServletConfig().getInitParameter(OPENAMF_CONFIG);
		String[] configLocations = StringUtils.split(configParam, ",");

		try {
			for (int i = 0; i < configLocations.length; i++) {
				String configLocation = configLocations[i];
				InputStream inputStream =
					getServletContext().getResourceAsStream(configLocation);
				configDigester.clear();
				configDigester.push(config);
				configDigester.parse(inputStream);
			}
		} catch (Exception e) {
			log.error("Reload config error", e);
		}

		if (log.isInfoEnabled()) {
			log.info(config);
		}
		return config;
	}

	public String getServletInfo() {
		return "OpenAMF DefaultGateway servlet, http://www.openamf.org/";
	}
}
