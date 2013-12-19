package com.wemb.tobit.map.symbol {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	[Event(name="doubleClicked", type="flash.events.Event")]
	public class NetworkGroup extends MovieClip {
		private var __target_mc:*;
		private var _severity:String = "normal";
		
		public function NetworkGroup(__target_mc:* = null):void {
			//__target_mc = this;
			if(__target_mc == null)
				return;
			this.__target_mc = __target_mc;
			__target_mc.gotoAndStop(_severity);
			__target_mc.target_mc.buttonMode = true;
			__target_mc.target_mc.doubleClickEnabled = true;
			__target_mc.target_mc.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);			
		}
		
		
		public function set severity(__severity:String):void{
			this._severity = __severity.toLocaleLowerCase();
			__target_mc.gotoAndStop(_severity);
		}
		
		public function get severity():String{
			return this._severity;
		}
		
		private function doubleClickHandler(e:MouseEvent):void{
			dispatchEvent(new Event('doubleClicked'));
		}
		
	}
}
