package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.HostByLevel2Group")]
	[Bindable]	
	public class HostByLevel2Group
	{
		public var group_id:String = "";
		public var group_name:String = "";
		public var host_name:String = "";
		public var host_label:String = "";
		public var host_ip:String;
		public var select_yn:String;
		
		public var check_visible:String;
		public var target_id:String;
		
		public var asset_name:String = "";
			  			
	}
}
