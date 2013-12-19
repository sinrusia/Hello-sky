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
	import com.wemb.tobit.managers.HistoryManager;
	import com.wemb.tobit.pure.model.TobitServiceProxy;
	import com.wemb.tobit.vo.PageInfo;
	
	public class PageChangeCommand extends SimpleCommand
	{
		public function PageChangeCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void{
			var info:PageInfo = notification.getBody() as PageInfo;
			HistoryManager.getInstance().addHistory(info, notification.getType());
			
			//remoteobject 
			var proxy:TobitServiceProxy = facade.retrieveProxy(TobitServiceProxy.NAME) as TobitServiceProxy;
			//proxy.disconnect();
			
		}
	}
}