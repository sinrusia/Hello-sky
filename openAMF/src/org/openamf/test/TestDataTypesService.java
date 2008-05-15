/*
 * Created on Jun 1, 2005
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package org.openamf.test;

import java.io.Serializable;
//import java.util.ArrayList;
//import java.util.Iterator;
//import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openamf.examples.Directory;
/**
 * @author Troy Gardner
 *
 * This tests object basic values when null or undefined, set to default, min and max and blank references
 * to see how they end up on the actionscript side. 
 * part b tests whether or not various self referential, cyclinc refernces and shared references are propogated to the
 * flash correctly.
 */
public class TestDataTypesService implements Serializable {
	protected static Log log = LogFactory.getLog(Directory.class);   

	public Object getTestData(Foo Tcase) {
		return Tcase;
	}
	public Object getTestData(String Tcase) {
		TestDataTypesBean tdbn = new TestDataTypesBean();
		if(Tcase.equals("null")){
			tdbn.initSampleDataNull();			
			return tdbn;
		}else if(Tcase.equals("empty")){
			tdbn.initSampleDataEmpty();
			return tdbn;
		}else if(Tcase.equals("min")){
			tdbn.initSampleDataMin();
			return tdbn;
		}else if(Tcase.equals("max")){
			tdbn.initSampleDataMax();
			return tdbn;
		}else if(Tcase.equals("nested")){
			Foo fA = new Foo();
			Bar bA = new Bar();
			fA.setBarValue(bA);
			return fA;
		}else if(Tcase.equals("selfref")){
			Foo fA = new Foo();
			fA.myFoo = fA;
			return fA;	
		}else if(Tcase.equals("refCyc")){
			Foo fA = new Foo();
			fA.setName("FooA");
			Foo fB = new Foo();
			fB.setName("FooB");
			fA.myFoo = fB;
			fB.myFoo = fA;
			return fA;	
		}else if(Tcase.equals("refV")){
			Foo fA = new Foo();
			fA.setName("FooA");
			Foo fB = new Foo();
			fB.setName("FooB");
			Foo fC = new Foo();
			fC.setName("FooC");
			fA.myFoo = fC;
			fB.myFoo = fC;
			Object[] oA = {fA, fB};
			return 	oA;	
		}
		return tdbn;
	}
}