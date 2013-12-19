package com.wemb.tobit.map.symbol {
	
	import flash.display.MovieClip;

	public class AVServer extends MovieClip {
		private var _severity:String = "normal";
		private var __target_mc:*;
		
		public function AVServer(__target_mc:* = null):void {
			if(__target_mc == null)
				return;
			this.__target_mc = __target_mc;
			__target_mc.gotoAndStop(1);
			__target_mc.symbol_mc.gotoAndStop(1);
			
			this.__target_mc.buttonMode = true;
			this.__target_mc.mouseChildren = false;
			this.__target_mc.useHandCursor = true;
			
		}
		
		public function set severity( sev:String ):void {
			_severity = sev.toLocaleLowerCase();
			severitySetting();
			
		}
		
		public function get severity():String {
			return _severity;
		}
		
		public function set vender(str:String):void{
			var _vender:String = str.toLocaleLowerCase();
			__target_mc.gotoAndStop(_vender);
			
			for(var i:int=0; i<5; i++){
				__target_mc.addFrameScript(i, completion);
			}
			
			function completion():void{
				stop();
				severitySetting();
			}			
		}
		
		private function severitySetting():void{
			try{
				__target_mc.symbol_mc.gotoAndStop(_severity );
			} catch(err:Error){}
		}
		
		
		
		
		
	}
}