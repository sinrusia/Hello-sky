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
	import com.wemb.tobit.pure.model.TobitRTMPProxy;
	import com.wemb.tobit.vo.Request;
	
	public class TobitRTMPCommand extends SimpleCommand
	{
		public function TobitRTMPCommand()
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
			request.param = notification.getBody();
			//request.authID = ApplicationConfig.getInstance().user.userId;
			
			var proxy:TobitRTMPProxy = facade.retrieveProxy(TobitRTMPProxy.NAME) as TobitRTMPProxy;
			
			proxy.process(request);
			
			if(notification.getBusyCursor()){
				proxy.setBusyCursor(request.command);
			}
		}
	}
}