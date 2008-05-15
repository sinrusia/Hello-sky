package org.openamf.util;

import junit.framework.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.math.BigDecimal;

import flashgateway.io.ASObject;

/**
 *  
 * 
 * unit test for {@link org.openamf.util.OpenAMFUtils}
 * 
 * @author Sean C. Sullivan
 *
 * 
 */
public class OpenAMFUtilsTest
  extends TestCase
{

  public OpenAMFUtilsTest(String name)
  {
    super(name);
  }

  public static Test suite()
  {
    TestSuite suite = new TestSuite(OpenAMFUtilsTest.class);
    return suite;
  }

  public void testDecodeStringParameter() throws Exception
  {
	String s = "hello world";
	Object param = s;
	Object decodedParam = OpenAMFUtils.decodeParameter(param, String.class);
	assertNotNull(decodedParam);
	assertTrue(decodedParam instanceof String);
	assertTrue( s.equals((String) decodedParam));
	
	assertTrue(OpenAMFUtils.typesMatch(String.class, s));
	assertTrue(OpenAMFUtils.typesMatch(String.class, param));
	assertTrue(OpenAMFUtils.typesMatch(String.class, decodedParam));
  }

  public void testDecodeDateParameter() throws Exception
  {
  	SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
  	
  	Date d = sdf.parse("12/20/1979");
  	
  	Object param = d;
  	Object decodedParam = OpenAMFUtils.decodeParameter(param, java.util.Date.class);
  	assertNotNull(decodedParam);
  	assertTrue(decodedParam instanceof java.util.Date);
  	Date decodedDate = (Date) decodedParam;
  	assertEquals(d.getTime(), decodedDate.getTime());
  }
  
  
  public void testDecodeDoubleParameter() throws Exception
  {
  	Double d = new Double(2.0);
  	
	Object decodedParam = OpenAMFUtils.decodeParameter(
								d, Double.class);
	
	assertTrue(decodedParam instanceof Double);
  }

  public void testDecodeNumberParameter() throws Exception
  {
  	Number n = new Integer(1053);
  	
	Object decodedParam = OpenAMFUtils.decodeParameter(
								n, Number.class);
	
	assertTrue(decodedParam instanceof Number);
  }


  public void testDecodeBigDecimalParameter() throws Exception
  {
  	BigDecimal bd = new BigDecimal("876.5432");
  	
	Object decodedParam = OpenAMFUtils.decodeParameter(
								bd, BigDecimal.class);
	
	assertTrue(decodedParam instanceof BigDecimal);
  }

  public void testDecodeIntParameter() throws Exception
  {
  	Integer i = new Integer(5);
  	
  	Object decodedParam = OpenAMFUtils.decodeParameter(
  			i, Integer.TYPE);
  	
  	assertTrue(decodedParam instanceof Integer);
  }
  
  public void testDecodeShortParameter() throws Exception
  {
  	Short s = new Short( (short) 2);
  	
  	Object decodedParam = OpenAMFUtils.decodeParameter(
  			s, Short.TYPE);
  	
  	assertTrue(decodedParam instanceof Short);
  }


  public void testDecodeLongParameter() throws Exception
  {
  	Long l = new Long(9999);
  	
  	Object decodedParam = OpenAMFUtils.decodeParameter(
  			l, Long.TYPE);
  	
  	assertTrue(decodedParam instanceof Long);
  }

  public void testDecodeInterface() throws Exception
  {
	  IFoo f = new FooImpl();
	  
	  Object decodedParam = OpenAMFUtils.decodeParameter(f, IFoo.class);
	  
	  assertTrue(decodedParam instanceof IFoo);
	  
  }

   
  public void testDecodeInterface2() throws Exception
  {
	  ASObject aso = new ASObject();
	  aso.put("text", "Super");
	  aso.put("count", "5");
	  
	  Object decodedParam = OpenAMFUtils.decodeParameter(aso, FooImpl.class);
	  
	  assertTrue(decodedParam instanceof IFoo);
	  
  } 
  
  public static interface IFoo 
  {
	  public String getText();
	  public int getCount();
  }

  public static class FooImpl implements IFoo
  {
	  public FooImpl()
	  {
		  // empty
	  }
	  
	  public String getText()
	  {
		  return "hello";
	  }
	  
	  public int getCount()
	  {
		  return 10;
	  }
  }
  
}
