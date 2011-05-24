package org.fx.toby_Lesson1;

import java.sql.SQLException;

import org.fx.toby_Lesson1.user.dao.ConnectionMaker;
import org.fx.toby_Lesson1.user.dao.DConnectionMaker;
import org.fx.toby_Lesson1.user.dao.UserDao;
import org.fx.toby_Lesson1.user.domain.User;
import org.junit.Before;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Unit test for simple App.
 */
public class AppTest 
    extends TestCase
{
	private UserDao dao;
	
	@Before
	private void initDao(){
		ConnectionMaker connectionMaker = new DConnectionMaker();
		dao = new UserDao(connectionMaker);
	}
	
	@org.junit.Test
	private void testAddUser() throws ClassNotFoundException, SQLException{
		User user = new User();
		user.setId("user2");
		user.setName("Jae Hag");
		user.setPassword("1234");
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		assertEquals("user", user.getId(), user2.getId());
		
	}
}
