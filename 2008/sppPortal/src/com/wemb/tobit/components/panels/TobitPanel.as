package com.wemb.tobit.components.panels
{
	import com.wemb.tobit.utils.ScaleBitmap;
	import com.wemb.tobit.utils.Util;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	import mx.styles.ISimpleStyleClient;
	
	/**
	 * TobitPanel
	 * 
	 * @auther 송은미( song@wemb.co.kr )
	 */
	/* [Style(name="TobitPanel", type="Array", arrayType="uint", format="Color", inherit="yes")] */
	public class TobitPanel extends Canvas implements ISimpleStyleClient
	{
		
		//------------------------------------------
		// Private Variables
		//------------------------------------------
		
		//[Embed(source="/assets/panels/p_contentBox.png")]	
		private var backImg:Class;

		//[Embed(source="/assets/panels/p_title.png")]	
		private var topImg:Class;

		private var uiComp:UIComponent = new UIComponent();
		private var scaleBitmap:ScaleBitmap;
		
		private var _width:Number;
		private var _height:Number;
		
		private var top1_img:Bitmap;
		private var top2_img:Bitmap;
		private var top3_img:Bitmap;
		private var top4_img:Bitmap;
		private var top5_img:Bitmap;
		
		private var _titleWidth:Number = 200;
		
		private var b_x:Number = 15
		private var b_y:Number = 15;
		private var b_w:Number = 1230;
		private var b_h:Number = 142;
		
		private var t_h:Number = 33;
		
		public function TobitPanel()
		{
			
		}
		
		private function create():void
		{
			while(uiComp.numChildren){
				uiComp.removeChildAt(0);
			}
			
			if(backImg == null && topImg == null)
				return;
			//최소 사이즈 셋팅
			minWidth = 100;
			
			var img:* = new backImg();
 			scaleBitmap = new ScaleBitmap(img.bitmapData);
			 			
 			// 하단 30
// 			scaleBitmap.scale9Grid=new Rectangle(160,40,208,277);
 			scaleBitmap.scale9Grid=new Rectangle(b_x,b_y,b_w,b_h);
           	uiComp.addChild(scaleBitmap);
           	scaleBitmap.y = t_h;
           	this.addChild(uiComp);
			
			img = new topImg();
			var myMatrix:Matrix = new Matrix();
			var objBMP:BitmapData;		
			
			top1_img = new Bitmap();
			objBMP = new BitmapData(30, img.bitmapData.height, true, 0xffffff);
			objBMP.draw(img.bitmapData, null,null,null,null,true);	
 			top1_img.bitmapData = objBMP;
			uiComp.addChild(top1_img);
			
			top2_img = new Bitmap();
			objBMP = new BitmapData(30, img.bitmapData.height, true, 0xffffff);
			myMatrix.translate(-30, 0);		
			objBMP.draw(img.bitmapData, myMatrix);	
 			top2_img.bitmapData = objBMP;
			uiComp.addChild(top2_img);
			top2_img.x = top1_img.x + top1_img.width;

			top3_img = new Bitmap();
			objBMP = new BitmapData(100, img.bitmapData.height, true, 0xffffff);
			myMatrix = new Matrix();
			myMatrix.translate(-210, 0);		
			objBMP.draw(img.bitmapData, myMatrix);	
 			top3_img.bitmapData = objBMP;
			uiComp.addChild(top3_img);
			top3_img.x = top2_img.x + top2_img.width;
			
			top4_img = new Bitmap();
			objBMP = new BitmapData(30, img.bitmapData.height, true, 0xffffff);
			myMatrix = new Matrix();
			myMatrix.translate(-340, 0);		
			objBMP.draw(img.bitmapData, myMatrix);	
 			top4_img.bitmapData = objBMP;
			uiComp.addChild(top4_img);
			top4_img.x = top3_img.x + top3_img.width;
			
			top5_img = new Bitmap();
			objBMP = new BitmapData(30, img.bitmapData.height, true, 0xffffff);
			myMatrix = new Matrix();
			myMatrix.translate(img.bitmapData.width * (-1) + 30, 0);		
			objBMP.draw(img.bitmapData, myMatrix);	
 			top5_img.bitmapData = objBMP;
			uiComp.addChild(top5_img);
			top5_img.x = top4_img.x + top4_img.width;			
		}
		
		/**
		 * 패널 이미지 생성 
		 * 
		 */		
		override protected function createChildren():void
		{
			super.createChildren();
			create();
			
		}
	
		
		/**
		 * 
		 * @param __width
		 * 
		 */		
		public function set titleWidth(__width:Number):void
		{
			this._titleWidth = __width;
			
			 invalidateDisplayList(); 
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get titleWidth():Number
		{
			return _titleWidth;
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
        	 
        	this._width = unscaledWidth;
        	this._height = unscaledHeight;
        	
        	try
			{
				scaleBitmap.width = _width;
				scaleBitmap.height = _height - 35;
				var __width:Number = _titleWidth;
				
				if( minWidth > _titleWidth ) __width = minWidth;
				
				top2_img.width = __width;
			 	top3_img.x = top2_img.x + top2_img.width;
			 	top4_img.x = top3_img.x + top3_img.width;
			 	top4_img.width = _width - top1_img.width - top2_img.width  - top3_img.width - top5_img.width;
			 	top5_img.x = top4_img.x + top4_img.width;
			}
			catch( err:Error )
			{
				
			}
			
        }
		        
        override public function styleChanged(styleName:String):void{
        	super.styleChanged(styleName);
        	var b_img:Class= Util.GetCSSResource("TobitPanel", "backImg") as Class;
        	var t_img:Class= Util.GetCSSResource("TobitPanel", "topImg") as Class;
			
			var _b_x:Number = Util.GetCSSResource("TobitPanel", "backX") as Number;
			var _b_y:Number = Util.GetCSSResource("TobitPanel", "backY") as Number;
			var _b_w:Number = Util.GetCSSResource("TobitPanel", "backWidth") as Number;
			var _b_h:Number = Util.GetCSSResource("TobitPanel", "backHeight") as Number;
			var _t_h:Number = Util.GetCSSResource("TobitPanel", "topHeight") as Number;

        	var check:Boolean = false;
        	if(b_img != null && backImg == null){
        		backImg = b_img;
        		check = true;
        	}
        	if(t_img != null && topImg == null){
        		topImg = t_img;
        		check = true;
        	}
        	if(b_img != null && backImg.toString() != b_img.toString()){
        		backImg = b_img;
        		check = true;
        	}
        	if(t_img != null && backImg.toString() != t_img.toString()){
        		topImg = t_img;
        		check = true;
        	}
        	if(_b_x > 0){
        		b_x = _b_x;
        		check = true;
        	}
        	if(_b_y > 0){
        		b_y = _b_y;
        		check = true;
        	}
        	if(_b_w > 0){
        		b_w = _b_w;
        		check = true;
        	}
        	if(_b_h > 0){
        		b_h = _b_h;
        		check = true;
        	}
        	if(_t_h > 0){
        		t_h = _t_h;
        		check = true;
        	}
        	if(check == true){
	        	create();
        	}
        }        
	}
}


		