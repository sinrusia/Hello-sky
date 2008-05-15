/**
   ActionScript Class File -- Created with SAPIEN Technologies PrimalScript 3.1
   
   @class  
   @package
   @author P.R. Newman
   @codehint 
   @example 
   @tooltip 
*/

//import org.openamf.examples.Person;

class org.openamf.examples.PeopleClass{
	
	public var list:Array;
	
	// constructor function
	function PeopleClass(){
		init();
	}
	
	private function init():Void{
		trace("PeopleClass created");			
		list = new Array();
	}
}
