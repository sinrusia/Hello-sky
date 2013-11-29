package com.wemb.tobit.vo
{
	public class PageInfo
	{
		//로딩할 페이지
		public var url:String;
		
		//페이지타입 정의
		// P1200 : Flex
		// P1100 : JSP
		public var pageType:String = "P1200";
		
		// 그룹 아이디
		public var groupId:String = "";
		
		// 이름
		public var menuName:String = "";		
		
		
		// 탭페이지 아이디
		public var tabId:String = "";
		
		public var pageClass:String = "";
		
		// 페이지 초기화 정보
		public var initInfo:Object = new Object();
		
		public var delay:Number = 0;
	}
}
