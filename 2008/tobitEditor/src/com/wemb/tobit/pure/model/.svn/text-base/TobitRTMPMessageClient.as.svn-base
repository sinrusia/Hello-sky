////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.pure.model
{
	import com.wemb.tobit.pure.ApplicationFacade;
	import com.wemb.tobit.vo.Request;
	
	public class TobitRTMPMessageClient
	{
		public function TobitRTMPMessageClient()
		{
		}
		
		public function message( obj:Object ):void
		{
			if(obj is Request){
				ApplicationFacade.getInstance()
					.sendNotification( obj.command, obj );
			}
		}
		
		/**
		 * The onBWCheck() function is required by native bandwidth detection. 
		 * It takes an argument, …rest. 
		 * The function must return a value, even if the value is 0, to indicate to the server that the client has received the data. 
		 * You can call onBWCheck() multiple times.
		 */
		public function onBWCheck(...rest):Number 
		{
			trace("onBWCheck");
			return 0;
		}
		
		/**
		 *  The first argument it returns is the bandwidth measured in Kbps. 
		 * The second and third arguments are not used. 
		 * The fourth argument is the latency in milliseconds.
		 */
		public function onBWDone(...rest):void 
		{
			trace("onBWDone");
			var p_bw:Number;
			if(rest.length > 0) {
				p_bw = rest[0];
			}
			
			trace("bandwidth = " + p_bw + "kbps.");
		}
	}
}
