package com.wemb.tobit.vo
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="com.wemb.tobit.vo.SeverityInfo")]
	[Bindable]
	/**
	 * 그룹 장애 VO 객체
	 * 
	 * @auther 정태훈( thlife@wemb.co.kr )
	 */	
	public class HostSeverityInfo
	{
		public var index:int;
		public var level:int;
		public var id:String;
		public var mapId:String;
		public var subMapId:String;
		public var hostname:String;
		public var severity:String;
		
		public var child:ArrayCollection = new ArrayCollection();
		
	}
}