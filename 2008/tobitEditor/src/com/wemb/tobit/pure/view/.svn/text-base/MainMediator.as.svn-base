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
	import com.wemb.tobit.components.MainHeader;
	import com.wemb.tobit.core.ApplicationConfig;
	import com.wemb.tobit.core.TobitApplication;
	import com.wemb.tobit.managers.HistoryManager;
	import com.wemb.tobit.pure.Constants;
	import com.wemb.tobit.puremvc.TobitMapNotifications;
	import com.wemb.tobit.spark.components.TobitPage;
	import com.wemb.tobit.vo.PageInfo;
	import com.wemb.tobit.vo.Request;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.utils.flash_proxy;
	
	import flashx.textLayout.elements.BreakElement;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	import mx.formatters.DateFormatter;
	import mx.graphics.ImageSnapshot;
	import mx.graphics.codec.PNGEncoder;

	/**
	 * Main.mxml 화면 처리부분
	 * 
	 * @see org.puremvc.as3.patterns.mediator.Mediator
	 * 
	 * @langversion 3.0
	 */
	public class MainMediator extends Mediator
	{
		public static const NAME:String = "MainMediator";
		
		public var currentPageInfo:PageInfo = new PageInfo();
		
		private var encodebase64:String;
		
		private var snapshot:ImageSnapshot;
		
		private var request:URLRequest;
		
		private var variables:URLVariables;
		
		private var title:String;
		
		public function MainMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		
		override public function listNotificationInterests():Array
		{
			return [
				Notification.PAGE_CHANGE, 
				Constants.NAVI_EVENT,
				Constants.NAVI_CLOSE_EVENT,			
				Constants.CONFIG_CHANGE,
				Constants.RTMP_CONNECTION_STATUS,
				Constants.PRINT_SCREEN,
				Constants.ADD_HISTORY,
				Constants.MAIN_STARTUP,
				TobitMapNotifications.OPEN_TOBITMAP_POPUP,
				TobitMapNotifications.CLOSE_TOBITMAP_POPUP
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
				
				case Constants.PRINT_SCREEN:
					rs_printScreen();
				break;
				
				case Constants.ADD_HISTORY:
					rs_getAddHistory();
				break;
				
				case Constants.MAIN_STARTUP:
					main.start();
					break;
				
				case TobitMapNotifications.OPEN_TOBITMAP_POPUP:
					main.viewChange(main.blakPage, null);
					break;
				
				case TobitMapNotifications.CLOSE_TOBITMAP_POPUP:
					if (currentPageInfo){
						// U : Update, N : No Update
						var updateFlag:String = notification.getBody() as String;
						//존재하는 페이지인지 체크한다.
						var page:UIComponent = main.mainGroup.getChildByName(currentPageInfo.menuId) as UIComponent;
						// 구성정보가 업데이트 되면 페이지 정보를 초기화 한다.
						if (page is TobitPage) {
							TobitPage(page).resetMapComponent();
						}
						
						if (page)
						{
							//페이지를 전환한다.
							main.viewChange(page, info);
						}
					}
					break;
				
			}
		}
		
		private function rs_printScreen():void
		{
			var dfromat:DateFormatter = new DateFormatter();
			dfromat.formatString = "YYYY-MM-DD JJ:NN:SS";
			ImageSnapshot.defaultEncoder = PNGEncoder;
			
			var bit:Bitmap = new Bitmap();
			var bitmapData:BitmapData = new BitmapData( 1280, 953, true, 0xffffff  );
			//bitmapData.draw( main.mainCanvas, null );
			bitmapData.draw( main, null );
			bit.bitmapData = bitmapData;
					
								
			snapshot = ImageSnapshot.captureImage(bit);
			encodebase64 = ImageSnapshot.encodeImageAsBase64(snapshot);
			request = new URLRequest("image.jsp"); 
			variables = new URLVariables();

			var str:String = dfromat.format(new Date());

			title = str;
			variables.image = encodebase64;
			var t_arr:Array = str.split(" ");
			title = t_arr.join('');
			variables.title = str;
			request.method = "POST";
			request.data = variables;
			navigateToURL(request, '_self');		
		}
		
		private function loadingStart():void
		{
			/*if ( !loadingPopup )
			{
			loadingPopup = PopUpManager.createPopUp( portal as DisplayObject, TobitLoading, true) as TobitLoading;
			PopUpManager.centerPopUp(loadingPopup);
			}*/
		}
		
		private function loadingStop():void
		{
			/*if ( loadingPopup )
			{
			PopUpManager.removePopUp(loadingPopup);
			loadingPopup = null;
			}*/
		}
		
		/**
		 * change to selected Page
		 * 페이지 변경 요청이 왔을때 페이지 처리를 수행한다.
		 */
		public function pageProc(info:PageInfo):void
		{
			//동일한 페이지 그룹이면 수행하지 않는다.
			/*
			if( currentPageInfo.menuId == info.menuId)
			{
				return;
			}
			*/
			
			// 변경 페이지 정보 저장
			currentPageInfo = info;
			
			//페이지 타입을 체크합니다.
			// 플랙스 외의 다른 타입은 IFrame 에서 로딩하도록 합니다.
			switch(info.pageType)
			{
				default:
				{
					//changeToJsp(info);
				}
			}
		}
		
		
		/**
		 * 일반 JSP페이지로의 전환 처리
		 */
		private function changeToJsp(pageInfo:PageInfo):void
		{

		}
		
		/**
		 * 대시보드 맵편집 페이지로의 전환 처리
		 */
		private function changeToMap(pageInfo:PageInfo):void
		{
			//존재하는 페이지인지 체크한다.
			var page:UIComponent = main.mainGroup.getChildByName(pageInfo.menuId) as UIComponent;
			
			if (page)
			{
				//패이지 전환
				if (TobitApplication.user.userEditable == "Y") {
					TobitPage(page).mapEditable = true;
				} else {
					TobitPage(page).mapEditable = false;
				}
				main.viewChange(page, pageInfo.initInfo);
			}
			else
			{
				//새로운 패이지 생성
				//page = new leng
				page = new TobitPage();
				if (TobitApplication.user.userEditable == "Y") {
					TobitPage(page).mapEditable = true;
				} else {
					TobitPage(page).mapEditable = false;
				}
				
				page.percentWidth = 100;
				page.percentHeight = 100;
				page.visible = false;
				page.name = pageInfo.menuId;
				main.mainGroup.addElementAt(page, 0);
				
				// 페이지 전환
				main.viewChange(page, pageInfo.initInfo);
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
		
		private function get main():Main
		{
			return viewComponent as Main;
		}
	}
}