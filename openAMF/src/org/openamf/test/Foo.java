/*
 * 
 * 
 */
package org.openamf.test;

import java.util.Date;

import org.openamf.examples.spring.IhaveName;

/**
 * 
 * @author Sean C. Sullivan
 *
 * 
 * 
 */
public class Foo implements IhaveName
{
	private String name;
	private Date d;
	private int i;
	private Bar b;
	private boolean ready;
	public Foo myFoo;
	
	public Foo()
	{
		name = "JamesFoo";
		d = new java.util.Date();
		i = 592;
		b = new Bar();
		ready = false;
	}
	
	public void setReady(boolean r)
	{
		ready = r;
	}
	
	public boolean isReady()
	{
		return ready;
	}
	
	public Bar getBarValue()
	{
		return b;
	}
	public void setName(String name)
	{
		this.name= name;
	}
	public void setBarValue(Bar b)
	{
		this.b = b;
	}
	
	public String getName()
	{
		return name;
	}
	public Foo getMyFoo()
	{
		return myFoo;
	}
	public void setMyFoo(Foo imyFoo)
	{
		myFoo =  imyFoo;
	}
	public Date getDateValue()
	{
		return d;
	}
	
	public int getIntValue()
	{
		return i;
	}
	
	
}
