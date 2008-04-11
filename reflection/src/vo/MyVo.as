package vo
{
	public class MyVo
	{
		public var comp:String
		
		private var _name:String;
		
		public function MyVo()
		{
			
		}
		
		public function get Name():String
		{
			return _name;
		}
		
		public function set Name(value:String):void{
			_name = value;
		}
		
		public function process(value:String, str:String):String
		{
			trace("===================");
			trace(value);
			trace(str);
			return "리턴했";
		}
		
		public function getReturnType(value:int = 0):MyVo
		{
			return null;
		}
	}
}