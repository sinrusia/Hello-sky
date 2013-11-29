package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.GroupEventCount")]
	[Bindable]
	/**
	 * 이벤트 수 VO
	 * 
	 * @auther 
	 */	
	public class GroupEventCount
	{
		public var lev2_gid:String;
		public var critical:int;
		public var major:int;
		public var minor:int;
		public var warning:int;
		public var normal:int;
		public var own:int;
		public var outage:int;
	}
}