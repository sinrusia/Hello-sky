/**
 *	Copyright (C) 2004-2009 WeMB INC. 
 *	All Rights Reserved.
 *	@date			:	2009-04-07
 *	@auther			:	고재학
 *	@ver			:	1.0
 *	@description 	:	XCanvas페이지를 Observer에 등록한다.
 * 						화면이 보여질때 수행하도록 한다.
**/
package com.wemb.tobit.pure.controller
{
	import com.wemb.tobit.pure.view.XCanvas;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class RegisterXCanvasCommand extends SimpleCommand
	{
		public function RegisterXCanvasCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void{
			var xcanvas:XCanvas = notification.getBody() as XCanvas;
			
			if( xcanvas != null && xcanvas is XCanvas){
				facade.registerMediator(xcanvas);
			}
			
		}
	}
}