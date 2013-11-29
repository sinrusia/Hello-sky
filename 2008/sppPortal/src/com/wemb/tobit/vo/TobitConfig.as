package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.TobitConfig")]
	[Bindable]	
	public class TobitConfig
	{
		public var ip_addr:String = "";
		public var target_type:String = "";
		public var code_name:String = "";
		public var prop_name:String = "";
		public var prop_value:String = "";
		public var prop_desc:String = "";
		public var prop_sort:String = "";
		public var edit_enable:String = "";
	}
}
