// import classes
import mx.rpc.RelayResponder;
import mx.rpc.ResultEvent;
import mx.rpc.FaultEvent;
import mx.controls.Alert;
import org.openamf.examples.*;

// timeline variables
var inited:Boolean;
var myDirectory:Directory;
var newPerson:Person;
var addPersonRes:RelayResponder = new RelayResponder();	// FR responder object
var searchRes:RelayResponder = new RelayResponder();	// FR responder object

//****************************
//  Button handlers
//****************************

addPerson_btn.onRelease = function():Void{
	trace("You clicked Add Person");

	// Add a person using AS org.openamf.examples.Person class
	newPerson = new Person();
	newPerson.firstName = firstName.text;
	newPerson.lastName = lastName.text;
	newPerson.address = address.text;
	newPerson.city = city.text;
	newPerson.state = state.text;
	newPerson.zipCode = parseInt(zipCode.text);
	newPerson.birthDate = new Date(birthDateYear.text, (birthDateMonth.text-1), birthDateDay.text);

	//trace("newPerson is instance of Person: " + (newPerson instanceof Person)); // true
	myDirectory.addPerson(newPerson, addPersonRes);
}

getPeopleName_btn.onRelease = function():Void{
	trace("You clicked Get By Name");

	// get people using the Directory object (pass responder as param?)
	myDirectory.getPeople(keyword.text, searchRes);
}

getPeopleZip_btn.onRelease = function():Void{
	trace("You clicked Get By Zip");

	// get people using the Directory object (pass responder as param?)
	myDirectory.getPeople(parseInt(keyword.text), searchRes);
}

updatePaths_btn.onRelease = function():Void{
	// set the gateway and service paths
	myDirectory.setGatewayPath(gatewayPath.text);
	myDirectory.setServicePath(servicePath.text);
}

//****************************
//  Functions
//****************************

// initialize the application
function init():Void{
	// run this only once
	if(!inited){
		inited = true;
		myDirectory = new Directory();

		// register Person class with ActionScript. Otherwise, Java > AS2 mapping won't work
		Object.registerClass("org.openamf.examples.Person", org.openamf.examples.Person);
	}
}

//****************************
//  Flash Remoting responders
//****************************

addPersonRes.onResult = function(re:ResultEvent):Void{
	trace("addPersonRes.onResult invoked: " + newPerson.firstName + " " + newPerson.lastName + "\n\n");
	// let user know person was added
	Alert.show(newPerson.firstName + " " + newPerson.lastName + " added successfully.", "Person Added");
}

addPersonRes.onFault = function(fe:FaultEvent):Void{
	trace("addPersonRes.onFault invoked: " + fe.fault.description);
}

searchRes.onResult = function(re:ResultEvent):Void{
	trace("searchRes.onResult invoked");

	var len:Number = re.result.length;
	responseOut.text = "RESULT COUNT: " + len + "\n\n";

	for(var i:Number=0; i<len; i++){
		var p:Person = re.result[i];
		trace(p.firstName + " " + p.lastName + " is instance of AS Person class: " + (p instanceof Person));
		responseOut.text += p.getFullName() + "\n\n";
		responseOut.text += p.firstName + " "
		+ p.lastName + " "
		+ p.address + " "
		+ p.city + " "
		+ p.state + " "
		+ p.zipCode.toString() + " "
		+ p.birthDate.toString() + "\n\n";
	}

}

searchRes.onFault = function(fe:FaultEvent):Void{
	trace("searchRes.onFault invoked: " + fe.fault.description);
}

//****************************
//  Initialization
//****************************

init();