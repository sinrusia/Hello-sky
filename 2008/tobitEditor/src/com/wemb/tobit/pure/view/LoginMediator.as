////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.pure.view
{
	import com.wemb.tobit.core.ApplicationConfig;
	import com.wemb.tobit.events.LoginEvent;
	import com.wemb.tobit.pure.Constants;
	
	import flash.external.ExternalInterface;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.FlexGlobals;
	import mx.messaging.config.ServerConfig;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.StringUtil;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import screens.Login;

	public class LoginMediator extends Mediator
	{
		public static const NAME:String = "LoginMediator";
		
		public function LoginMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			login.addEventListener(LoginEvent.TRY_LOGIN, loginProc); 
		}
		
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				default:
					break;
			}
		}
		
		/**
		 * proc login request
		 */
		private function loginProc(event:LoginEvent):void
		{
			var loginName:String	= StringUtil.trim(login.txtLoginName.text);
			var password:String		= StringUtil.trim(login.txtPassword.text);
			
			if( loginName  == "" )
			{
				Alert.okLabel = "OK";
				Alert.show("아이디를 입력하세요.", "알림", Alert.OK);
			}
			else if( password  == "" )
			{
				Alert.okLabel = "OK";
				Alert.show("비밀번호를 입력하세요.", "알림", Alert.OK);
			}
			else
			{
				var param:Object	= new Object();
				param.loginName		= loginName;
				param.password		= password;
				
				//sendTobitService(Constants.LOGIN, param, true);
			}
		}
		
		/**
		 * login page instance
		 */
		public function get login():Login
		{
			return viewComponent as Login;
		}
	}
}