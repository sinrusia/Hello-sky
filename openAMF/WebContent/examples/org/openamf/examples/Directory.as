/**
   ActionScript Class File -- Created with SAPIEN Technologies PrimalScript 3.1

   @class
   @package
   @author P.R. Newman
   @codehint
   @example
   @tooltip
*/

// we could use import org.openamf.examples.* but that increases compilation time on large projects
import org.openamf.examples.Person;
import org.openamf.examples.PeopleClass;

// new Flash Remoting classes
import mx.remoting.Service;
import mx.remoting.PendingCall;
import mx.rpc.RelayResponder;
import mx.services.Log;

// Uncomment the following line to use the NetConnection Debugger
import mx.remoting.debug.NetDebug;


class org.openamf.examples.Directory{
	// Properties
	public var People:PeopleClass;
	public var gatewayPath:String;
	public var servicePath:String;
	public var serviceObject:Service;

	// constructor function
	function Directory(){
		trace("init Directory");
		init();
	}

	private function init():Void{
		trace("Directory Created");
		People = new PeopleClass();

		// Uncomment the following line to use the NetConnection Debugger
		NetDebug.initialize();

		gatewayPath = "http://192.168.0.240:7001";//"http://localhost:8080/openamf/gateway";
		servicePath = "org.openamf.examples.Directory";
		setServiceObject();
	}

	public function setServiceObject(Void):Void{
		serviceObject = new Service(gatewayPath, new Log(), servicePath);
	}

	public function setGatewayPath(gatewayPath:String):Void{
		this.gatewayPath = gatewayPath;
		setServiceObject();
		trace("gateway: " + this.gatewayPath);
	}

	public function setServicePath(servicePath:String):Void{
		this.servicePath = servicePath;
		setServiceObject();
		trace("service: " + this.servicePath);
	}

	public function addPerson(person:Person, responder:RelayResponder):Void{
		trace("Adding Person: " + person.firstName + " " + person.lastName);
		// add new person to PeopleClass instance
		People.list.push(person);

		setServiceObject();
		var pc:PendingCall = serviceObject.addPerson(person);
		// use the PendingCall.responder property to set the result and fault handlers
		pc.responder = responder;
	}

	public function getPeople(keyword:Object, responder:RelayResponder):Void{
		if(isNaN(keyword)){
			trace(keyword + " is not a number");
		}
		else{
			trace(keyword + " is a number");
		}

		setServiceObject();
		var pc:PendingCall = serviceObject.getPeople(keyword);
		// use the PendingCall.responder property to set the result and fault handlers
		pc.responder = responder;
	}
}
