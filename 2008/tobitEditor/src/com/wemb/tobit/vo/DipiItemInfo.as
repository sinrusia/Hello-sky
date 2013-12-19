package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.DipiItemInfo")]
	[Bindable]
	/**
	 * DIPI 성능 항목
	 * 
	 * @auther sp team
	 */	
	public class DipiItemInfo
	{
		public var id:String;
		public var name:String;
		public var unit:String;
		public var duration:int;
		public var minimum:int;
		public var maximum:int;
		public var disp:String;
		public var sortOrder:int;
	}
}