package com.wemb.tobit.vo
{
	
	[Bindable]
	public class MenuInfoChild
	{
		public function MenuInfoChild()
		{
		}
		
		public var level:int;
		public var id:String;
		public var parent:String;
		public var menuCategory:String;
		public var menuName:String;
		public var menuOrder:String;
		public var menuUrl:String;
		public var menuUse:String;
		public var menuType:String;
		public var userId:String;
		public var children:Array;
		
		
	}
}