package kr.co.reflect
{
	import flash.utils.getDefinitionByName;
	import flash.utils.describeType;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	
	public class XClass
	{
		private var _reflectionObject:Object;
		
		private var _methods:Array;
		
		private var _fields:Array;
		
		private var _propertys:Array;
		
		//---------------------------------------------------------
		//
		//	Constructor 
		//
		//---------------------------------------------------------
		
		public function XClass(name:String = null){
			
			//var ifactory:IFactory		= new ClassFactory(getDefinitionByName(name) as Class);
			//var definitionObj:Object	= ifactory.newInstance();
			
			var definitionObj:Object	= getDefinitionByName(name);
			
			_reflectionObject			= new definitionObj();
			_methods					= getMethodList();
			_fields						= getFieldList();
			_propertys					= getPropertyList();
		}
		
		
		//---------------------------------------------------------
		//
		//	public 
		//
		//---------------------------------------------------------
		
		public function getDeclaredField(name:String):Field
		{
			return null;
		}
		
		public function getDeclaredFields():Array
		{
			return null;
		}
		
		public function getDeclaredMethods():Array
		{
			return null;
		}
		
		public function getDeclaredMethod(name:String, parameterTypes:Array):Method
		{
			return null;
		}
		
		public function getFields():Array
		{
			return _fields;
		}
		
		public function getField(name:String):Field
		{
			for(var i:int = 0; i < _fields.length; i++){
				var f:Field = _fields[i];
				if(f.name == name){
					return f;
				}
			}
			return null;
		}
		
		public function getMethods():Array
		{
			return _methods;
		}
		
		public function getMethod(name:String):Method
		{
			for(var i:int = 0; i < _methods.length; i++){
				var m:Method = _methods[i];
				if(m.name == name){
					return m;
				}
			}
			return null;
		}
		
		public function getPropertys():Array
		{
			return _propertys;
		}
		
		public function getProperty():Property
		{
			return null;
		}
		
		public function getName():String
		{
			return null;
		}
		
		public function getPackage():String
		{
			return null;
		}
		
		public function isInstance(cls:Class):Boolean
		{
			if(_reflectionObject instanceof cls){
				return true;
			}else{
				return false;
			}
		}
		
		public function newInstance():Object
		{
			return _reflectionObject;
		}
		
		public function toString():String
		{
			return null;
		}
		
		
		//---------------------------------------------------------
		//
		//	private
		//
		//---------------------------------------------------------
		
		private function getInstahceInfo():XML
		{
			return describeType(_reflectionObject)..method;
			return describeType(_reflectionObject)..accessor;
			return describeType(_reflectionObject)..variable;
		}
		
		private function getMethodList():Array
		{
			var xl:XMLList = describeType(_reflectionObject)..method;
			var rtnArr:Array = new Array();
			for each( var x:XML in xl){
				
				var parameters:Array = new Array();
				var pxl:XMLList = x..parameter;
				
				for each(var px:XML in pxl){
					var p:Parameter = new Parameter(px.@index,
												px.@type,
												px.@optional);
					parameters.push(p);
				}
				
				var m:Method 	= new Method(x.@name, 
											x.@declaredBy,
											x.@returnType,
											parameters,
											x.@_reflectionObject);
				
				rtnArr.push(m);
			}
			return rtnArr;
		}
		
		private function getFieldList():Array
		{
			var xl:XMLList		= describeType(_reflectionObject)..variable;
			var rtnArr:Array	= new Array();
			
			for each(var x:XML in xl){
				var f:Field	= new Field(x.@name, x.@type, _reflectionObject);
				rtnArr.push(f);
			}
			
			return rtnArr;
		}
		
		private function getPropertyList():Array
		{
			var xl:XMLList		= describeType(_reflectionObject)..accessor;
			var rtnArr:Array	= new Array();
			
			for each(var x:XML in xl){
				var p:Property = new Property(x.@name,
										x.@access,
										x.@type,
										x.@declaredBy,
										_reflectionObject);
				rtnArr.push(p);
			}
			
			return rtnArr;
		}
		
		
		
		//---------------------------------------------------------
		//
		//	static 
		//
		//---------------------------------------------------------
		
		public static function forName(name:String):XClass{
			return new XClass(name);
		}
	}
}