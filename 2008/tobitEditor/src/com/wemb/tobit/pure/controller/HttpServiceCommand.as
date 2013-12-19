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
	import com.wemb.tobit.pure.model.HttpServiceProxy;
	
	
	/**
	 * @author jaehag
	 */
	public class HttpServiceCommand extends SimpleCommand
	{
		public function HttpServiceCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void{
			var param:Object = notification.getBody(); // parameter
			var command:String = notification.getType() as String; // url? command?
			notification.getName(); // Constants.HTTP_SERVICE
			
			// get httpservice proxy
			var prxy:HttpServiceProxy = facade.retrieveProxy(com.wemb.tobit.pure.model.HttpServiceProxy.NAME) as HttpServiceProxy;
			
			// proc
			prxy.process(command, param);
		}
	}
}