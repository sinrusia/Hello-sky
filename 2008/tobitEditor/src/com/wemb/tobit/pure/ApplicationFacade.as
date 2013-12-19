////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.pure	
{
	import com.wemb.puremvc.Commands;
	import com.wemb.puremvc.patterns.facade.Facade;
	import com.wemb.puremvc.patterns.observer.Notification;
	import com.wemb.tobit.pure.controller.ApplicationConfigCommand;
	import com.wemb.tobit.pure.controller.ApplicationStartupCommand;
	import com.wemb.tobit.pure.controller.HttpServiceCommand;
	import com.wemb.tobit.pure.controller.PageChangeCommand;
	import com.wemb.tobit.pure.controller.TobitHttpServiceCommand;
	import com.wemb.tobit.pure.controller.TobitRTMPCommand;
	import com.wemb.tobit.pure.controller.TobitServiceCommand;
	import com.wemb.tobit.pure.view.IndexMediator;
	import com.wemb.tobit.puremvc.TobitFacade;
	
	
	public class ApplicationFacade extends TobitFacade
	{
		
		/**
		 * Singleton ApplicationFacade Factory Method
		 */
		public static function getInstance(): ApplicationFacade
		{
			if (instance == null) instance = new ApplicationFacade();
			return instance as ApplicationFacade;
		}
		
		/**
		 * Application의 컴포넌트가 초기화된후 호출되는 메소드로서
		 * Application framework을 시작 시킨다.
		 */
		override public function startup(app:Object):void
		{
			super.startup(app);
			
			//Application의 사작을 알립니다.
			super.sendNotification(Notification.APP_STARTUP, app);
			
			//IndexMediator를 등록합니다.
			//IndexMediator은 index 페이지의 프로세스를 정의한 클래스입니다.
			registerMediator(new IndexMediator(app));
		}
		
		/**
		 * Register Commands with the Controller 
		 */
		override protected function initializeController() : void 
		{
			super.initializeController();
			// Application Start Command
			registerCommand(Notification.APP_STARTUP,		ApplicationStartupCommand);
			// Page Change process Command
			registerCommand(Notification.PAGE_CHANGE,		PageChangeCommand);
			// Config process Command
			registerCommand(Constants.GET_APP_CONFIG,	ApplicationConfigCommand);
			// Tobit Service 요청을 처리하는 Command
			registerCommand(Commands.TOBIT_SERVICE,	TobitServiceCommand);
			// RTMP Service 요청을 처리하는 Command
			registerCommand(Commands.TOBIT_RTMP,		TobitRTMPCommand);
			// HTTP Service 요청을 처리하는 Command
			registerCommand(Commands.TOBIT_HTTP_SERVICE,	TobitHttpServiceCommand);
			// HttpService command
			registerCommand(Commands.HTTP_SERVICE, HttpServiceCommand);
		}
	}
}