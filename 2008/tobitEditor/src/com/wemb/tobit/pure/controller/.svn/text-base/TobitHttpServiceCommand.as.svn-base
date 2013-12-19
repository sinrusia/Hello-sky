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
	import com.wemb.tobit.pure.model.TobitServiceProxy;
	import com.wemb.tobit.vo.Request;
	
	public class TobitHttpServiceCommand extends SimpleCommand
	{
		public function TobitHttpServiceCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void{
			
			var request:Request = new Request();
			request.command = notification.getType();
			
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
			
			proxy.httpProcess(request);
			
			if(notification.getBusyCursor())
			{
				proxy.setBusyCursor(request.command);
			}
			
		}
	}
}