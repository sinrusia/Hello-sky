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
public class Bar implements IhaveName
{
	private String name;
	private Date d;
	private int i;
	
	
	public Bar()
	{
		name = "BarBarBar";
		d = new java.util.Date();
		i = 921;
	}
	
	public void setName(String n)
	{
		name = n;
	}
	
	public String getName()
	{
		return name;
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
