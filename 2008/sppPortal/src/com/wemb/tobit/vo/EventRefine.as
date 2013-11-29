package com.wemb.tobit.vo
{	
	[RemoteClass(alias="com.wemb.tobit.vo.EventRefine")]
	[Bindable]
	public class EventRefine
	{
		public var class_name:String = "";
		public var event_name:String = "";
		public var event_type:String = "";
		public var msg_exp_object_chk:String = "";
		public var msg_exp_stat_chk:String = "";
		public var msg_exp_account_chk:String = "";
		public var msg_exp_client_chk:String = "";
		public var severity:String = "";
		public var use_yn:String = "";
		public var refine_event_type:String = "";
		public var refine_msg_grp:String = "";
		public var refine_application:String = "";
		public var refine_object:String = "";
		public var refine_severity:String = "";
		public var refine_msg_txt:String = "";
		public var evt_desc:String = "";
	}
}