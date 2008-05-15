/*
 * Created on Jun 30, 2005
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package org.openamf.examples;

/**
 * @author Troy Gardner
 *
 * To change the template for this generated type comment go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */

import java.beans.*;
import java.io.Serializable;
import java.util.HashMap;

public class Java2AS implements Serializable {

    private static Class collectionClass;

    static {
        try {
            collectionClass=Class.forName("java.util.Collection");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static void main(String args[]) {

        if (args.length==1) {
            generateAS(args[0]);
        } else {
            System.out.println("Invalid list of arguments");
            System.out.println("Usage: java Java2AS classname");
        }
    }
    public HashMap generateAS2(String javaClass) {
    	return Java2AS.generateAS(javaClass);
    }
    public static HashMap generateAS(String javaClass) {
        StringBuffer amfconfigSource=new StringBuffer();
        StringBuffer asSource=new StringBuffer();
        StringBuffer messages=new StringBuffer();
        try {
            Class c = Class.forName(javaClass);
            String className=c.getName();
            //c.getM
            ////////////////////////////////////////
            amfconfigSource.append("\n\t<custom-class-mapping>\n");
            amfconfigSource.append("\t   <java-class>"+className+"</java-class>\n");
            amfconfigSource.append("\t   <custom-class>"+className+"</custom-class>\n");
            amfconfigSource.append("</custom-class-mapping>\n");
            ////////////////////Create the Class///////////////////
            // Create a new instance using no-arg constructor.
            // An exception is thrown if there is no no-arg constructor
            c.newInstance();

            BeanInfo info=Introspector.getBeanInfo(c);
            PropertyDescriptor[] propertyDescriptors = info.getPropertyDescriptors();
            PropertyDescriptor pd=null;
            String propertyName=null;
            String propertyDisplayName=null;
            //-------------header comments------------------//
            asSource.append("\n\n/** \n");
            asSource.append("* see Java:"+className+" \n");
            asSource.append("*/\n\n");

            //---------start of class----------------------//
            Class suC = c.getSuperclass();
             asSource.append("//extends " +suC.getName() +" \n\n" );
		    Class[] i_ary = c.getInterfaces();
            if(i_ary != null){
            	for (int i = 0; i < i_ary.length; i++) {
                    Class ic =i_ary[i]; 
                        asSource.append("//implements " +ic.getName() +" \n\n" );
					
				}
            }
            
            asSource.append("class  "+className +" {\n\n" );
            
         
            //---------member variables -------------------//
            for (int i=0; i<propertyDescriptors.length; i++) {
                pd=propertyDescriptors[i];
                propertyName=pd.getName();
                if (!propertyName.equals("class")) {
                   // asSource.append("\tpublic var "+propertyName+" : "+getASType(pd.getPropertyType())+";\n");
                    asSource.append("\tprivate var "+propertyName+" : "+getASType(pd.getPropertyType())+";\n");
                }
            }
            

            int lastDot=className.lastIndexOf(".");
            String shortClassName=lastDot<0?className:className.substring(lastDot+1);

            asSource.append("\n\tstatic var registered=Object.registerClass(\""+className+"\", "+className+");");

            asSource.append("\n\n");
            //-----------------constructors---------------------//
        	asSource.append("\tpublic function "+ shortClassName+"(){\n");
        	//asSource.append("\t  return \""+className+"\";\n");
       	 	asSource.append("\t};\n\n");

            //////////////////Generate Accessors////////////////////////////
            for (int i=0; i<propertyDescriptors.length; i++) {
                pd=propertyDescriptors[i];
                propertyName=pd.getName();
                String fc = propertyName.toUpperCase();
                propertyDisplayName =fc.substring(0,1)+ propertyName.substring(1, propertyName.length());
                if (!propertyName.equals("class")) {
                    /* public getName = function() {
                    *	return this.name;
                    *    };
                    */
                	  asSource.append("\t//-------- Bean getter and setter for "+propertyDisplayName+" -----------// \n");
                	asSource.append("\tpublic function get"+propertyDisplayName+"():" + getASType(pd.getPropertyType())+"{\n");
               	 asSource.append("\t   return this."+propertyName+";\n");
               	 asSource.append("\t};\n");
               	 String newName = "new"+propertyDisplayName;
                	asSource.append("\tpublic function set"+propertyDisplayName+"("+newName+":"+getASType(pd.getPropertyType())+"):Void{\n");
                	 asSource.append("\t  this."+propertyName+" = "+newName + ";\n");
                	 asSource.append("\t};\n\n");


                  
                }
            }
            //------sample data method-------//
        	asSource.append("\tpublic function initSampleData():Void{\n");
            for (int i=0; i<propertyDescriptors.length; i++) {
                pd=propertyDescriptors[i];
                propertyName=pd.getName();
                String fc = propertyName.toUpperCase();
                propertyDisplayName =fc.substring(0,1)+ propertyName.substring(1, propertyName.length());
                if (!propertyName.equals("class")) {
               	  String newName = "new"+propertyDisplayName;
	               	String typeName = getASType(pd.getPropertyType());
	               	if(typeName.equalsIgnoreCase("String")){
	                 asSource.append("\t  this."+propertyName+" = \"sample_"+propertyName + "\";\n");
	               	}else if(typeName.equalsIgnoreCase("Number")){
	               		asSource.append("\t  this."+propertyName+" = "+i + ";\n");
	               	}else if(typeName.equalsIgnoreCase("Boolean")){
	               		asSource.append("\t  this."+propertyName+" = false;\n");
	               	}else {
	               		asSource.append("\t  this."+propertyName+" = new "+typeName + "();\n");
	                }
	              }
            }
        	 asSource.append("\t};\n\n");
 
            //-------toString method -------//
        	asSource.append("\tpublic function toString():String{\n");
        	asSource.append("\t  return \""+className+"\";\n");
       	 	asSource.append("\t};\n\n");
       	 	//---------finish class---------//
            asSource.append("}");
            System.out.println(asSource);

            messages.append(shortClassName+".as generated successfully");

        } catch (ClassNotFoundException e) {
            messages.append("ERROR: Class "+javaClass+" not found");
        } catch (InstantiationException e) {
            messages.append("ERROR: Class "+javaClass+" must have a no-argument constructor");
        } catch (IllegalAccessException e) {
            messages.append(e.getMessage());
        } catch (IntrospectionException e) {
            messages.append(e.getMessage());
        }

        HashMap map=new HashMap();
        map.put("<<<<<<<< openamf-config.xml >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>", amfconfigSource.toString());
        map.put("<<<<<<<< *.as source  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>", asSource.toString());
        map.put("<<<<<<<<  messages    >>>>>>>>>>>>>>>>>>>>>>>>>>>", messages.toString());

        return map;

    }

    public static String getASType(Class type) {

        String typeName=type.getName();

        if (    typeName.equals("java.lang.String")) {

                return "String";

        } else if (
                typeName.equals("int") ||
                typeName.equals("long") ||
                typeName.equals("short") ||
                typeName.equals("double") ||
                typeName.equals("float") ||
                typeName.equals("byte") ||
                typeName.equals("java.lang.Integer") ||
                typeName.equals("java.lang.Long") ||
                typeName.equals("java.lang.Short") ||
                typeName.equals("java.lang.Double") ||
                typeName.equals("java.lang.Float") ||
                typeName.equals("java.lang.Byte")) {

                return "Number";

        } else if (
                typeName.equals("boolean") ||
                typeName.equals("java.lang.Boolean")) {

                return "Boolean";

        } else if (type.isArray()) {

                return "Array";

        } else if (typeName.equals("java.util.Date")) {

                return "Date";

        } else if (typeName.equals("org.w3c.dom.Document")) {

                return "XML";

        } else {

            try {
                Object obj = type.newInstance();
                if (collectionClass.isInstance(obj)) {
                    return "Array";
                }
            } catch (InstantiationException e) {
            } catch (IllegalAccessException e) {
            }

            return typeName;//"Object";
        }

    }
    public String getString() {
        return "Hello World!";
    } 

}