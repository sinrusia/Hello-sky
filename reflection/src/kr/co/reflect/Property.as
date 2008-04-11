package kr.co.reflect
{
	public class Property
	{
		//<accessor name="Name" access="readwrite" type="String" declaredBy="vo::MyVo"/>
		private var _name:String;
		private var _access:String;
		private var _type:String;
		private var _declaredBy:String;
		private var _obj:Object;
		
		public function Property(name:String, access:String, type:String, declaredBy:String, obj:Object){
			_name		= name;
			_access		= access;
			_type		= type;
			_declaredBy	= declaredBy;
			_obj		= obj;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get access():String
		{
			return _access;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function get declaredBy():String
		{
			return _declaredBy;
		}
		
		public function getDeclaringClass():Object
		{
			return _obj;
		}
		
		public function toString():String
		{
			return '<accessor name="'+name+'" access="'+access+'" type="'+type+'" declaredBy="'+declaredBy+'"/>';
		}
	}
}