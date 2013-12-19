package com.wemb.tobit.events
{
	import flash.events.Event;

	public class LegendEvent extends Event
	{
		public static var LEGEND_CLICK:String = "legendClick";
		
		public var code:String = "";
		public var name:String = "";
		public function LegendEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}