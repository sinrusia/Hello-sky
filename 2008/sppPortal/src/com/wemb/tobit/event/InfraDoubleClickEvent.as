package com.wemb.tobit.event
{
	import flash.events.Event;

	public class InfraDoubleClickEvent extends Event
	{
		public static const INFRA_DOUBLE_CLICK_EVENT:String = "InfraDoubleClickEvent";	
		
		public var title:String;
		
		public var code:String;
		
		public var subMapId:String;
		
		
		public function InfraDoubleClickEvent(type:String, bubbles:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}