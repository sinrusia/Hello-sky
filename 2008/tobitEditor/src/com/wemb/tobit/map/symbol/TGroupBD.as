package com.wemb.tobit.map.symbol 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[Event(name="doubleClicked", type="flash.events.Event")]
	public class TGroupBD extends MovieClip 
	{
		private var _severity:String = "normal";
		private var __target_mc:*;
		public function TGroupBD(__target_mc:* = null):void {
			if(__target_mc == null)
				return;
			this.__target_mc = __target_mc;
			__target_mc.gotoAndStop(_severity);
			__target_mc.target_mc.buttonMode = true;
			__target_mc.target_mc.doubleClickEnabled = true;
			__target_mc.target_mc.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
		}
		
		protected function doubleClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event('doubleClicked'));
		}
		
		public function set severity( value:String ):void 
		{
			this._severity = value.toLocaleLowerCase();
			__target_mc.gotoAndStop(_severity);
		}
		
		public function get severity():String 
		{
			return _severity;
		}
		
		public function setSize(__width:Number, __height:Number):void{
			__target_mc.width = __width;
			__target_mc.height = __height;
			
		}
	}
}