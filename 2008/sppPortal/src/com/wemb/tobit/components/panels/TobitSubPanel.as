package com.wemb.tobit.components.panels
{
	import com.wemb.tobit.utils.ScaleBitmap;
	import com.wemb.tobit.utils.Util;
	
	import flash.geom.Rectangle;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	import mx.styles.ISimpleStyleClient;
	
	public class TobitSubPanel extends Canvas implements ISimpleStyleClient
	{
		private var backImg:Class;
		private var _b_x:Number = 15;
		private var _b_y:Number = 15;
		private var _b_w:Number = 1207;
		private var _b_h:Number = 142;
		private var uiComp:UIComponent = new UIComponent();
		private var scaleBitmap:ScaleBitmap;
				
		public function TobitSubPanel()
		{
		}
		
		private function create():void{
			while(this.numChildren){
				this.removeChildAt(0);
			}
			
			while(uiComp.numChildren){
				uiComp.removeChildAt(0);
			}
			if(backImg == null)
				return;
				
			var img:* = new backImg();
 			scaleBitmap = new ScaleBitmap(img.bitmapData);
			 			
 			scaleBitmap.scale9Grid=new Rectangle(_b_x,_b_y,_b_w,_b_h);
           	uiComp.addChild(scaleBitmap);
           	this.addChild(uiComp);
		}
				
		/**
		 *  
		 * @param unscaledWidth
		 * @param unscaledHeight
		 * 
		 */		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
        { 	
        	super.updateDisplayList(unscaledWidth,unscaledHeight); 
        	try
			{
				scaleBitmap.width = unscaledWidth;
				scaleBitmap.height = unscaledHeight;
			}
			catch( err:Error )
			{
				
			}
			
        }
        		
		
       	override public function styleChanged(styleName:String):void{
        	super.styleChanged(styleName);
        	backImg = Util.GetCSSResource("TobitSubPanel", "backImg") as Class;
			_b_x = Util.GetCSSResource("TobitSubPanel", "backX") as Number;
			_b_y = Util.GetCSSResource("TobitSubPanel", "backY") as Number;
			_b_w = Util.GetCSSResource("TobitSubPanel", "backWidth") as Number;
			_b_h = Util.GetCSSResource("TobitSubPanel", "backHeight") as Number;
			create();
        }      
        		
		

	}
}