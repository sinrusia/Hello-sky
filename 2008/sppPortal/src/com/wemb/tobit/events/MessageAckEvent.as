package com.wemb.tobit.events
{
	import flash.events.Event;

	public class MessageAckEvent extends Event
	{
		public static const MESSAGE_ACK_EVENT:String = "MessageAckEvent";	
		
		public var MessageObj:Object;
		
		public function MessageAckEvent(type:String, bubbles:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}