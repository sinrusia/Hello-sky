package com.wemb.tobit.events
{
	import flash.events.Event;

	public class EventBrowserDataChangeEvent extends Event
	{
		public static var BMS_EVENT_DATA_CHANGED:String = "isChangeBmsEventData";
		
		public var value:Boolean = true;
		
		public function EventBrowserDataChangeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}