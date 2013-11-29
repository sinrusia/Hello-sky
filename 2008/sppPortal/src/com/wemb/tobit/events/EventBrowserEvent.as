package com.wemb.tobit.events
{
	import flash.events.Event;

	public class EventBrowserEvent extends Event
	{
		public static var STOP_EVENT:String = "isStopEvent";
		
		public var value:Boolean = false;
		
		public function EventBrowserEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}