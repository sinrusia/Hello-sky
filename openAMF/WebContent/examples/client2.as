#include "NetServices.as"
#include "NetDebug.as"

 

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//::: Declare Person Class
Person = function () {
	this.init();
}

// Properties
Person.prototype.firstName = "";
Person.prototype.lastName = ""; 
Person.prototype.address = "";
Person.prototype.city = "";
Person.prototype.state = "";
Person.prototype.zipCode = 0;
Person.prototype.birthDate = new Date();

// Constructor
Person.prototype.init = function(){
	trace("Person Created");	
}
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//::: Declare People Class
PeopleClass = function () 
{
	
};

PeopleClass.prototype.list = new Array();

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//::: Declare Directory Class
Directory = function () 
{
	this.init();
};

// Properties
Directory.prototype.People = new PeopleClass();
Directory.prototype.gatewayPath = "";
Directory.prototype.servicePath = "";
Directory.prototype.serviceConnection = new Object();
Directory.prototype.serviceObject = new Object();

// Constructor
Directory.prototype.init = function() {
	trace("Directory Created");
	this.gatewayPath = "http://localhost:8080/openamf/gateway";
	this.servicePath = "org.openamf.examples.Directory";
	this.setServiceObject();
}


// Methods
Directory.prototype.setServiceObject = function() {
	NetServices.setDefaultGatewayURL(this.gatewayPath);
	this.serviceConnection = NetServices.createGatewayConnection();
	this.serviceObject = this.serviceConnection.getService(this.servicePath, this);
}
Directory.prototype.setGatewayPath = function(gatewayPath) {
	this.gatewayPath = gatewayPath;
	this.setServiceObject();
	trace("gateway: "+this.gatewayPath);
}

Directory.prototype.setServicePath = function(servicePath) {
	this.servicePath = servicePath;
	this.setServiceObject();
	trace("service: "+this.servicePath);
}

Directory.prototype.addPerson = function(Person) {
	trace("Adding Person"+Person["firstName"]+Person["lastName"]);
	this.setServiceObject();
	this.serviceObject.addPerson(Person);
}

Directory.prototype.getPeople = function(keyword) {
	this.setServiceObject();
	this.serviceObject.getPeople(keyword);
	trace("keyword"+keyword);
}
Directory.prototype.getPeople_Result = function(result)
{
	trace("debug People getPeople_Result");
	this.People.list = result;
	_root.responseOut.text = "RESULT COUNT: "+result.length+"\n\n";
	for (i=0; i<result.length;i++)
	{	
		n = result[i]
		var firstName = n["firstName"].toString();
		var lastName = n["lastName"].toString();
		var address = n["address"].toString();
		var city = n["city"].toString();
		var state = n["state"].toString();
		var zipCode = n["zipCode"].toString();
		var birthDate = n["birthDate"].toString();
		_root.responseOut.text += firstName+" "+lastName+" "+address+" "+city+" "+state+" "+zipCode+" "+birthDate+"\n\n";
	}
}



//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//::: Create Directory Object

_root.myDirectory = new Directory();

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


// ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// ::: Button Action Script
AddPersonButton.label = "Add Person";
AddPersonButton.tabEnabled = false;
AddPersonButton.clickHandler = function() {
	// Add a person through the Directory Object
	NewPerson = new Person();
	NewPerson.firstName = _root.firstName.text; 
	NewPerson.lastName = _root.lastName.text;
	NewPerson.address = _root.address.text;
	NewPerson.city = _root.city.text;
	NewPerson.state = _root.state.text;
	NewPerson.zipCode = Number(_root.zipCode.text);
	NewPerson.birthDate = new Date(_root.birthDateYear.text, (_root.birthDateMonth.text-1), _root.birthDateDay.text);

	_root.myDirectory.addPerson(NewPerson);
}

UpdatePathsButton.label = "Update Paths";
UpdatePathsButton.tabEnabled = false;
UpdatePathsButton.clickHandler = function() {
	// set the directory gatewayPath
	_root.myDirectory.setGatewayPath(_root.gatewayPath.text);
	_root.myDirectory.setServicePath(_root.servicePath.text);
}

// Get People with Zip
GetPeopleZipButton.label = "Get with Zip";
GetPeopleZipButton.tabEnabled = false;
GetPeopleZipButton.clickHandler = function() {
	// Add a person through the Directory Object
	keyword = Number(_root.keyword.text);
	_root.myDirectory.getPeople(keyword);
}

// Get People with Name
GetPeopleNameButton.label = "Get with Name";
GetPeopleNameButton.tabEnabled = false;
GetPeopleNameButton.clickHandler = function() {
	// Add a person through the Directory Object
	_root.myDirectory.getPeople(_root.keyword.text);
}
// ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


