package kr.co.reflect
{
	public class Parameter
	{
		private var _index:int;
		private var _type:String;
		private var _optional:Boolean;
		
		public function Parameter(index:int, type:String, optional:Boolean)
		{
			_index		= index;
			_type		= type;
			_optional	= optional;
		}
		
		private function get index():int
		{
			return _index;
		}
		
		private function get type():String
		{
			return _type;
		}
		
		private function get optional():Boolean
		{
			return _optional;
		}
		
		public function toString():String
		{
			//<parameter index="1" type="String" optional="false"/>
			return '<parameter index="'+index+'" type="'+type+'" optional="'+optional+'"/>';
		}
	}
}