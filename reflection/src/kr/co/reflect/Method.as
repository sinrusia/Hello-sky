package kr.co.reflect
{
	public class Method
	{
		private var _name:String;
		private var _declaredBy:String;
		private var _returnType:String;
		private var _parameters:Array;
		private var _obj:Object;
		
		public function Method(name:String, 
							declaredBy:String, 
							returnType:String, 
							parameters:Array, 
							obj:Object = null){
			this._name			= name;
			this._declaredBy	= declaredBy;
			this._returnType	= returnType;
			this._parameters	= parameters;
			this._obj	= obj;
			parameters	= new Array();
		}
		
		public function getDeclaringClass():Object
		{
			return _obj;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get parameters():Array
		{
			return _parameters;
		}
		
		public function get returnType():String
		{
			return _returnType;
		}
		
		public function get declaredBy():String
		{
			return _declaredBy;
		}
		
		public function invoke(obj:Object, args:Array):Object
		{
			var func:Function;
			
			if(obj != null){
				if(obj is XClass){
					func = XClass(obj).newInstance()[name];
				}else{
					func = obj[name];
				}
			}else{
				func = _obj[name];
			}
			
			return func.apply(null, args);
		}
		
		public function toString():String
		{
			//<method name="getReturnType" declaredBy="vo::MyVo" returnType="vo::MyVo">
			return '<method name="'+name+'" declaredBy="'+declaredBy+'" returnType="'+returnType+'">';
		}
	}
}