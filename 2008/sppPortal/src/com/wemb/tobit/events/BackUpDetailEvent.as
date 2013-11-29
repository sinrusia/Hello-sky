package com.wemb.tobit.events
{
	import flash.events.Event;

	public class BackUpDetailEvent extends Event
	{
		public static const BACKUP_DETAIL_EVENT:String = "BackUpDetailEvent";
		
		public var gid:String;
		public var part:String;
		public var jogi_type:String;
		public var host_name:String;
		public var checkdate:String;
		public var fullname:String;
		public var jogiObj:Object;
		public var stime:String;
		
		public function BackUpDetailEvent(type:String, bubbles:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}