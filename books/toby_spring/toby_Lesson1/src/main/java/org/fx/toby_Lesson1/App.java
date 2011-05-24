package org.fx.toby_Lesson1;

import java.sql.SQLException;

import org.fx.toby_Lesson1.user.dao.ConnectionMaker;
import org.fx.toby_Lesson1.user.dao.DConnectionMaker;
import org.fx.toby_Lesson1.user.dao.UserDao;
import org.fx.toby_Lesson1.user.domain.User;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args ) throws ClassNotFoundException, SQLException
    {
    	ConnectionMaker connectionMaker = new DConnectionMaker();
    	UserDao dao = new UserDao(connectionMaker);
    	
    	User user = new User();
    	user.setId("sprig");
    	user.setName("Jae Hag");
    	user.setPassword("1234");
    	
    	dao.add(user);
    	
    	System.out.println(user.getId() + " success Register ");
    	
    	User user2 = dao.get(user.getId());
    	System.out.println(user2.getName());
    	System.out.println(user2.getPassword());
    	System.out.println("success search");
    	
    }
}
