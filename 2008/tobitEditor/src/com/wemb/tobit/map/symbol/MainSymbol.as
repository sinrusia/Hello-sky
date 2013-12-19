package com.wemb.tobit.map.symbol {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	[Event(name="doubleClicked", type="flash.events.Event")]
	public class MainSymbol extends MovieClip {
		private var __target_mc:*;
		private var frm:TextFormat;
		
		public function MainSymbol(__target_mc:* = null):void {
			//__target_mc = this;
			if(__target_mc == null)
				return;
			frm = new TextFormat();
			frm.font = "Dinbol";
			frm.letterSpacing = -2;
			this.__target_mc = __target_mc;
			__target_mc.target_mc.gotoAndStop(1);
			__target_mc.target_mc.lbl_txt.text = "";
			__target_mc.target_mc.buttonMode = true;
			__target_mc.btn.doubleClickEnabled = true
			__target_mc.btn.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
		}
		
		private var _severity:String;
		
		public function set severity(__severity:String):void{
			this._severity = __severity.toLocaleLowerCase();
			__target_mc.target_mc.gotoAndStop(_severity);
		}
		
		public function get severity():String{
			return this._severity;
		}
		
		public function set vender(value:String):void
		{
			__target_mc.target_mc.lbl_txt.text = value;
			__target_mc.target_mc.lbl_txt.embedFonts = true;
			__target_mc.target_mc.lbl_txt.setTextFormat(frm);
		}
		
		public function set nowValue(value:String):void
		{
			this.vender = value;
		}
		
		private function doubleClickHandler(e:MouseEvent):void{
			dispatchEvent(new Event('doubleClicked'));
		}
		
	}
}
