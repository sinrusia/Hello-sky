/*
 * 
 *

 */
package org.openamf.test;

import org.w3c.dom.Document;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Vector;
import java.util.HashSet;

/**
 * @author Troy Gardner
 *Created on May 26, 2005
 * This has most the basic value types in it, as well as their reference types. Used by the TestDataTypesBeanService
 * to see if they propogate to the flash client in a predicatable way.
 */
public class TestDataTypesBean {
    private byte mybyte;
    private short myshort;
    private long mylong;
    private int myint;
    private float myfloat;
    private double mydouble;
    private char mychar;
    private boolean myboolean;

    private Byte myByte;
    private Short myShort;
    private Integer myInteger;
    private Long myLong;
    private Float myFloat;
    private Double myDouble;
    private Character myCharacter;
    private Boolean myBoolean;

    private String myString;

    private Date myDate;

    private ArrayList myArrayList;
    private Vector myVector;
    private HashSet myHashSet;
    private int[] myIntArray;
    private String[] myStringArray;

    private org.w3c.dom.Document myDocument;
    
    public TestDataTypesBean(){
    	
    }
    public void initSampleData(){
    	
    }
    public void initSampleDataNull(){
    	//Since these are by value they can't be set as anything other than null
    	// and they will recieve their default values in the construction of the object.
//        this.mybyte = null;
//        this.myshort = null;
//        this.mylong = null;
//        this.myint = null;
//        this.myfloat = null;
//        this.mydouble = null;
//        this.mychar = null;
//        this.myboolean = null;

        this.myByte = null;
        this.myShort = null;
        this.myInteger = null;
        this.myLong = null;
        this.myFloat = null;
        this.myDouble = null;
        this.myCharacter = null;
        this.myBoolean = null;

        this.myString = null;

        this.myDate = null;

        this.myArrayList = null;
        this.myVector = null;
        this.myHashSet = null;
        this.myIntArray = null;
        this.myStringArray = null;

        this.myDocument = null;
    }
    public void initSampleDataMin(){
        this.mybyte = Byte.MIN_VALUE;
        this.myshort = Short.MIN_VALUE;
        this.mylong = Long.MIN_VALUE;
        this.myint = Integer.MIN_VALUE;
        this.myfloat = Float.MIN_VALUE;
        this.mydouble = Double.MIN_VALUE;
        this.mychar = Character.MIN_VALUE;
        this.myboolean = false;

        this.myByte = new Byte(Byte.MIN_VALUE);
        this.myShort = new Short(Short.MIN_VALUE);
        this.myInteger =  new Integer(Integer.MIN_VALUE);
        this.myLong =  new Long(Long.MIN_VALUE);
        this.myFloat =  new Float(Float.MIN_VALUE);
        this.myDouble =  new Double(Double.MIN_VALUE);
        this.myCharacter =  new Character(Character.MIN_VALUE);
        this.myBoolean = Boolean.FALSE;

        this.myString = new String();

        Calendar c = Calendar.getInstance();
        c.set(1970,0,1,0,0,0);
        this.myDate = c.getTime();
        
        this.myArrayList = null;
        this.myVector = null;
        this.myHashSet = null;
        this.myIntArray = null;
        this.myStringArray = null;

        this.myDocument = null;
    }
    public void initSampleDataMax(){
        this.mybyte = Byte.MAX_VALUE;
        this.myshort = Short.MAX_VALUE;
        this.mylong = Long.MAX_VALUE;
        this.myint = Integer.MAX_VALUE;
        this.myfloat = Float.MAX_VALUE;
        this.mydouble = Double.MAX_VALUE;
        this.mychar = Character.MAX_VALUE;
        this.myboolean = false;

        this.myByte = new Byte(Byte.MAX_VALUE);
        this.myShort = new Short(Short.MAX_VALUE);
        this.myInteger =  new Integer(Integer.MAX_VALUE);
        this.myLong =  new Long(Long.MAX_VALUE);
        this.myFloat =  new Float(Float.MAX_VALUE);
        this.myDouble =  new Double(Double.MAX_VALUE);
        this.myCharacter =  new Character(Character.MAX_VALUE);
        this.myBoolean = Boolean.TRUE;

        this.myString = new String();

        Calendar c = Calendar.getInstance();
        c.set(1970,0,1,0,0,0);
        this.myDate = c.getTime();
        
        this.myArrayList = null;
        this.myVector = null;
        this.myHashSet = null;
        this.myIntArray = null;
        this.myStringArray = null;

        this.myDocument = null;
    }
    public void initSampleDataEmpty(){
        this.mybyte = Byte.MIN_VALUE;
        this.myshort = Short.MIN_VALUE;
        this.mylong = Long.MIN_VALUE;
        this.myint = Integer.MIN_VALUE;
        this.myfloat = Float.MIN_VALUE;
        this.mydouble = Double.MIN_VALUE;
        this.mychar = Character.MIN_VALUE;
        this.myboolean = false;

        this.myByte = new Byte(null);
        this.myShort = new Short(null);
        this.myInteger =  new Integer(null);
        this.myLong =  new Long(null);
        this.myFloat =  new Float(null);
        this.myDouble =  new Double(null);
       // this.myCharacter =  new Character();
        this.myBoolean = new Boolean(null);

        this.myString = new String();

        this.myDate = new Date();

        this.myArrayList = new ArrayList();
        this.myVector = new Vector();
        this.myHashSet = new HashSet();
        this.myIntArray = new int[0];
        this.myStringArray = new String[0];

      //  this.myDocument = new XmlDocument();
    }
    public byte getMybyte() {
        return mybyte;
    }

