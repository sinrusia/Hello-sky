package com.wemb.tobit.events
{
	import flash.events.Event;

	public class NaviClickEvent extends Event
	{
		public static const NAVI_CLICK_EVENT:String = "naviClickEvent";
		
		public var index:int = 0;
		public var targetBtn:Object;
		
		public function NaviClickEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}