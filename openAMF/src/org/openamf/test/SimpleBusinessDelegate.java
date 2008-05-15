/*
 * 
 * 
 */
package org.openamf.test;

import java.util.*;

/**
 * 
 * @author Sean C. Sullivan
 *
 */
public class SimpleBusinessDelegate
{
	
	public SimpleBusinessDelegate()
	{
	}
	
	public Foo getFavoriteFoo()
	{
		return new Foo();
	}
	
	public Bar getFavoriteBar()
	{
		return new Bar();
	}

	public List getListOfIntegers()
	{
		List l = new ArrayList();
		l.add(new Integer(1));
		l.add(new Integer(2));
		l.add(new Integer(3));
		return l;
	}
}