    public void setMybyte(byte mybyte) {
        this.mybyte = mybyte;
    }

    public short getMyshort() {
        return myshort;
    }

    public void setMyshort(short myshort) {
        this.myshort = myshort;
    }

    public long getMylong() {
        return mylong;
    }

    public void setMylong(long mylong) {
        this.mylong = mylong;
    }

    public int getMyint() {
        return myint;
    }

    public void setMyint(int myint) {
        this.myint = myint;
    }

    public float getMyfloat() {
        return myfloat;
    }

    public void setMyfloat(float myfloat) {
        this.myfloat = myfloat;
    }

    public double getMydouble() {
        return mydouble;
    }

    public void setMydouble(double mydouble) {
        this.mydouble = mydouble;
    }

    public char getMychar() {
        return mychar;
    }

    public void setMychar(char mychar) {
        this.mychar = mychar;
    }

    public boolean isMyboolean() {
        return myboolean;
    }

    public void setMyboolean(boolean myboolean) {
        this.myboolean = myboolean;
    }

    public Byte getMyByte() {
        return myByte;
    }

    public void setMyByte(Byte myByte) {
        this.myByte = myByte;
    }

    public Short getMyShort() {
        return myShort;
    }

    public void setMyShort(Short myShort) {
        this.myShort = myShort;
    }

    public Integer getMyInteger() {
        return myInteger;
    }

    public void setMyInteger(Integer myInteger) {
        this.myInteger = myInteger;
    }

    public Long getMyLong() {
        return myLong;
    }

    public void setMyLong(Long myLong) {
        this.myLong = myLong;
    }

    public Float getMyFloat() {
        return myFloat;
    }

    public void setMyFloat(Float myFloat) {
        this.myFloat = myFloat;
    }

    public Double getMyDouble() {
        return myDouble;
    }

    public void setMyDouble(Double myDouble) {
        this.myDouble = myDouble;
    }

    public Character getMyCharacter() {
        return myCharacter;
    }

    public void setMyCharacter(Character myCharacter) {
        this.myCharacter = myCharacter;
    }

    public Boolean getMyBoolean() {
        return myBoolean;
    }

    public void setMyBoolean(Boolean myBoolean) {
        this.myBoolean = myBoolean;
    }

    public String getMyString() {
        return myString;
    }

    public void setMyString(String myString) {
        this.myString = myString;
    }

    public Date getMyDate() {
        return myDate;
    }

    public void setMyDate(Date myDate) {
        this.myDate = myDate;
    }

    public ArrayList getMyArrayList() {
        return myArrayList;
    }

    public void setMyArrayList(ArrayList myArrayList) {
        this.myArrayList = myArrayList;
    }

    public Vector getMyVector() {
        return myVector;
    }

    public void setMyVector(Vector myVector) {
        this.myVector = myVector;
    }

    public HashSet getMyHashSet() {
        return myHashSet;
    }

    public void setMyHashSet(HashSet myHashSet) {
        this.myHashSet = myHashSet;
    }

    public int[] getMyIntArray() {
        return myIntArray;
    }

    public void setMyIntArray(int[] myIntArray) {
        this.myIntArray = myIntArray;
    }

    public String[] getMyStringArray() {
        return myStringArray;
    }

    public void setMyStringArray(String[] myStringArray) {
        this.myStringArray = myStringArray;
    }

    public Document getMyDocument() {
        return myDocument;
    }

    public void setMyDocument(Document myDocument) {
        this.myDocument = myDocument;
    }
}
