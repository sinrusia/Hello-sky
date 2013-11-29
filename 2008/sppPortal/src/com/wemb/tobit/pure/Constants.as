/**
 *	Copyright (C) 2004-2009 WeMB INC. 
 *	All Rights Reserved.
 *	@date			:	2009-04-07
 *	@auther			:	고재학
 *	@ver			:	1.0
 *	@description 	:	
 *	
**/
package com.wemb.tobit.pure
{
	import mx.utils.UIDUtil;
	
	public class Constants
	{
		public function Constants()
		{
			
		}

		//public static var ChartFolling_TimeOut_Second:int = 300;
		
		//--------------------------------------------------------------------------
		//
		// Commands
		//
		//--------------------------------------------------------------------------
		
		
		public static const APP_STARTUP:String				= "appStartup";				// Applicatiion 최초 시작시 ApplicationFacade을 로딩하고 시작합니다.
		public static const REGISTER_XCANVAS:String			= "registerXCanvas";		// XCanvas 페이지를 등록 처리 한다.
		public static const REMOVE_XCANVAS:String			= "removeXCanvas";			// XCanvas 페이지를 삭제 처리 한다.
		public static const RTMP_CONNECTION_STATUS:String	= "rtmpConnectionStatus";
		public static const TOBIT_SERVICE:String			= "tobitService";			//TobitService
		public static const TOBIT_RTMP:String				= "tobitRTMP";				//TobitRTMP
		public static const TOBIT_HTTP_SERVICE:String		= "tobitHttpService";		//TobitHttpService
		
		//public static const PAGE_CHANGE:String			= "pageChange";				// 페이지 변경 처리를 수행한다.		
		//public static const CONFIG_CHANGE:String			= "configChange";			// Application 환경설정 정보가 변경되었을때 호출
		//public static const MAIN_STARTUP:String			= "mainStartup";			// Application의 환경설정 내용을 로딩후에 Main 화면을 시작한다.		
		//public static const TAB_CHANGE:String				= "tabChange";		
		//public static const ADD_HISTORY:String			= "addHistory";		
		//public static const PRINT_SCREEN:String			= "printScreen";			// 화면 캡처		
		//public static const NAVI_EVENT:String				= "naviEvent";
		//public static const NAVI_CLOSE_EVENT:String		= "naviCloseEvent";
		
		//--------------------------------------------------------------------------
		//
		// server push
		//
		//--------------------------------------------------------------------------
		public static const SERVER_TIME:String 				= "baseService.getServerTime";	
		//public static const NEW_EVENT:String 				= "bmcEventBrowserService.newEvent";
		

		//--------------------------------------------------------------------------
		//
		// Portal Service Commands
		//
		//--------------------------------------------------------------------------		
		public static const GET_USER_INFO:String = "portalService.getUserInfo";
		public static const SET_USER_INFO:String = "portalService.setUserInfo";
		
		public static const GET_MENU_LIST:String = "portalService.getMenuList";
		public static const GET_MYMENU_LIST:String = "portalService.getMyMenuList";
		public static const SET_MYMENU_MODIFY:String = "portalService.setMyMenuModify";
		public static const GET_LINKSITE_LIST:String = "portalService.getLinkSiteList";
		
		public static const GET_NOTICE_LIST:String = "portalService.getNoticeList";
		public static const GET_QNA_LIST:String = "portalService.getQnAList";
		public static const GET_KNOWLEDGE_LIST:String = "portalService.getKnowledgeList";
		public static const GET_FILEROOM_LIST:String = "portalService.getFileRoomList";
	
		public static const GET_TODAYWORK_LIST:String = "portalService.getTodayWorkList";
		public static const GET_WORK_DETAIL:String = "portalService.getWorkDetail";
		public static const GET_MONTHLY_CNT:String = "portalService.getMonthlyCnt";
	
	
		//public static const LOGIN:String = "adminService.login";
		//public static const LOGOUT:String = "adminService.logOut";
		
		//public static const ISLOGIN:String = "portalService.isLogin";
		
		
		// 어플리케이션 설정정보를 가져온다.
		//public static const GET_APP_CONFIG:String = "adminService.getAppConfig";		

		//--------------------------------------------------------------------------
		//
		// 로딩
		//
		//--------------------------------------------------------------------------
		//public static const LOADING_START:String = "loadingStart";
		//public static const LOADING_STOP:String = "loadingStop";		
						
		//--------------------------------------------------------------------------
		//
		// status
		//
		//--------------------------------------------------------------------------
		public static const LOGIN_ON:String		= "loginON";
		public static const LOGIN_OFF:String	= "loginOFF";		
	}
}