package com.wemb.tobit.event
{
	import flash.events.Event;
	public class DataDispatcher extends Event
	{
		public static const CHANGE_EVENT:String = "change";
		public static const FILTER_EVENT:String = "filterChange";
		public static const SIZE_EVENT:String = "sizeChange";
		public static const DOUBLE_EVENT:String = "doubleClickEvent";
		public static const CLICK_EVENT:String = "clickEvent";
		
		
		public var result:Object;
				
		public function DataDispatcher(_type:String, __result:Object)
		{
			super(_type);
			this.result = __result;			
		}

	    override public function clone():Event{   
	        return new DataDispatcher(type, result);
	    }	
	    
	}
}