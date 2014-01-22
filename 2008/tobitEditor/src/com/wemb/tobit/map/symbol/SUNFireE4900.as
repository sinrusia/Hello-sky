﻿package com.wemb.tobit.map.symbol {
	import flash.display.MovieClip;

	public class SUNFireE4900 extends MovieClip {
		private var _severity:String = "normal";
		private var __target_mc:*;
		
		public function SUNFireE4900(__target_mc:* = null):void {
			if(__target_mc == null)
				return;
			this.__target_mc = __target_mc;
			
			__target_mc.gotoAndStop(_severity);
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