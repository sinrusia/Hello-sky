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
	import com.wemb.tobit.pure.controller.ApplicationConfigCommand;
	import com.wemb.tobit.pure.controller.ApplicationStartupCommand;
	import com.wemb.tobit.pure.controller.CriticalAlarmCommand;
	import com.wemb.tobit.pure.controller.PageChangeCommand;
	import com.wemb.tobit.pure.controller.RegisterXCanvasCommand;
	import com.wemb.tobit.pure.controller.RemoveXCanvasCommand;
	import com.wemb.tobit.pure.controller.TobitHttpServiceCommand;
	import com.wemb.tobit.pure.controller.TobitRTMPCommand;
	import com.wemb.tobit.pure.controller.TobitServiceCommand;
	import com.wemb.tobit.pure.view.IndexMediator;
	
	import org.puremvc.as3.patterns.facade.Facade;

	public class ApplicationFacade extends Facade
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
		public function startup(app:Object):void
		{
			//Application의 사작을 알립니다.
			super.sendNotification(Constants.APP_STARTUP, app);
			
			//IndexMediator를 등록합니다.
			//IndexMediator은 index 페이지의 프로세스를 정의한 클래스입니다.
			//registerMediator(new IndexMediator(app));
		}
		
		/**
		 * Register Commands with the Controller 
		 */
		override protected function initializeController() : void 
		{
			super.initializeController();
			
			registerCommand(Constants.TOBIT_SERVICE,	TobitServiceCommand);
			registerCommand(Constants.TOBIT_RTMP,		TobitRTMPCommand);
			registerCommand(Constants.TOBIT_HTTP_SERVICE,	TobitHttpServiceCommand);
			registerCommand(Constants.APP_STARTUP,		ApplicationStartupCommand);
			//registerCommand(Constants.PAGE_CHANGE,		PageChangeCommand);
			registerCommand(Constants.REGISTER_XCANVAS, RegisterXCanvasCommand);
			registerCommand(Constants.REMOVE_XCANVAS,	RemoveXCanvasCommand);
			//registerCommand(Constants.GET_APP_CONFIG,	ApplicationConfigCommand);
		}
	}
}