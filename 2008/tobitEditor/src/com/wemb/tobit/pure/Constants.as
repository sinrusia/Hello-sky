////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.pure
{
	import flash.text.StaticText;
	
	import mx.utils.UIDUtil;
	
	public class Constants
	{
		
		//--------------------------------------------------------------------------
		//
		// Commands
		//
		//--------------------------------------------------------------------------
		// Application 환경설정 정보가 변경되었을때 호출
		public static const CONFIG_CHANGE:String			= "configChange";
		// Application의 환경설정 내용을 로딩후에 Main 화면을 시작한다.
		public static const MAIN_STARTUP:String				= "mainStartup";
		// 
		public static const RTMP_CONNECTION_STATUS:String	= "rtmpConnectionStatus";
		//장애 발생시 알람
		public static const ADD_HISTORY:String				= "addHistory";
		// 화면 캡처
		public static const PRINT_SCREEN:String				= "printScreen";
		public static const NAVI_EVENT:String				= "naviEvent";
		public static const NAVI_CLOSE_EVENT:String			= "naviCloseEvent";
		//메인화면전환
		public static const VIEW_CHANGE:String				= "viewChange";
		// 로그인 결과 처리
		public static const LOAD_PRELOADER:String			= "loadPreloader";
		// 브라우저매니저(히스토리매니저)에서 페이지 변경
		public static const LOADING_STOP:String = "loadingStop";
		// 요청 에러
		public static const REQUEST_ERROR:String = "requestError";
		
		
		// TICKER
		public static const GET_TICKER_LIST:String 		= "managerService.getTickerList";
		// alerm minute
		public static const ALARM_1MINUTE:String = "";
		// alerm hour
		public static const ALARM_1HOUR:String = "";
		
		//챠트 폴링시 임계값 (임계값보다 시간차가 크면 해당 챠트 데이터를 챠트에 반영하지 않고 버림.
		public static var ChartFolling_TimeOut_Second:int = 300;
		
		
		//--------------------------------------------------------------------------
		//
		// Socket Config
		//
		//--------------------------------------------------------------------------
		public static const SYSMON_URL:String = "";
		
		public static const SYSMON_PORT:int = 0;
		
		//--------------------------------------------------------------------------
		//
		// Admin Service Commands
		//
		//--------------------------------------------------------------------------
		// 설정정보 조회
		public static const GET_APP_CONFIG:String	= "adminService.getAppConfig";
		// SSO Check
		public static const CHECK_LOGIN:String		= "adminService.checkLogin";
		// Update Application Config Information
		public static const UPDATE_APPLICATION_CONFIG:String = "adminService.updateApplicationConfig";
		
		//-------------------------------------------------------------------------------
		// 
		// 공통 요청 명령어
		// 
		//-------------------------------------------------------------------------------
		public static const GET_CODE_LIST:String			= "commonService.getCodeList";	// 코드 목록 조회하기
		
		
		
		
		
		//--------------------------------------------------------------------------
		//
		// TOBIT Map Editor
		//
		//--------------------------------------------------------------------------
		
		// Select Map Information
		public static const GET_MAP:String				= "tobitMapService.getMap";
		// update Map Information
		public static const SAVE_MAP:String				= "tobitMapService.saveMap";
		// get Asset List
		public static const GET_ASSET_LIST:String		= "tobitMapService.getAssetList";
		// get Map Status
		public static const GET_MAP_STATUS:String		= "tobitMapService.getMapStatus";
		//get subEvent List
		public static const SUB_EVENT_LIST:String	= "tobitMapService.subEventList";
		//get subEventCount List
		public static const SUB_EVENT_COUNT:String	= "tobitMapService.subEventCount";
		//-------------------------------------------------------------------------------
		//
		// manager 관리자 페이지
		//
		//-------------------------------------------------------------------------------
		// 코드 관리
		public static const SELECT_CODE_TREE:String 	= "managerService.selectCodeTree";	// 그룹 목록 조회
		public static const SELECT_CODE_LIST:String 	= "managerService.selectCodeList";		// 코드 목록 리스트 형식 조회
		public static const UPDATE_CODE_LIST:String 	= "managerService.updateCodeList";	// 코드목록 업데이트
		
		// 메뉴 관리
		public static const SELECT_MENU_TREE:String		= "managerService.selectMenuTree";
		public static const SELECT_MENU_LIST:String		= "managerService.selectMenuList";
		public static const UPDATE_MENU_LIST:String		= "managerService.updateMenuList";
		//public static const PAGE_TYPES:String				= "managerService.pageTypes";
		
		// 사용자 & 부서별 권한관리
		public static const SELECT_USER_LIST:String		= "managerService.selectUserList";
		public static const UPDATE_USER_LIST:String		= "managerService.updateUserList";
		
		public static const SELECT_DEPARTMENT_TREE:String		= "managerService.selectDepartmentTree";
		public static const SELECT_DEPARTMENT_LIST:String		= "managerService.selectDepartmentList";
		public static const UPDATE_DEPARTMENT_LIST:String		= "managerService.updateDepartmentList";
		
		
		
		public static const SELECT_GRADES:String		= "managerService.selectGrades";
		
		
		//권한 관리
		public static const UPDATE_GRADES:String		= "managerService.updateGrades";		//권한 정보 업데이트
		public static const SELECT_MENUGRADES:String	= "managerService.selectMenuGrades";	//메뉴조회(접근가능한 메뉴 정보 포함)
		public static const UPDATE_MENUGRADES:String	= "managerService.updateMenuGrades";	//메뉴 권한정보 업데이트
		
		//장비 심볼 관리
		public static const GROUP_LIST:String 			= "managerService.groupList";	// 그룹 목록 조회
		public static const ASSET_LIST:String 			= "managerService.assetList";	// 자산목록 조회
		public static const SYMBOL_LIST:String 			= "managerService.symbolList";	// 심볼목록 조회
		public static const ASSET_UPDATE:String 		= "managerService.assetUpdate";	// 자산정보 업데이트
		
		public static const GET_SYMBOL_LIST:String		= "managerService.getSymbolList";	// 심볼 관리 리스트
		public static const UPDATE_SYMBOLS:String		= "managerService.updateSymbols";	// 심볼정보 업데이트
		
		// 등급 관리
		public static const SELECT_GRADE_LIST:String		= "managerService.selectGradeList";
		public static const UPDATE_GRADE_LIST:String		= "managerService.updateGradeList";
		public static const SELECT_GRADE_USER_LIST:String		= "managerService.selectGradeUserList";
		public static const UPDATE_GRADE_USER_LIST:String		= "managerService.updateGradeUserList";
		public static const SELECT_GRADE_MENU_TREE:String	= "managerService.selectGradeMenuTree";
		public static const UPDATE_GRADE_MENU_LIST:String		= "managerService.updateGradeMenuList";
		
		//그룹 관리
		public static const SELECT_ASSET_OWN_LIST:String 	= "managerService.selectAssetOwnList";	// 소유자산목록 조회
		public static const SELECT_ASSET_NON_LIST:String 	= "managerService.selectAssetNonList";	// 비소유자산목록 조회
		public static const UPDATE_GROUP_ASSET_LIST:String 	= "managerService.updateAssetList";	// 자산목록 업데이트
		
		//업무 그룹 관리
		public static const SELECT_BIZ_GROUP_TREE:String	= "managerService.getBizGroupTreeList";	//업무그룹 트리
		public static const SELECT_BIZ_OWN_LIST:String 		= "managerService.selectBizOwnList";	// 업무 소유자산목록 조회
		public static const SELECT_BIZ_NON_LIST:String 		= "managerService.selectBizNonList";	// 업무 비소유자산목록 조회
		public static const UPDATE_BIZ_ASSET_LIST:String 	= "managerService.updateBizAssetList";	// 업무 그룹 리스트
		public static const UPDATE_GROUP_BIZ_LIST:String 	= "managerService.updateGroupBizList";	// 업무 그룹 리스트
		
		//인터페이스 관리
		public static const SELECT_INTERFACE_LIST:String	= "managerService.selectInterfaceList";	// 인터페이스 목록 리스트 조회
		public static const UPDATE_INTERFACE_LIST:String	= "managerService.updateInterfaceList";	// 인터페이스 목록 리스트 업데이트
		
		// 메뉴 관리
		public static const SELECT_GROUP_TREE:String		= "managerService.getGroupTreeList";
		public static const UPDATE_GROUP_LIST:String		= "managerService.updateGroupList";
		public static const SELECT_GROUP_LIST:String		= "managerService.getGroupList";
		
		
		// Notification 관리
		public static const SELECT_NOTIFICATION_LIST:String	= "managerService.selectNotificationList"; // notification 리스트 조회
		public static const UPDATE_NOTIFICATION_LIST:String = "managerService.updateNotification"; // notification 업데이트
		
		//컴포넌트 관리
		public static const SELECT_COMPONENT:String			= "managerService.selectComponent";
		public static const UPDATE_COMPONENT:String			= "managerService.updateComponent";
		public static const INIT_COMPONENT:String			= "managerService.initComponent";
		public static const SELECT_COMPONENT_INTERFACE:String = "managerService.selectComponentInterface";
		
		//컴포넌트 관리
		public static const SELECT_MAP:String				= "managerService.selectMap";
		public static const UPDATE_MAP:String				= "managerService.updateMap";
		
		//맵 구성정보 관리
		public static const SELECT_MAP_COMP:String          = "managerService.selectMapComp";
		public static const UPDATE_MAP_COMP:String          = "managerService.updateMapComp";
		
		// 환경설정 관리
		public static const SELECT_CONFIGURATION:String		= "managerService.selectConfiguration";
		public static const UPDATE_CONFIGURATION:String		= "managerService.updateConfiguration";
		
		//--------------------------------------------------------------------------
		//
		// 시스템 성능(자원) 현황
		//
		//--------------------------------------------------------------------------
		
		public static const SELECT_CPU_BY_GROUP:String = "perfService.getCpuByGroup";
		public static const SELECT_MEMORY_BY_GROUP:String = "perfService.getMemoryByGroup";
		public static const SELECT_CPU_PERF_KEY:String = "getCpuPerf"; 
		
		public static const SELECT_DIPI_LIST2:String = "performanceService.selectDipiList";
		
		//--------------------------------------------------------------------------
		//  tobit i/f Agent 관리/agent 상
		//
		//--------------------------------------------------------------------------
		public static const GET_TOBIT_AGENT_LIST:String 			= "managerService.selectCodeList"; 
		public static const GET_TOBIT_MANAGER_STATUS:String 		= "agentService.getTobitManagerStatus";
		public static const GET_TOBIT_AGENT_STATUS:String 			= "agentService.getTobitAgentStatus";
		public static const GET_TOBIT_AGENT_ERROR_STATUS:String 	= "agentService.getTobitAgentErrorStatus";
		public static const GET_AGENT_CONTROL_KEY:String = "GetAgentControlKey";
			
			
		//--------------------------------------------------------------------------
		//
		// status
		//
		//--------------------------------------------------------------------------
		public static const LOGIN_ON:String		= "loginOn";
		public static const LOGIN_OFF:String	= "loginOff";
		public static const NONEXISTENT:String	= "nonexistent";
		public static const INITIAL:String		= "initial";
		
		
		public static const NETWORK_ASSET:String = "network";
		public static const SERVER_ASSET:String = "server";
		public static const PAGE_TYPES:String	= "loginOFF";
		
		public static const LOGIN:String				= "adminService.login";
		public static const LOGOUT:String				= "adminService.logOut";
		
		
		// Paga0603(계획된 장애)
		public static const GET_SCHEDULE:String = "notiService.getSchedule";
		public static const GET_SCHEDULE_MODIFY:String = "notiService.getScheduleModify";

		//page0600 이벤트 통보 설정(시스템별)
		public static const GET_GROUP_LIST:String = "baseService.getGroupList";
		public static const GET_SYSTEMS:String = "notiService.getSystems"; // 시스템 설정 리스트
		public static const GET_SYSTEMS_MODIFY:String = "notiService.getSystemsModify"; // 시스템 설정 수정
		public static const GET_MESSAGE_GROUPS_BY_HOST:String = "notiService.getMessageGroupsByHost"; // 메시지 그룹 설정 수정
		public static const DELETE_MESSAGE_GROUPS:String = "notiService.deleteMessageGroups"; // 메시지 그룹 삭제
		public static const GET_MESSAGE_DETAIL:String = "notiService.getMessageDetail"; // 메시지 그룹 삭제
		public static const GET_MESSAGE_DETAIL_MODIFY:String = "notiService.getMessageDetailModify"; // 메시지 그룹 삭제
		public static const DELETE_DETAIL_OF_USER:String = "notiService.deleteDetailOfUser"; // 메시지 그룹 삭제
		public static const GET_MESSAGE_GROUPS_MODIFY:String = "notiService.getMessageGroupsModify";
		public static const GET_MESSAGE_GROUPS:String = "notiService.getMessageGroups";

		//page0601 이벤트 통보 설정(사용자별)
		
		public static const GET_TEAMS:String = "baseService.getTeams";
		public static const GET_NOTI_USERS:String = "notiService.getNotiUsers";
		public static const GET_NOTI_USERS_MODIFY:String = "notiService.getNotiUsersModify";
		public static const GET_NOTI_SYSTEMS_BY_USER:String = "notiService.getSystemsByUser";
		public static const UPDATE_NOTI_SYSTEMS_BY_USER:String = "notiService.updateSystemsByUser";
		
		public static const GET_USERS:String = "baseService.getUsers";
		public static const COPY_USER:String = "notiService.copyUser";
		
		
		//systemCopyPopup
		public static const COPY_SYSTEM:String = "notiService.copySystem";
		public static const COPY_SCHEDULE:String = "notiService.copySchedule"; // 시스템 설정 리스트
		
		
		//NotiUserADdPopup
		public static const INSERT_MESSAGE_DETAIL:String = "notiService.getMessageDetailInsert";
		
		// Push Message
		public static const LOGOUT_MESSAGE:String = "pushMessageService.logout";

		public static function resultCommand(command:String):String
		{
			return command + "Result";
		}
		
		public static function removeResult(command:String):String
		{
			return command.replace("Result", "");
		}
		//기존화면 기존신한카드 ED ===================================================================
		
		
		//--------------------------------------------------------------------------
		//
		// locale
		//
		//--------------------------------------------------------------------------
		public static const KO_KR:String = "ko_KR";
		public static const EN_CN:String = "en_CN";
		public static const EN_US:String = "en_US";
		
		
		//--------------------------------------------------------------------------
		//
		// 노드별 성능 현황 챠트
		//
		//--------------------------------------------------------------------------
		public static const GET_LEVEL2_GROUPS:String = "";
		public static const GET_PIM_CPU_TEN_BY_NONE:String = "";
		public static const SOCKET_STOP:String = "";
		public static const SOCKET_START:String = "";
		public static const W001:String = "";
		public static const GET_PERFMON_KEY:String = "";
		public static const GET_SERVER_PER_KEY:String = "";
		public static const GET_SERVER_PER_XML:String = "";
		public static const GET_HOST_BY_LEVEL2_GROUP:String = "baseService.getHostByLevel2Group";
		public static const GET_PIM_TEN_BY_GROUP:String = "";
		public static const GET_TMAX_BY_UPMU_DETAIL:String = "";
		
		//hanwha
		public static const GET_APP_DATA_LIST:String = "managerService.getAPPDataList";
	}
}