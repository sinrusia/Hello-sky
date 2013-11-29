package com.wemb.tobit.events
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	public class MsgGroupAddEvent extends Event
	{
		public static const MSG_GROUP_ADD_EVENT:String = "msgGroupAddEvent";
		public static const MSG_GROUP_MINUS_EVENT:String = "msgGroupMinusEvent";

		public var winTarget:DisplayObject;
		
		public function MsgGroupAddEvent(type:String, bubbles:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}