package com.wemb.tobit.map.symbol {
	import flash.display.MovieClip;

	public class VTL extends MovieClip {
		private var _severity:String = "Normal";
		private var __target_mc:*;
		
		public function VTL(__target_mc:* = null):void {
			if(__target_mc == null)
				return;
			this.__target_mc = __target_mc;
			__target_mc.gotoAndStop(1);
		}
		public function set severity( sev:String ):void {
			_severity = sev;
			__target_mc.gotoAndStop(sev);
		}
		public function get severity():String {
			return _severity;
		}
	}
}