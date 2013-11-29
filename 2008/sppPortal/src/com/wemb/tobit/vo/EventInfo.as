package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.EventInfo")]
	[Bindable]
	public class EventInfo
	{
		public var sms_mgmt_svr:String;
		
		public var sms_mgmt_svr_name:String;
		
		public var message_number:String;
		
		public var host_name:String;
		
		public var severity:String;
		
		public var message_group:String;
		
		public var application:String;
		
		public var object:String;
		
		public var evt_coll_stime:String;
		
		public var dupl_count:int;
		
		public var text_part:String;
		
		public var lev2_gid:String;
		
		public var host_level:String;
	}
}