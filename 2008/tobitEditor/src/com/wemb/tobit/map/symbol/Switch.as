package com.wemb.tobit.map.symbol{
	import flash.display.MovieClip;
	public class Switch extends MovieClip{
		private var __target_mc:*;
		
		public function Switch(__target_mc:* = null):void {
			if(__target_mc == null)
				return;
			this.__target_mc = __target_mc;
			__target_mc.gotoAndStop(1);
			__target_mc.buttonMode = true;
		}
		
		private var _severity:String;
		
		public function set severity(__severity:String):void{
			this._severity = __severity.toLocaleLowerCase();
			__target_mc.gotoAndStop(_severity);
		}
		
		public function get severity():String{
			return this._severity;
		}
	}
}