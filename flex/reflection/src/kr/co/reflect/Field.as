package kr.co.reflect
{
	public class Field
	{
		private var _name:String;
		private var _type:String;
		private var _obj:Object;
		
		public function Field(name:String, type:String, obj:Object = null)
		{
			this._name	= name;
			this._type	= type;
			this._obj	= obj;
		}
		
		public function getDeclaringClass():Object
		{
			return _obj;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function getValue(obj:Object):Object
		{
			if(obj != null){
				if(obj is XClass){
					return XClass(obj).newInstance()[name];
				}else{
					return obj[name];
				}
			}else{
				return _obj[name];
			}
		}
		
		public function setValue(obj:Object, value:Object):void
		{
			if(obj != null){
				if(obj is XClass){
					XClass(obj).newInstance()[name] = value;
				}else{
					obj[name] = value;
				}
			}else{
				_obj[name] = value;
			}
		}
		public function setBoolean(obj:Object, value:Boolean):void
		{
			_obj[name] = value;
			setValue(obj, value);
		}
		public function setNumber(obj:Object, value:Number):void
		{
			_obj[name] = value;
			setValue(obj, value);
		}
		public function setInt(obj:Object, value:int):void
		{
			_obj[name] = value;
			setValue(obj, value); 
		}
		
		public function toString():String
		{
			return '<variable name="'+name+'" type="'+type+'"/>';
		}
	}
}