package com.wemb.tobit.pure.controller
{
	import com.wemb.tobit.pure.model.TobitServiceProxy;
	import com.wemb.tobit.vo.Request;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.vo.NotificationBody;

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