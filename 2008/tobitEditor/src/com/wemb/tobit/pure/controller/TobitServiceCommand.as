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
	import com.wemb.puremvc.vo.NotificationBody;
	import com.wemb.tobit.core.ApplicationConfig;
	import com.wemb.tobit.core.TobitApplication;
	import com.wemb.tobit.pure.model.TobitServiceProxy;
	import com.wemb.tobit.vo.Request;
	import com.wemb.tobit.vo.User;
	
	import mx.core.Application;
	
	public class TobitServiceCommand extends SimpleCommand
	{
		public function TobitServiceCommand()
		{
			super();
		}
		
		/**
		 * tobitService공지가 발생하면 자동적으로 호출되게 되어있다.
		 * TobitServiceProxy를 용하여 서버에 요청을 전달한다.
		 * 
		 * @param notification notification is instance of Notification. 
		 * 
		 */
		override public function execute(notification:INotification):void
		{
			var request:Request = new Request();
			request.command = notification.getType();
			
			// 요청자 정보를 설정한다.
			var user:User = TobitApplication.user;
			
			if(user)
			{
				request.authID = user.userId;
				request.authName = user.userName;
			}
			
			//body가 NotificationBody인지 체크한다.
			if(notification.getBody() is NotificationBody)
			{
				var body:NotificationBody = notification.getBody() as NotificationBody;
				request.param = body.requestBody;
				request.pageName = body.requestPage;
			}
			else
			{
				request.param = notification.getBody();
			}
			
			var proxy:TobitServiceProxy = facade.retrieveProxy(TobitServiceProxy.NAME) as TobitServiceProxy;
			// 요청시 로딩바를 호출한경우이다.
			if(notification.getBusyCursor()){
				proxy.setBusyCursor(request.command);
			}
			proxy.process(request);
			
		}
	}
}