////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.map.symbol
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	/**
	 * @author wemb
	 */
	public class Group_mc extends MovieClip
	{
		private var _severity:String = "normal";
		private var __target_mc:*;
		
		public function Group_mc(__target_mc:* = null):void {
			if(__target_mc == null)
				return;
			this.__target_mc = __target_mc;
			__target_mc.gotoAndStop(1);
			__target_mc.target_mc.buttonMode = true;
			__target_mc.target_mc.doubleClickEnabled = true;
			__target_mc.target_mc.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
		}
		
		protected function doubleClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new MouseEvent(MouseEvent.DOUBLE_CLICK));
		}
		
		public function set severity( sev:String ):void 
		{
			_severity = sev;
			__target_mc.gotoAndStop(sev);
		}
		public function get severity():String 
		{
			return _severity;
		}
	}
}