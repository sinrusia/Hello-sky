////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.pure.controller
{
	import com.wemb.puremvc.interfaces.INotification;
	import com.wemb.puremvc.patterns.command.SimpleCommand;
	import com.wemb.tobit.core.ApplicationConfig;
	import com.wemb.tobit.pure.Constants;
	import com.wemb.tobit.vo.MenuInfo;
	import com.wemb.tobit.vo.Request;
	
	import flash.external.ExternalInterface;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	public class ApplicationConfigCommand extends SimpleCommand
	{
		public function ApplicationConfigCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			//어플리케이션 초기화 정보
			var request:Request = notification.getBody() as Request;
			var config:Object = request.getResult("config");
			
			
			if(config is Array)
				ApplicationConfig.getInstance().setApplicationConfig(config as Array);
			
			else
				ApplicationConfig.getInstance().setApplicationConfig(ArrayCollection(config).source);
				
			// 메뉴정보
			ApplicationConfig.getInstance().menuList = request.getResult("menuList") as Array;
			
			checkGrade(ApplicationConfig.getInstance().menuList);
			
			sendNotification(Constants.CONFIG_CHANGE);
			// 환경설정 내용을 로딩한 후 무엇을 할것인가?
			// 메뉴를 로딩할 것인가??
			sendNotification(Constants.MAIN_STARTUP);
			
			sendTobitService( Constants.GET_TICKER_LIST );
		}
		
		
		//탑 메뉴 MenuInfo
		public function checkGrade(menuList:Array):Boolean {
			var status:Boolean = false;
			for each (var menu:MenuInfo in menuList) {
				var currentStatus:Boolean = false;
				if (menu.children) {
					currentStatus = checkGrade(menu.children.source);
				}
				
				if (menu.readYn == "Y") {
					status = true;
				} else if (currentStatus == true) {
					menu.readYn = "Y";
					status = true;
				}
			}
			return status;
		}
	}
}