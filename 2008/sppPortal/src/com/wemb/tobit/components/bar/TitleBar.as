package com.wemb.tobit.components.bar
{
	import com.wemb.tobit.utils.ScaleBitmap;
	
	import flash.geom.Rectangle;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	
	public class TitleBar extends Canvas
	{
		[Embed(source="/assets/common/titleBar04.png")]	
		private var backImg:Class;
		
		private var uiComp:UIComponent = new UIComponent();
		
		private var scaleBitmap:ScaleBitmap;
		
		public function TitleBar()
		{
			create();
		}
		
		private function create():void{
			while(uiComp.numChildren){
				uiComp.removeChildAt(0);
			}
			
			var img:* = new backImg();
 			scaleBitmap = new ScaleBitmap(img.bitmapData);
			 			
 			scaleBitmap.scale9Grid=new Rectangle(243,8,1,1);
           	uiComp.addChild(scaleBitmap);
           	this.addChild(uiComp);
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
        { 	
        	super.updateDisplayList(unscaledWidth,unscaledHeight); 
        	try{
				scaleBitmap.width = unscaledWidth;
				scaleBitmap.height = unscaledHeight;
        	} catch(err:Error){}
        	
        }
        
	}
}
