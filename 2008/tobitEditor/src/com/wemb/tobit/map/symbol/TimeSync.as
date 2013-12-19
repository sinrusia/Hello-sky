package com.wemb.tobit.map.symbol {
	import flash.display.MovieClip;

	public class TimeSync extends MovieClip {
		private var _severity:String = "normal";
		private var __target_mc:MovieClip;
		public function TimeSync(__target_mc:MovieClip = null):void {
			if(__target_mc == null)
				return;
			this.__target_mc = __target_mc;
			
			__target_mc.gotoAndStop(_severity);
//			__target_mc.gotoAndStop(1);
//			this.buttonMode = true;
//			this.gotoAndStop(1);
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