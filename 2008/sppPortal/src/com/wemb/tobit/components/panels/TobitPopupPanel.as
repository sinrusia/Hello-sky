package com.wemb.tobit.components.panels
{
	import com.wemb.tobit.utils.ScaleBitmap;
	import com.wemb.tobit.utils.Util;
	
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	import mx.styles.ISimpleStyleClient;
	
	public class TobitPopupPanel extends Canvas implements ISimpleStyleClient
	{
		//[Embed(source="/assets/panels/bg_popup.png")]	
		private var backImg:Class;

		private var uiComp:UIComponent = new UIComponent();
		private var scaleBitmap:ScaleBitmap;
		
		private var _width:Number;
		private var _height:Number;

		public function TobitPopupPanel()
		{
		}
		
		private function create():void{
			while(this.numChildren){
				this.removeChildAt(0);
			}
			
			while(uiComp.numChildren){
				uiComp.removeChildAt(0);
			}
			
			var img:* = new backImg();
 			scaleBitmap = new ScaleBitmap(img.bitmapData);

 			scaleBitmap.scale9Grid = new Rectangle(_b_x,_b_y,_b_w,_b_h);
           	uiComp.addChild(scaleBitmap);
           	this.addChild(uiComp);
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
        { 	
        	super.updateDisplayList(unscaledWidth,unscaledHeight); 
        	this._width = unscaledWidth;
        	this._height = unscaledHeight;
        	try{
				scaleBitmap.width = _width;
				scaleBitmap.height = _height;
        	} catch(err:Error){}
        	
        }
        
        private var _b_x:Number = 0;
        private var _b_y:Number = 0;
        private var _b_w:Number = 0;
        private var _b_h:Number = 0;
        
        override public function styleChanged(styleName:String):void
        {
        	super.styleChanged(styleName);
        	backImg = Util.GetCSSResource("TobitPopupPanel", "backImg") as Class;
			 _b_x = Util.GetCSSResource("TobitPopupPanel", "backX") as Number;
			 _b_y = Util.GetCSSResource("TobitPopupPanel", "backY") as Number;
			 _b_w = Util.GetCSSResource("TobitPopupPanel", "backWidth") as Number;
			 _b_h = Util.GetCSSResource("TobitPopupPanel", "backHeight") as Number;
        	create();
        }
	}
}
