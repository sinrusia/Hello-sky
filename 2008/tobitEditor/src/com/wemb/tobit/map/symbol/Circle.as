package com.wemb.tobit.map.symbol {
//package  {	
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;

	
	public class Circle extends MovieClip {
		private var _severity:String = "normal";
		private var __target_mc:*;
		private var frm:TextFormat;
		private var frm1:TextFormat;
		
		public function Circle(__target_mc:* = null):void {
		//public function Circle():void {	
			frm = new TextFormat();
			frm.font = "Microsoft YaHei";
			
			frm1 = new TextFormat();
			frm1.font = "Dinbol";
			

			
			if(__target_mc == null)
				return;
			this.__target_mc = __target_mc;
			

			
			//__target_mc = this;
			
			__target_mc.m_target.mask = __target_mc.mask_mc;
			__target_mc.gotoAndStop(1);
			
			__target_mc.doubleClickEnabled = true;
			__target_mc.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
			__target_mc.addEventListener(MouseEvent.CLICK, clickHandler);
			
			//__target_mc.m_target = true;
			//__target_mc.btn.doubleClickEnabled = true;
			//__target_mc.btn.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler); 

			//cnt1 = 100;
			
		}
		
		
		public function set title(str:String):void{
			__target_mc.title_txt.text = str;
			__target_mc.title_txt.embedFonts = true;
			__target_mc.title_txt.setTextFormat(frm);
		}
		
		public function set cnt1(no:Number):void{
			__target_mc.mask_mc.mask_txt.text = no.toString();
			__target_mc.mask_mc.mask_txt.embedFonts = true;
			__target_mc.mask_mc.mask_txt.setTextFormat(frm1);
		}
		
		public function set cnt2(no:Number):void{
			__target_mc.cnt_txt.text = no.toString();
			__target_mc.cnt_txt.embedFonts = true;
			__target_mc.cnt_txt.setTextFormat(frm1);
			
			
		}		
		
		public function set severity( sev:String ):void {
			_severity = sev.toLocaleLowerCase();
			__target_mc.gotoAndStop(_severity );
			
			if(_severity == "normal"){
				__target_mc.cnt_txt.visible = false;
			} else {
				__target_mc.cnt_txt.visible = true;
			}
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
		
		public function set eventCnt(value:String):void{
			if(Number(value) > 99)
				value = "99";
			__target_mc.cnt_txt.text = value;
			__target_mc.cnt_txt.embedFonts = true;
			__target_mc.cnt_txt.setTextFormat(frm1);
		}
		
		public function set nowValue(value:String):void{
			if(Number(value) > 999)
				value = "999";
			__target_mc.mask_mc.mask_txt.text = value;
			__target_mc.mask_mc.mask_txt.embedFonts = true;
			__target_mc.mask_mc.mask_txt.setTextFormat(frm1);
		}
		
		private function severitySetting():void{
			try{
				
			} catch(err:Error){}
		}

		private function doubleClickHandler(e:MouseEvent):void{
			dispatchEvent(new Event('doubleClicked'));
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			if (event.target && !event.target.doubleClickEnabled)
			{
				event.target.doubleClickEnabled = true;
			}
		}
	}
}