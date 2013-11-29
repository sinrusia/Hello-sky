package com.wemb.tobit.events
{
	import flash.events.Event;

	public class MenuResizeEvent extends Event
	{
		public static const RESIZE_EVENT:String		= "menuResizeEvent";
		
		public var menuRize:Number = 0;
		
		public function MenuResizeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}

