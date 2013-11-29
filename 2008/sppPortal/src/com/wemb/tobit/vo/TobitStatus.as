package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.TobitStatus")]
	[Bindable]	
	public class TobitStatus
	{
		public var ip_addr:String = "";
		public var comm_status:String = "";
		public var proc_status:String = "";
		public var data_status:String = "";
		public var status_update_time:String = "";
		public var systime:String = "";
		public var host_name:String = "";
		public var lev2_group:String = "";
		public var code_name:String = "";
		public var agent_name:String = "";
		public var result_code:String = "";
		public var target_type:String = "";
	}
}
