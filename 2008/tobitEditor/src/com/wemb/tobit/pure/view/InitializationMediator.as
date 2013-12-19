////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.pure.view
{
	import com.wemb.puremvc.interfaces.INotification;
	import com.wemb.puremvc.patterns.mediator.Mediator;
	import com.wemb.puremvc.patterns.observer.Notification;
	import com.wemb.tobit.core.ApplicationConfig;
	import com.wemb.tobit.managers.HistoryManager;
	import com.wemb.tobit.managers.PageManager;
	import com.wemb.tobit.pure.Constants;
	import com.wemb.tobit.puremvc.TobitMapNotifications;
	import com.wemb.tobit.vo.PageInfo;
	import com.wemb.tobit.vo.Request;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	
	import flashx.textLayout.elements.BreakElement;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	import mx.formatters.DateFormatter;
	import mx.graphics.ImageSnapshot;
	import mx.graphics.codec.PNGEncoder;
	
	import screens.Initialization;
	import screens.util.CodeType;

	/**
	 * Main.mxml 화면 처리부분
	 * 
	 * @see org.puremvc.as3.patterns.mediator.Mediator
	 * 
	 * @langversion 3.0
	 */
	public class InitializationMediator extends Mediator
	{
		public static const NAME:String = "InitializationMediator";
		
		public var currentPageInfo:PageInfo = new PageInfo();
		
		private var encodebase64:String;
		
		private var snapshot:ImageSnapshot;
		
		private var request:URLRequest;
		
		private var variables:URLVariables;
		
		private var title:String;
		
		public function InitializationMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		
		override public function listNotificationInterests():Array
		{
			return [
				Notification.PAGE_CHANGE, 
				Constants.CONFIG_CHANGE,
				Constants.RTMP_CONNECTION_STATUS,
				Constants.ADD_HISTORY
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case Notification.PAGE_CHANGE:
					var info:PageInfo = notification.getBody() as PageInfo;
					pageProc(info);
				break;
				
				case Constants.CONFIG_CHANGE:
					var url:String = ApplicationConfig.getInstance().backgroundImage;
				break;
				
				case Constants.RTMP_CONNECTION_STATUS:
					//main.header.rtmpStatus = notification.getBody() as RTMPStatus;
				break;
				
				case Constants.ADD_HISTORY:
					rs_getAddHistory();
				break;
				
			}
		}
		
		
		/**
		 * change to selected Page
		 * 페이지 변경 요청이 왔을때 페이지 처리를 수행한다.
		 */
		public function pageProc(info:PageInfo):void
		{
			//동일한 페이지 그룹이면 수행하지 않는다.
			if( currentPageInfo.url == info.url)
			{
				return;
			}
			
			// 변경 페이지 정보 저장
			currentPageInfo = info;
			
			
			//페이지 타입을 체크합니다.
			// 플랙스 외의 다른 타입은 IFrame 에서 로딩하도록 합니다.
			switch(info.pageType)
			{
				case CodeType.INITPAGE:
				{
					changeToPage(info);
					break;
				}
					
			}
		}
		
		/**
		 * 플렉스로 제작된 페이지로의 전환 처리
		 */
		private function changeToPage(pageInfo:PageInfo):void
		{
			//존재하는 페이지인지 체크한다.
			var page:UIComponent = initialization.mainGroup.getChildByName(pageInfo.menuId) as UIComponent;
			
			if( page )
			{
				//페이지를 전환한다.
				initialization.viewChange(page, pageInfo);
			}
			else
			{
				//존재하지 않는 페이지이면 새로 생성한다.
				var cls:Class = PageManager.getPage(pageInfo.url);
				
				//등록된 페이지가 아니라면 처리를 종료한다.
				if( !cls )
					return;
				
				//페이지 초기화
				page = new cls() as UIComponent;
				page.visible = false;
				page.name = pageInfo.menuId;
				initialization.mainGroup.addElementAt(page, 0);
				
				//페이지를 전환한다.
				initialization.viewChange(page, pageInfo.initInfo);
			}
		}
		
		private function rs_getAddHistory():void{
			var pCnt:int = HistoryManager.getInstance().getAllHistory().length;
			var nCnt:int = HistoryManager.getInstance().getAllNext().length;
			
			btnStyle("prev_btn", false);
			btnStyle("next_btn", false);
			
			if(pCnt > 0){
				btnStyle("prev_btn", true);
			}			
			if(nCnt > 0){
				btnStyle("next_btn", true);
			}			
		}	
		
		private function btnStyle(target:String, enabled:Boolean):void{
			//main.header[target].enabled = enabled;
			//main.header[target].buttonMode = enabled;
		}

		
		private function get initialization():Initialization
		{
			return viewComponent as Initialization;
		}
	}
}