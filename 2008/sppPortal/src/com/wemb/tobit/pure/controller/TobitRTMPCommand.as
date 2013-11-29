/**
 *	Copyright (C) 2004-2009 WeMB INC. 
 *	All Rights Reserved.
 *	@date			:	2009-04-07
 *	@auther			:	고재학
 *	@ver			:	1.0
 *	@description 	:	TobitService 요청을 처리하는 Command 클래스이다.
 *	
**/
package com.wemb.tobit.pure.controller
{
	import com.wemb.tobit.pure.model.TobitRTMPProxy;
	import com.wemb.tobit.vo.Request;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

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
			
			var proxy:TobitRTMPProxy = facade.retrieveProxy(TobitRTMPProxy.NAME) as TobitRTMPProxy;
			
			proxy.process(request);
			
			if(notification.getBusyCursor()){
				proxy.setBusyCursor(request.command);
			}
		}
	}
}