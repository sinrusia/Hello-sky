package com.wemb.tobit.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class OwnEvent extends Event
	{
		public static const OWN_EVENT:String = "OwnEvent";
		
		public var ownList:ArrayCollection;
		public var severity:String;
		
		public function OwnEvent(type:String, bubbles:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}