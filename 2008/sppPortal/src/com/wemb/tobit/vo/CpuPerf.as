package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.CpuPerf")]
	[Bindable]
	public class CpuPerf
	{
		public var host_name:String = "";
		public var stime:String = "";
		public var host_ip:String = "";
		public var host_label:String = "";
		public var sys_yongdo:String = "";
		public var cpu_sys:String = "";
		public var cpu_user:String = "";
		public var cpu_wio:String = "";
		public var cpu_total:String = "";
	}
}
