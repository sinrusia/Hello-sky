package com.wemb.tobit.events
{
	import flash.events.Event;

	public class SymbolClickEvent extends Event
	{
		public static const GROUP_SYMBOL_CLICK:String		= "groupSymbolClick";
		
		public var symbolInfo:Object;
		
		public function SymbolClickEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}