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
	import com.wemb.tobit.pure.model.SocketProxy;
	import com.wemb.tobit.pure.model.TobitRTMPProxy;
	import com.wemb.tobit.pure.model.TobitServiceProxy;
	

	public class ModelPrepCommand extends SimpleCommand
	{
		/**
		 * Register the Proxies.
		 */
		override public function execute( note:INotification ) :void	
		{
			facade.registerProxy(new TobitServiceProxy());
			facade.registerProxy(new TobitRTMPProxy());
			facade.registerProxy(new HttpServiceProxy());
			facade.registerProxy(new SocketProxy());
		}
	}
}