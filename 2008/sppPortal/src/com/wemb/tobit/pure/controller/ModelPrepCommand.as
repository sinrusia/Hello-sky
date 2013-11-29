/**
 *	Copyright (C) 2004-2009 WeMB INC. 
 *	All Rights Reserved.
 *	@date			:	2009-04-07
 *	@auther			:	고재학
 *	@ver			:	1.0
 *	@description 	:	
 *	
**/
package com.wemb.tobit.pure.controller
{
	
	import com.wemb.tobit.pure.model.TobitRTMPProxy;
	import com.wemb.tobit.pure.model.TobitServiceProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;


	public class ModelPrepCommand extends SimpleCommand
	{
		/**
		 * Register the Proxies.
		 */
		override public function execute( note:INotification ) :void	
		{
			facade.registerProxy(new TobitServiceProxy());
			facade.registerProxy(new TobitRTMPProxy());
			//facade.registerProxy(new TobitMultiServiceProxy());
			//facade.registerProxy(new MessageProxy());
		}
	}
}