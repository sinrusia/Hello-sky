/**
   ActionScript Class File -- Created with SAPIEN Technologies PrimalScript 3.1

   @class
   @package
   @author P.R. Newman
   @codehint
   @example
   @tooltip
*/

class org.openamf.examples.Person implements org.openamf.examples.IhaveName{

	public var firstName:String;
	public var lastName:String;
	public var address:String;
	public var city:String;
	public var state:String;
	public var zipCode:Number;
	public var birthDate:Date;

	// constructor function
	function Person(){
		//trace("Person constructor invoked");
		init();
	}
	public function initSampleData():Void{
		this.firstName = "AS_SampleFirstName";
		this.lastName = "AS_SampleFirstName";
		this.lastName = "AS_SampleAddress";
		this.address = "AS_SampleAddress";
		this.city = "AS_SampleCity";
		this.state = "AS_SampleState";
		//this.zipCode = 01293;

	}
	public function getFullName():String{
		trace("returning FullName from Person class: " + this.firstName + " " + this.lastName);
		return this.firstName + " " + this.lastName;
	}
	public function setName(newName:String):Void{
		this.firstName = newName;
	}
	public function getName():String{
		return this.getFullName();
	}

	private function init():Void{
		//trace("Person init");
	}
	public function toString():String{
		return "Person.toString " + this.getFullName();
	}
}
