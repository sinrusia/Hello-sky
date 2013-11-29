package com.wemb.tobit.vo
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="com.wemb.tobit.vo.HostSeverityInfo")]
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
		public var symbolId:String;
		
		public var mapId:String;
		public var subMapId:String;
		
		public var hostname:String;
		public var severity:String;
		public var count:Number;
		public var child:ArrayCollection = new ArrayCollection();
		
		//삼성화재 응답시간, 거래건수추가
		public var responseTime:String;		//응답시간
		public var transaction:String;		//거래건수		
	}
}


