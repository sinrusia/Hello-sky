package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.GroupInfo")]
	public class GroupInfo
	{
		public var id:String;
		public var index:String;
		public var level:String;
		public var name:String;
		public var label:String;
		public var icon:String;
		public var symbolId:String;
		public var symbolName:String;
		public var componentName:String;
		
		public var children:Array;
	}
}