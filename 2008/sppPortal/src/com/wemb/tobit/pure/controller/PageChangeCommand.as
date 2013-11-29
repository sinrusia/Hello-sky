/**
 *	Copyright (C) 2004-2009 WeMB INC. 
 *	All Rights Reserved.
 *	@date			:	2009-04-07
 *	@auther			:	고재학
 *	@ver			:	1.0
 *	@description 	:	페이지 변경시 호출된다.
 * 						HistoryManager에 페이지를 등록하는 작업을 수행한다.
**/
package com.wemb.tobit.pure.controller
{
	import com.wemb.tobit.pure.model.TobitServiceProxy;
	import com.wemb.tobit.vo.PageInfo;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class PageChangeCommand extends SimpleCommand
	{
		public function PageChangeCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void{
			var info:PageInfo = notification.getBody() as PageInfo;
			
			//remoteobject 
			var proxy:TobitServiceProxy = facade.retrieveProxy(TobitServiceProxy.NAME) as TobitServiceProxy;
			proxy.disconnect();
			
		}
	}
}