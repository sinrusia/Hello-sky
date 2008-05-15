package org.openamf;

import org.apache.commons.logging.*;
import junit.framework.*;

/**
 * 
 * JUnit test case
 *
 */
public class AMFMessageTest
  extends TestCase
{
  private static final Log log = LogFactory.getLog(AMFMessageTest.class);

  public AMFMessageTest(String name)
  {
    super(name);
  }

  public static Test suite()
  {
    TestSuite suite = new TestSuite(AMFMessageTest.class);
    return suite;
  }

  public void setUp() throws Exception
  {
  }

  public void tearDown() throws Exception
  {
  }

  public void testAddHeader()
  {
    AMFMessage message = new AMFMessage();
    AMFHeader header = new AMFHeader("testKey1", true, "testValue1");
    message.addHeader(header);
    message.addHeader("testKey2", false, "testValue2");
    log.debug("Message is " + message);
    assertEquals(2, message.getHeaderCount());
    assertTrue(message.getHeaders().contains(header));
  }


  public void testAddBody()
  {
    AMFMessage message = new AMFMessage();
    AMFBody body = new AMFBody("someService.someMethod", "someResponse", "body value", AMFBody.DATA_TYPE_STRING);
    message.addBody(body);
    log.debug("Message is " + message);
    assertEquals(1, message.getBodyCount());
    assertEquals(body, message.getBody(0));
  }
  
  public void testVersion()
  {
  	final int iFiftySix = 56;
  	
  	final int iTwoHundred = 200;
  	
  	AMFMessage message = new AMFMessage();
  	
  	message.setVersion(iFiftySix);
  	
  	assertEquals(iFiftySix, message.getVersion());
  	
  	message.setVersion(iTwoHundred);
  	
  	assertEquals(iTwoHundred, message.getVersion());
 
  }
 
  public void testCount()
  {
  	AMFMessage message = new AMFMessage();
  	
  	assertEquals(0, message.getHeaderCount());
  	
  	assertEquals(0, message.getHeaders().size());
  	
  	assertEquals(0, message.getBodyCount());
  }
  
 
}
