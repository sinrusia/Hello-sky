package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.EventBrowserInfo")]
	[Bindable]
	/**
	 * EventBrowser VO
	 * 
	 * @auther 정태훈( thlife@wemb.co.kr )
	 */	
	public class EventBrowserInfo
	{
		public var messagenumber:String;

		public var severity:String;
		
		public var hostname:String;
		
		public var hostipadd:String;
		
		public var groupcode:String;
		
		public var groupname:String;
		
		public var messagegroup:String;
		
		public var application:String;
		
		public var object:String;
		
		public var stime:String;
		
		public var etime:String;
		
		public var text:String;
		
		public var userMobile:String;
		
		public var userName:String;
		
	}
}