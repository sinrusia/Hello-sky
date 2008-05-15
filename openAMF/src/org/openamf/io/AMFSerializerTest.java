package org.openamf.io;

import java.io.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;
import org.xml.sax.InputSource;
import org.openamf.*;
import java.util.*;
import junit.framework.*;

public class AMFSerializerTest
  extends TestCase
{

  public AMFSerializerTest(String name)
  {
    super(name);
  }

  public static Test suite()
  {
    TestSuite suite = new TestSuite(AMFSerializerTest.class);
    return suite;
  }

  public void setUp() throws Exception
  {
  }

  public void tearDown() throws Exception
  {
  }

  public void testSerializeMessage() throws Exception
  {
    ByteArrayOutputStream output      = new ByteArrayOutputStream();
    AMFSerializer         serializer  = new AMFSerializer(new DataOutputStream(output));
    AMFMessage            message     = getTestMessage();
    serializer.serializeMessage(message);

    assertTrue(output.size() > 0);
    
    InputStream in = new ByteArrayInputStream(output.toByteArray());
    DataInputStream dis = new DataInputStream(in);
    AMFDeserializer deserializer = new AMFDeserializer(dis);
    AMFMessage deserializedMessage = deserializer.getAMFMessage();
    
    assertNotNull(deserializedMessage);
    
    assertNotNull(deserializedMessage.getBodies());
    
    assertEquals(message.getHeaderCount(),
    			deserializedMessage.getHeaderCount());

    assertEquals(message.getBodyCount(),
    			deserializedMessage.getBodyCount());
  
    assertEquals(message.getVersion(),
    			deserializedMessage.getVersion());
    
  }

  public void testSerializeLargeStringMessage() throws Exception
  {
    ByteArrayOutputStream output      = new ByteArrayOutputStream();
    AMFSerializer         serializer  = new AMFSerializer(new DataOutputStream(output));
    AMFMessage            message     = getLargeStringTestMessage(65536);
    serializer.serializeMessage(message);

    assertTrue(output.size() > 0);
    
    InputStream in = new ByteArrayInputStream(output.toByteArray());
    DataInputStream dis = new DataInputStream(in);
    AMFDeserializer deserializer = new AMFDeserializer(dis);
    AMFMessage deserializedMessage = deserializer.getAMFMessage();
    
    assertNotNull(deserializedMessage);
    
    assertNotNull(deserializedMessage.getBodies());
    
    assertEquals(message.getHeaderCount(),
          deserializedMessage.getHeaderCount());

    assertEquals(message.getBodyCount(),
          deserializedMessage.getBodyCount());
  
    assertEquals(message.getVersion(),
          deserializedMessage.getVersion());
          
    AMFBody sentBody = message.getBody(0);
    String sentString = (String)sentBody.getValue();
    AMFBody receivedBody = deserializedMessage.getBody(0);
    String receivedString = (String)receivedBody.getValue();
    assertEquals(sentString, receivedString);
  }

  private AMFMessage getTestMessage() throws Exception 
  {
    AMFMessage message = new AMFMessage();
    
    message.addHeader("testKey", true, "testValue");
    
    message.addBody("someService.someMethod", 
    				"someResponse", 
    				"body value", 
					AMFBody.DATA_TYPE_STRING);
    
    AMFBody bodyWithDate = new AMFBody("someService.someMethod",
    				"someResponse",
    				new java.util.Date(),
					AMFBody.DATA_TYPE_DATE);
    
    message.addBody(bodyWithDate);
    
    AMFBody bodyWithBoolean = new AMFBody("someService.someMethod",
    		"someResponse",
    		java.lang.Boolean.TRUE,
			AMFBody.DATA_TYPE_BOOLEAN);
    
    message.addBody(bodyWithBoolean);

    AMFBody bodyWithCharacter = new AMFBody("someService.someMethod",
    		"someResponse",
    		new Character('v'),
			AMFBody.DATA_TYPE_STRING);
    
    message.addBody(bodyWithCharacter);

    AMFBody bodyWithIntegerNumber = new AMFBody("someService.someMethod",
    		"someResponse",
			new Integer(387),
			AMFBody.DATA_TYPE_NUMBER);
    
    message.addBody(bodyWithIntegerNumber);

    Map foo = new HashMap();
    foo.put("key1", "value1");
    foo.put("key2", "value2");
    foo.put("3", "value3");
    AMFBody bodyWithMap = new AMFBody("someService.someMethod",
    		"someResponse",
			foo,
			AMFBody.DATA_TYPE_MIXED_ARRAY);
    
    message.addBody(bodyWithMap);
    
    AMFBody bodyWithDoubleNumber = new AMFBody("someService.someMethod",
    		"someResponse",
			new Double(387.582),
			AMFBody.DATA_TYPE_NUMBER);
    
    message.addBody(bodyWithDoubleNumber);

    AMFBody bodyWithObject = new AMFBody("someService.someMethod",
    		"someResponse",
			new org.openamf.test.Foo(),
			AMFBody.DATA_TYPE_OBJECT);
    
    message.addBody(bodyWithObject);
    
    AMFBody bodyWithXML = new AMFBody("someService.someMethod",
    		"someResponse",
    		getXMLDocument(),
			AMFBody.DATA_TYPE_XML);
    
    message.addBody(bodyWithXML);

     
    return message;

  }
  
  private AMFMessage getLargeStringTestMessage(int stringSize)
  {
    StringBuffer buf = new StringBuffer(stringSize);
    for (int i = 0; i < stringSize; i++)
    {
      buf.append("x");
    }
    
    AMFMessage message = new AMFMessage();
    
    message.addHeader("testKey", true, "testValue");
    
    message.addBody("someService.someMethod", 
            "someResponse", 
            buf.toString(), 
          AMFBody.DATA_TYPE_STRING);
    return message;
    
  }
  
  private org.w3c.dom.Document getXMLDocument() throws Exception
  {
  	//
  	// note: we are using \u00A3 in the String
  	//
  	//
  	
  	String strXML = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><foo><bar>Hello \u00A3</bar></foo>";
  	
  	Document document = null;
	DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	DocumentBuilder builder = factory.newDocumentBuilder();
	document = builder.parse(new InputSource(new StringReader(strXML)));
	
	return document;
  }
  
 
  
}
