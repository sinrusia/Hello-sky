package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.SystemInfo")]
	[Bindable]	
	public class SystemInfo
	{
		public var group_name:String = "";
		public var group_id:String = "";
		public var gseq:String = "";
		public var host_label:String = "";
		public var host_name:String = "";
		public var host_ip:String = "";
		public var ums_yn:String = "";
		public var popup_yn:String = "";
		public var ticket_yn:String = "";
		public var check_visible:String;
	}
}
