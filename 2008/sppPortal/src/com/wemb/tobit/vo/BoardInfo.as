package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.BoardInfo")]
	[Bindable]
	public class BoardInfo
	{		
		public var userId:String = "";
		public var category:String = "";
		public var title:String = "";
		public var description:String = "";
		public var createDt:String = "";
		public var updateId:String = "";
		public var updateDt:String = "";
		public var company:String = "";
	}
}