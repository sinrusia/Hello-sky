package com.daum.controls
{
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.controls.Text;

	public class LinkText extends Text
	{
		public var linkURL:String;
		
		public function LinkText()
		{
			super();
			addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
			addEventListener(MouseEvent.CLICK, onClickHandler);
		}
		
		private function onRollOverHandler(event:MouseEvent):void
		{
			setStyle("textDecoration", "underline");
			this.useHandCursor	= true;
			this.buttonMode		= true;
			this.mouseChildren	= false;
		}
		
		private function onRollOutHandler(event:MouseEvent):void
		{
			setStyle("textDecoration", "none");
			this.useHandCursor	= false;
			this.buttonMode		= false;
			this.mouseChildren	= true;
		}
		
		private function onClickHandler(event:MouseEvent):void
		{
			if(linkURL){
				var urlRequest:URLRequest = new URLRequest(linkURL);
				navigateToURL(urlRequest, "_new");
			}
		}
	}
}