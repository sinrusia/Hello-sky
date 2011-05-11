package org.fx;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Unit test for simple App.
 */
public class AppTest 
    extends TestCase
{
	@org.junit.Test
	public void testSaverPassword() throws Exception{
		UserRegister register = new UserRegister();
		
		String userId = "sweet88";
		String password = "potato";
		
		register.savePassword(userId, password);
		assertEquals(password, register.getPassword(userId));
	}
	
    /**
     * Create the test case
     *
     * @param testName name of the test case
     */
    public AppTest( String testName )
    {
        super( testName );
    }

    /**
     * @return the suite of tests being tested
     */
    public static Test suite()
    {
        return new TestSuite( AppTest.class );
    }

    /**
     * Rigourous Test :-)
     */
    public void testApp()
    {
        assertTrue( true );
    }
    
}
