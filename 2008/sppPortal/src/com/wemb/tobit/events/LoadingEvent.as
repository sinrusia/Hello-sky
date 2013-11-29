package com.wemb.tobit.events
{
	import flash.events.Event;

	public class LoadingEvent extends Event
	{
		
		public static const LOADING:String = "loading";
		
		public function LoadingEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}