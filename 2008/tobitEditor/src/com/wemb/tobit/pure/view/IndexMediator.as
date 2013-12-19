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
	import com.wemb.tobit.caurina.transitions.Equations;
	import com.wemb.tobit.core.ApplicationConfig;
	import com.wemb.tobit.core.TobitApplication;
	import com.wemb.tobit.factory.TobitComponentDefinition;
	import com.wemb.tobit.pure.Constants;
	import com.wemb.tobit.pure.model.TobitServiceProxy;
	import com.wemb.tobit.vo.Request;
	import com.wemb.tobit.vo.User;
	
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import flashx.textLayout.elements.BreakElement;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	import mx.messaging.channels.StreamingAMFChannel;
	import mx.skins.halo.WindowBackground;
	
	public class IndexMediator extends Mediator {
		public static const NAME:String	= "IndexMediator";
		
		public function IndexMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
		}
		
		//---------------------------------------------------------------
		//
		// Override
		//
		//---------------------------------------------------------------
		override public function listNotificationInterests():Array {
			return [
				Constants.VIEW_CHANGE,
				Constants.LOAD_PRELOADER,
				Constants.CHECK_LOGIN,
				Constants.LOGIN,
				Constants.LOGOUT,
				Constants.LOGOUT_MESSAGE,
				Constants.CONFIG_CHANGE,
				Constants.REQUEST_ERROR
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			switch(notification.getName()) {
				case Constants.VIEW_CHANGE:
					var target:String = notification.getBody() as String;
					if (target == "main") {
						view.viewChange(view.scrnMain);
					} else {
						view.viewChange(view.scrnLogin);
					}
				break;
				
				case Constants.CHECK_LOGIN:
					rs_checkLogin(notification.getBody() as Request);
					break;
				
				case Constants.LOAD_PRELOADER:
					var checkValue:Object = notification.getBody();
					if (checkValue.type == "load") {
						//view.loadPreload();
					} else {
						//view.closePreload();
					}
					break;
				case Constants.LOGIN:
					login();
					break;
				case Constants.LOGOUT:
					logout();
					break;
				case Constants.LOGOUT_MESSAGE:
					var request:Request = notification.getBody() as Request;
					trace(request.getResult("result"));
					var message:Object = request.getResult("result");
					if (message) {
						var checkUserId:String = message.userId;
						var checkIP:String = message.ip;
						if (TobitApplication.ip != checkIP) {
							if (TobitApplication.user) {
								if (TobitApplication.user.userId == checkUserId) {
									// 중복 로그인 체크하는 부분 주석 처리함
									// logout();
								}
							}
						}
					}
					break;
				case Constants.CONFIG_CHANGE:
					// 디자인 설정_백그라운드이미지 가져오기
					var appDesign:String = ApplicationConfig.getInstance().getAttribute("APP_DESIGN") as String;
					
					if (appDesign == 'design1' || appDesign == null) {
						view.styleManager.loadStyleDeclarations("Style_type01.swf");
					} else if (appDesign == 'design2') {
						view.styleManager.loadStyleDeclarations("Style_type02.swf");
					} else if (appDesign == 'design3') {
						view.styleManager.loadStyleDeclarations("Style_type03.swf");
					}
					// 디자인 설정_해상도 설정 가져오기
					var layoutConf:String =ApplicationConfig.getInstance().getAttribute("APP_LAYOUT") as String;
					if (layoutConf == "variable") {
						FlexGlobals.topLevelApplication.width="100%";
						FlexGlobals.topLevelApplication.height="100%";
					}
					var appResolution:String = ApplicationConfig.getInstance().getAttribute("APP_RESOLUTION") as String;
					trace("resolution_size : "+ appResolution);
					if (appResolution == "1920*1280") {
						FlexGlobals.topLevelApplication.width="1920";
						FlexGlobals.topLevelApplication.height="1280";
					} else if (appResolution == "1280*768") {
						FlexGlobals.topLevelApplication.width="1280";
						FlexGlobals.topLevelApplication.height="768";
					} else if (appResolution == "1280*1024") {
						FlexGlobals.topLevelApplication.width="1280";
						FlexGlobals.topLevelApplication.height="1024";
					}
					break;
				
				case Constants.REQUEST_ERROR:
//					view.viewChange(view.scrnErrorView);
					break;
			}
		}
		
		
		//-------------------------------------------------------
		//
		// Functions
		//
		//-------------------------------------------------------
		private function login():void {
			
			facade.sendNotification(Constants.VIEW_CHANGE, "main");
		}
		
		private function logout():void {
			
			//var proxy:TobitServiceProxy = facade.retrieveProxy(TobitServiceProxy.NAME) as TobitServiceProxy;
			//proxy.disconnect();
			
			navigateToURL(new URLRequest("logout.jsp"), "_self");
		}

		/**
		 * 인증여부 체크결과 처리
		 */
		private function rs_checkLogin(request:Request):void {
			var status:String = request.getResult("status") as String;
			var ip:String = request.getResult("ip") as String;
			// setting application status
			TobitApplication.authStatus = status;
			// setting client ip
			TobitApplication.ip = ip;
			
			switch(status) {
				case Constants.LOGIN_ON:
					// get user information
					var user:User = request.getResult("user") as User;
					// set user information on application configuration
					TobitApplication.user = user;
					// get application configuration and authentication menu
					facade.sendTobitService(Constants.GET_APP_CONFIG, {userId:user.userId, menuId:"ROOT"});
					// go to Main
					view.viewChange(view.scrnMain);
					break;
				
				case Constants.LOGIN_OFF:
					// send to Login Page
					//navigateToURL(new URLRequest("logout"), "_self");
					break;
				
				case Constants.NONEXISTENT:
					// send to Login Page
					//navigateToURL(new URLRequest("logout"), "_self");
					break;
				
				case Constants.INITIAL:
					view.styleManager.loadStyleDeclarations("Style.swf");
					view.viewChange(view.initialization);
					break;
				
				default:
					break;
				
			}
			
			// start Component Update
			var componentPack:String = request.getResult("componentPack") as String;
			
			if(componentPack == "updated") {
				// 
				var components:Array = TobitComponentDefinition.getInstance().getComponents();
				facade.sendTobitService(Constants.INIT_COMPONENT, {"components": components});
			}
		}
		
		private function get view():* {
			return viewComponent as tobitEditor;
		}
	}
}