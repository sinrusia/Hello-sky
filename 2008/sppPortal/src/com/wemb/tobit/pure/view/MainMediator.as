/**
 *	Copyright (C) 2004-2009 WeMB INC. 
 *	All Rights Reserved.
 *	@date			:	2009-04-07
 *	@auther			:	고재학
 *	@ver			:	1.0
 *	@description 	:	
 *	
**/
package com.wemb.tobit.pure.view
{
	import com.wemb.tobit.core.ApplicationConfig;
	import com.wemb.tobit.pure.Constants;
	import com.wemb.tobit.vo.PageInfo;
	import com.wemb.tobit.vo.Request;
	import com.wemb.tobit.vo.ServerTime;
	import com.wemb.tobit.vo.UserInfo;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import screens.Main;

	public class MainMediator extends Mediator
	{
		public static const NAME:String = "MainMediator";
		
		public var currentPageInfo:PageInfo = new PageInfo();
		
		private var request:URLRequest;
		
		private var variables:URLVariables;
		
		private var title:String;
		
		public function MainMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			initTimer();
		}
		
		
		override public function listNotificationInterests():Array
		{
			return [
				Constants.PAGE_CHANGE, 
				Constants.CONFIG_CHANGE,
				Constants.LOGOUT,
				Constants.GET_TICKER_LIST,
				Constants.RTMP_CONNECTION_STATUS,
				Constants.MAIN_STARTUP,
				Constants.SERVERTIME,
				Constants.LOADING_START,
				Constants.LOADING_STOP							
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case Constants.PAGE_CHANGE:
					var info:PageInfo = notification.getBody() as PageInfo;
					pageProc(info);
				break;
				
				case Constants.LOGOUT:
					//현재 페이지 정보를 초기화한다
					currentPageInfo = new PageInfo();
					//로그아웃 처리
					main.logoutProc();
				break;
				
				case Constants.GET_TICKER_LIST:
					rs_getTickerList( notification.getBody() as Request );
				break;
				
				case Constants.CONFIG_CHANGE:
					var url:String = ApplicationConfig.getInstance().backgroundImage;
					if( url != null && url != "" )
						main.MainLayer.setStyle("backgroundImage", url);
				break;
				
				case Constants.RTMP_CONNECTION_STATUS:
					//main.header.rtmpStatus = notification.getBody() as RTMPStatus;
				break;

				/* case Constants.NAVI_EVENT:
					rs_naviEvent();
					break;
				case Constants.NAVI_CLOSE_EVENT:
					rs_naviCloseEvent();
					break;
				case Constants.MAIN_STARTUP:
					main.start();
					break; */
					
				case Constants.SERVERTIME:
					rs_serverTime(notification.getBody() as Request);	
					break;			
					
					
				case Constants.LOADING_START:
					rs_loadingStart(notification.getBody() as Object);
					break;

				case Constants.LOADING_STOP:
					rs_loadingStop(notification.getBody() as Request);
					break;
												
			}
		}
		
		private function rs_loadingStart(request:Object):void{
			PopUpManager.bringToFront( main.loading );
			PopUpManager.centerPopUp( main.loading );
			main.loading.visible = true;
			main.loading.loadingVal = true;
			try{
				if(request.msg != null){
					main.loading.msg = request.msg;
				} else {
					main.loading.msg = "화면 구성 중입니다.<br>잠시만 기다려 주세요.";
				}
			} catch(err:Error){
				main.loading.msg = "화면 구성 중입니다.<br>잠시만 기다려 주세요.";
			}
		}

		private function rs_loadingStop(request:Request):void{
			main.loading.visible = false;
			main.loading.loadingVal = false;
		}		
		
		
        private function rs_serverTime(request:Request):void{
			try{
				var time:String = request.result.toString();
				ServerTime.getInstance().serverTime = time;
				//main.header.txtClock.text = time;
					
			} catch(err:Error){}
		}
		
        [Bindable]private var totmem:Number = 0;
        [Bindable]private var maxmem:Number = 0;
		
		private var isFirstServerTimer:Boolean = true;
		private var serverTimer:Timer;
		private var _localtime:String;
		private var _servertime:String;
        private var temp_time:String
        private var cur_time:String;
		
		private function initTimer():void 
		{
 			serverTimer = new Timer(60000);
            serverTimer.addEventListener(TimerEvent.TIMER, serverTimerHandler);
            serverTimer.start();
        }
        		
        private function serverTimerHandler(event:TimerEvent):void
        {
/*         	totmem = flash.system.System.totalMemory;
            maxmem = Math.max(maxmem, totmem);
            if ( maxmem/1048576 > 100 )
            {
            	if ( event == null ) reload(true);
            	else reload(false);
            } */
            
            facade.sendTobitService( Constants.GET_TICKER_LIST );
        }        
        
		
        private function reload(type:Boolean=false):void
        {
        	
        }
        
		
		public function pageProc(info:PageInfo):void
		{			
			//동일한 페이지 그룹이면 수행하지 않는다.
			if( currentPageInfo.url == info.url){
				return;
			}
						
			currentPageInfo = info;
				
			main.mainCanvas.remove();
			
			main.mainCanvas.visible = true;
			main.mainCanvas.initInfo = info.initInfo;
			
			main.mainCanvas.url = "/tobit/screens/" + info.url + ".swf";
			
			if(info.pageType == "tobit")
			{
			}
			else
			{
				
			}
					
						
			/* 			
			//동일한 페이지 그룹이면 수행하지 않는다.
			if( currentPageInfo.url == info.url)
			{
				return;
			}
			
			// 변경 페이지 정보 저장
			currentPageInfo = info;
			
			//페이지 타입을 체크합니다.
			// 플랙스 외의 다른 타입은 IFrame 에서 로딩하도록 합니다.
			// C000000001 : Flex
			// C000000002 : JSP
			main.header.headerTitle_txt.text = info.menuName;


			if(info.pageType == "tobit")
			{
				// Iframe의 모든 영역 정보를 삭제한다.
				main.removeIFrame();
				
				//존재하는 페이지인지 체크한다.
				var page:UIComponent = main.mainCanvas.getChildByName(info.url) as UIComponent;
				
				if( page )
				{
					//페이지를 전환한다.
					main.viewChange(page, info.initInfo);
				}
				else
				{
					//존재하지 않는 페이지이면 새로 생성한다.
					var cls:Class = PageManager.getPage(info.url);
	
					//등록된 페이지가 아니라면 처리를 종료한다.
					if( !cls )
						return;
					
					//페이지 초기화
					page = new cls() as UIComponent;
					page.visible = false;
					XCanvas(page).id = info.url;
					XCanvas(page).name = info.url;
					main.mainCanvas.addChildAt(page, 0);
					
					//페이지를 전환한다.
					main.viewChange(page, info.initInfo);
				}
			}
			else
			{
				openIFrame(info);
			}
				
			//버튼 선택 처리
			var list:Array = main.header.navigate.naviBtn.getChildren();
			for(var i:int = 0; i < list.length; i++)
			{
				//var nb:NavigateButton = list[i] as NavigateButton;
				var nb:NavigateButton_white = list[i] as NavigateButton_white;
				if( info.url != nb.subId )
				{
					nb.selected = false;
				}
				else
				{
					nb.selected = true;
				}
			} */
		}
					
		
		/**
		 * 티커 조회
		 * */	
		private function rs_getTickerList( request:Request):void
		{
			//main.header.tickerList = new ArrayCollection(request.result as Array);
		}
		
		private function get main():Main
		{
			return viewComponent as Main;
		}
	}
}