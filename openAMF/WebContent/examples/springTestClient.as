import mx.remoting.Service;
import mx.rpc.RelayResponder;
import mx.remoting.PendingCall;
import mx.rpc.ResultEvent;
import mx.rpc.FaultEvent;
import mx.remoting.debug.NetDebug;
import mx.services.Log;
var debug:Boolean = NetDebug.initialize();
import org.openamf.examples.*;
function getString_Result(evt:ResultEvent):Void {
	_root.helloText.text += ("\rgot Result Succesfully:\r");
	_root.helloText.text += evt.result;
	if(_global.test >1){
	_root.helloText.text += ("\rt  Testing Object Mapping---------------------");
	_root.helloText.text += ("\r  object instanceof Person?: "+(evt.result instanceof org.openamf.examples.Person)+"\r   instance of interface IhaveName?: "+(evt.result instanceof org.openamf.examples.IhaveName));
	}
}
function getString_Fault(evt:FaultEvent):Void {
	trace("\rFault/Error: "+evt.fault.__faultstring);
	_root.helloText.text += "\rFault/Error: "+evt.fault.__faultstring;
}
test1_btn.onRelease = function() {
	_global.test = 0;
	_root.helloText.text =" This is the simplest test of Spring, just gets a concrete service class from Spring and calls a method which returns a string of 'Hello World', \r\r ***********Please press the 'Submit' button******** ";
}
test2_btn.onRelease = function() {
	_global.test = 1;
	_root.helloText.text =" This is a test of using Spring's /WEB-INF/applicationContext.xml bean config to provide the argument for the service to call, similar to HelloWorld, \r\r ***********Please press the 'Submit' button******** ";
}
test3_btn.onRelease = function() {
	_global.test = 2;
	_root.helloText.text =" This does two things, one is it calls an interface for a service, which in turn returns an an IhaveName Object, the concrete implementers for these being determined by Spring applicationContext.xml, and returns that Person object (which implements a AS IhaveName interface) back via the class mapping, it should be noted that the concrete class will be serialized completely not just the elements in the interface, meaning even though it returns an IhaveName object, every serializable property in Person will end up on the AS side and it will be mapped to the Person.as, \r\r ***********Please press the 'Submit' button******** ";
}
test4_btn.onRelease = function() {
	_global.test = 3;
	_root.helloText.text =" This sends and recieves (roundtrips actually) a Person Object, to the same service (expecting a IhaveName interface), and demonstrates ASTranslators ability to convert(cast) objects into the Service method e.g. sayHi(IhaveName:named) where it will really be a concrete Person class, \r\r ***********Please press the 'Submit' button******** ";
}
submitBtn.onRelease = function() {
	trace("\r \rclick");
	var gatewayPath = "http://localhost:8080/openamf/gateway";
	////////////////////////////////////////////////////////////////////////
	//test that the gatemeay exist look at _root.onStatus for failure////////
	var my_lv:LoadVars = new LoadVars();
	my_lv.load(gatewayPath);
	////////////////////////////////////

	var Svc:Service = null;
	var mypc:PendingCall = null;
	var srvName = "";
	if (_global.test == 0) {
		//Hello World Test (should return "hello world"
		srvName = "hello";
		Svc = new Service(gatewayPath, new Log(), srvName, null, statO);
		mypc = Svc.getString();
	} else if (_global.test == 1) {
		//I Greeting Service Test should return "Buenos Dias!"
		srvName = "greetingService";
		Svc = new Service(gatewayPath, new Log(), srvName, null, statO);
		mypc = Svc.sayGreeting();
	} else if (_global.test == 2) {
		//I Greeting Service Test should return and instance of IhaveName and Person
		srvName = "greetingService";
		Svc = new Service(gatewayPath, new Log(), srvName, null, statO);
		mypc = Svc.sayName();
	} else if (_global.test == 3) {
		//I Greeting Service Test should return and instance of IhaveName and Person
		srvName = "greetingService";
		Svc = new Service(gatewayPath, new Log(), srvName, null, statO);
		var SamplePerson = new Person();
		SamplePerson.initSampleData();
		mypc = Svc.sayHiTo(SamplePerson);
	}else{
				_root.helloText.text = "\r\r\r\r\r\r ***********Please select a test on the left******** ";
			return;
	}
			_root.helloText.text = "attempting to call the '" + srvName + "' service...";


	mypc.responder = new RelayResponder(_root, "getString_Result", "getString_Fault", "onStatus");
};

//details http://localhost:8080/openamf/gateway
//description HTTP: Failed
//code NetConnection.Call.Failed
//level error
_global.System.onStatus = function(a1, b, c) {
	_root.helloText.text += ("\rSystem. on status**********************");
	var a = a1;
	for (var i in a1) {
		_root.helloText.text += ("\r\t\t" + i+" :"+a1[i]);
	}
	if( a1.code =="NetConnection.Call.Failed"){
		_root.helloText.text += ("\r\r are you sure the gateway is up?");
	}
};
Object.registerClass("IhaveName", IhaveName);
Object.registerClass("org.openamf.examples.Person", Person);
_root.helloText.text =("\rTest RegisterClass---------------------");
var ihnA = new IhaveName();
_root.helloText.text += ("\r  new IhaveName() instanceof IhaveName?: "+(ihnA instanceof org.openamf.examples.IhaveName)+"\r\t instanceof Person?: "+(ihnA instanceof org.openamf.examples.Person));
var barV = new Person();
_root.helloText.text += ("\r  new Person() instanceof Person?: "+(barV instanceof org.openamf.examples.Person)+"\r\t instanceof IhaveName?: "+(barV instanceof org.openamf.examples.IhaveName));
_root.helloText.text += ("\r\r ***********Please Select a test on the left******** ");