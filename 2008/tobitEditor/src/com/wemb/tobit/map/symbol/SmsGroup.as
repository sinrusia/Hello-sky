package com.wemb.tobit.map.symbol
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class SmsGroup extends MovieClip
	{
		private var _severity:String = "normal";
		private var __target_mc:*;
		
		public function SmsGroup(__target_mc:* = null) {
			if(__target_mc == null)
				return;
			this.__target_mc = __target_mc;
			__target_mc.gotoAndStop(_severity);
			__target_mc.target_mc.buttonMode = true;
			__target_mc.target_mc.doubleClickEnabled = true;
			__target_mc.target_mc.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);			
		}
		
		private function doubleClickHandler(e:MouseEvent):void{
			dispatchEvent(new Event('doubleClicked'));
		}
		
	}
}