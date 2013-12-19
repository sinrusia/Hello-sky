package com.wemb.tobit.events
{
	import flash.events.Event;
	
	public class DataDispatcher extends Event
	{
		public static const CHANGE_EVENT:String		= "change";
		public static const FILTER_EVENT:String		= "filterChange";
		public static const SIZE_EVENT:String		= "sizeChange";
		public static const DOUBLE_EVENT:String 	= "doubleClickEvent";
		public static const CLICK_EVENT:String		= "clickEvent";
		public static const ACK:String				= "ack";
		public static const MESSAGE_ON_OFF:String	= "messageOnOff";
		public static const START_ACk_CHECK:String	= "startAckCheck";
		public static const GROUP_CHANGE:String		= "groupChange";
		
		//일일 업무 초기화
		public static const RESET_DAILY_STANDBY_CLICK:String = "resetDailyStandbyClick";
		
		public var result:Object;
				
		public function DataDispatcher(_type:String, __result:Object = null, bubbles:Boolean = false)
		{
			super(_type, bubbles);
			this.result = __result;
		}

	    override public function clone():Event
	    {   
	        return new DataDispatcher(type, result);
	    }	
	    
	}
}