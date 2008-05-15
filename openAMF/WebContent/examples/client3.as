
/*
	This code is currently not working as of
	December 01, 2003. Feel free to fix and commit
	if you have the time. Looks like it would be 
	a great test client.
*/

#include "NetServices.as"
#include "NetDebug.as"

NetServices.setDefaultGatewayURL("http://localhost:8080/openamf/gateway");

gatewayConnection = NetServices.createGatewayConnection();
myService = gatewayConnection.getService("org.openamf.examples.Test3");
myJMXService = gatewayConnection.getService("jboss:service=JNDIView");
myStatelessEJBService = gatewayConnection.getService("TestStatelessEJBBean");
myStatefulEJBService = gatewayConnection.getService("TestStatefulEJBBean");

var number = 123.456;
var numberArray = new Array();
numberArray[0] = 123;
numberArray[1] = 456;

var string = "hello";

var date = new Date();

var xml = new XML("<state>California<city>san francisco</city></state>");

Pojo = function() {}
Object.registerClass("remoting.test.Pojo", Pojo);
var pojo = new Pojo();
pojo.name = "Joe";
pojo.age = 23;

var ejb = "hello ejb";

function NumberHandler()
{
	this.onResult = function (getNumber)
	{ 
		resultvar = getNumber;
	}
	
	this.onStatus = function (status)
	{
		resultvar = status;
	}
}

function NumberArrayHandler()
{
	this.onResult = function (getNumberArray)
	{ 
		resultvar = getNumberArray[0] + " , " + getNumberArray[1];
	}
	
	this.onStatus = function (status)
	{
		resultvar = status;
	}
}

function StringHandler()
{
	this.onResult = function (getString)
	{ 
		resultvar = getString;
	}
	
	this.onStatus = function (status)
	{
		resultvar = status;
	}
}

function DateHandler()
{
	this.onResult = function (getDate)
	{ 
		resultvar = getDate.toString();
	}
	
	this.onStatus = function (status)
	{
		resultvar = status;
	}
}

function XMLHandler()
{
	this.onResult = function (getXML)
	{ 
		resultvar = getXML;
	}
	
	this.onStatus = function (status)
	{
		resultvar = status;
	}
}

function POJOHandler()
{
	this.onResult = function (getPOJO)
	{ 
		resultvar = getPOJO;
	}
	
	this.onStatus = function (status)
	{
		resultvar = status;
	}
}

function EJBHandler()
{
	this.onResult = function (getEcho)
	{ 
		resultvar = getEcho;
	}
	
	this.onStatus = function (status)
	{
		resultvar = status;
	}
}

function JMXHandler()
{
	this.onResult = function (listXML)
	{ 
		resultvar = listXML;
	}
	
	this.onStatus = function (status)
	{
		resultvar = status;
	}
}

function onNumber(btn)
{
  sendvar = number;
  myService.getNumber(new NumberHandler(), number);
}

function onNumberArray(btn)
{
  sendvar = numberArray;
  myService.getNumberArray(new NumberArrayHandler(), numberArray);
}

function onString(btn)
{
  sendvar = string;
  myService.getString(new StringHandler(), string);
}

function onDate(btn)
{
  sendvar = date;
  myService.getDate(new DateHandler(), date);
}

function onXML(btn)
{
  sendvar = xml;
  myService.getXML(new XMLHandler(), xml);
}

function onPOJO(btn)
{
  sendvar = pojo;
  myPOJOService.getPOJO(new POJOHandler(), pojo);
}

function onEJBstateful(btn)
{
  sendvar = ejb;
  myStatefulEJBService.getEcho(new EJBHandler(), ejb);
}

function onEJBstateless(btn)
{
  sendvar = ejb;
  myStatelessEJBService.getEcho(new EJBHandler(), ejb);
}


function onJMX(btn)
{
  sendvar = jmx;
  myJMXService.listXML(new JMXHandler());
}