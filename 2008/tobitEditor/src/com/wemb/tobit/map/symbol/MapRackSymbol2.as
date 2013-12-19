package com.wemb.tobit.map.symbol{
	import flash.display.MovieClip;

	public class MapRackSymbol2 extends MovieClip {
		private var _severity:String;
		private var __target_mc:*;
		
		public function MapRackSymbol2(__target_mc:* = null):void {
			if(__target_mc == null)
				return;
			this.__target_mc = __target_mc;
			__target_mc.buttonMode = true;
			
			__target_mc.select_mc.gotoAndStop(1);
			__target_mc.select_mc.visible = false;
			__target_mc.gotoAndStop(1);
			
		}
		
		private var _vender:String;
		public function set vender(str:String):void{
			this._vender = str.toUpperCase();
			//__target_mc.gotoAndStop(_vender);
			for(var i:int=0; i<8; i++){
				__target_mc.addFrameScript(i, completion);
         	}
			function completion():void{
				__target_mc.select_mc.stop();
				setSizeFunc();
			}						
		}
		
		public function set severity( sev:String ):void {
			_severity = sev.toLowerCase();
			__target_mc.gotoAndStop(_severity);
			__target_mc.addFrameScript(0, completion1);
			__target_mc.addFrameScript(1, completion1);
			__target_mc.addFrameScript(2, completion1);
			__target_mc.addFrameScript(3, completion1);
			__target_mc.addFrameScript(4, completion1);
			
			function completion1():void{
				setSizeFunc()
			}

			if(_severity == "select"){
				__target_mc.select_mc.visible = true;
				__target_mc.select_mc.gotoAndPlay(1);
				__target_mc.select_mc.addFrameScript(12, completion);
				function completion():void{
					__target_mc.select_mc.stop();
				}			
			} else {
				__target_mc.select_mc.visible = false;
			}
		}
		
		public function get severity():String {
			return _severity;
		}
		
		private var __width:Number = 0;
		private var __height:Number = 0;
		
		public function set symbolWidth(val:Number):void{
			__width = val;
			setSizeFunc();
		}
		
		public function set symbolHeight(val:Number):void{
			__height = val;
			setSizeFunc();
		}
		
		private function setSizeFunc():void{
			try{
				__target_mc.target_mc.width = __width;
				__target_mc.target_mc.height = __height;
				__target_mc.select_mc.width = __width;
				__target_mc.select_mc.height = __height;
				__target_mc.target_mc1.width = __width-1.3;
				__target_mc.target_mc1.height = __height-1.3;
				__target_mc.btn.width = __width;
				__target_mc.btn.height = __height;
				
			} catch(err:Error){}
		}
		
		
	}
}

