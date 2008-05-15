package org.openamf;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;

import junit.framework.Test;
import junit.framework.TestSuite;

import org.apache.cactus.ServletTestCase;
import org.apache.cactus.WebRequest;
import org.apache.cactus.WebResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openamf.io.AMFSerializer;

public class DefaultGatewayTest extends ServletTestCase {
	private static final Log log = LogFactory.getLog(DefaultGatewayTest.class);

	public DefaultGatewayTest(String name) {
		super(name);
	}

	public static Test suite() {
		TestSuite suite = new TestSuite(DefaultGatewayTest.class);
		return suite;
	}

	public void setUp() throws Exception {
	}

	public void tearDown() throws Exception {
	}

	public void beginDeserializeAMFMessage(WebRequest webRequest)
		throws Exception {
		AMFMessage message = new AMFMessage();
		message.addHeader("testKey", true, "testValue");
		message.addBody(
			"someService.someMethod",
			"someResponse",
			"body value",
			AMFBody.DATA_TYPE_STRING);

		ByteArrayOutputStream output = new ByteArrayOutputStream();
		AMFSerializer serializer =
			new AMFSerializer(new DataOutputStream(output));
		serializer.serializeMessage(message);

		webRequest.setUserData(new ByteArrayInputStream(output.toByteArray()));
	}

	public void testDeserializeAMFMessage() throws Exception {
		DefaultGateway gateway = new DefaultGateway();
		AMFMessage message = gateway.deserializeAMFMessage(request);
		assertEquals(1, message.getHeaderCount());
		assertEquals(1, message.getBodyCount());
		assertEquals("someService", message.getBody(0).getServiceName());
	}

	public void endDeserializeAMFMessage(WebResponse webResponse)
		throws Exception {

	}

}
