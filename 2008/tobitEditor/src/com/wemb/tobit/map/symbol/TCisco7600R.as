package com.wemb.tobit.map.symbol {
	
	import flash.display.MovieClip;

	public class TCisco7600R extends MovieClip {
		private var _severity:String = "normal";
		private var __target_mc:*;
		
		public function TCisco7600R(__target_mc:* = null):void {
			if(__target_mc == null)
				return;
			this.__target_mc = __target_mc;
			__target_mc.gotoAndStop(1);
			
			this.__target_mc.buttonMode = true;
			this.__target_mc.mouseChildren = false;
			this.__target_mc.useHandCursor = true;
		}
		public function set severity( sev:String ):void {
			_severity = sev.toLocaleLowerCase();
			__target_mc.gotoAndStop(_severity );
		}
		public function get severity():String {
			return _severity;
		}
	}
}