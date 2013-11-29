package com.wemb.tobit.events
{
	import flash.events.Event;

	public class MenuEvent extends Event
	{
		public static var MENU_CLICK:String = "menuClick";
		
		public var menuid:String = "";
		
		public var initInfo:Object;
		
		public function MenuEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}