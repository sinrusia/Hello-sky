package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.PimPerf")]
	[Bindable]
	public class PimPerf
	{
		public var group_id:String = "";
		public var host_name:String = "";
		public var host_label:String = "";
		public var host_ip:String = "";
		public var stime:String = "";
		public var cpu_total:String = "";
		public var mem_total:String = "";
		public var swap:String = "";
		public var net_in_packet_rate:String = "";
		public var net_out_packet_rate:String = "";
	}
}
