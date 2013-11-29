package com.wemb.tobit.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	
	/**
	 * 심볼 Drag시 DragManager에서 사용하는 CaptureImage 만드는 Class
	 * 
	 *	@auther 송은미( song@wemb.co.kr )
	 */
	public class ImageUtil 
	{
		public function ImageUtil()
		{
			
		}
		
		
		/**
		 * UIComponent캡쳐
		 * @param target
		 * @return 
		 * 
		 */		
		public static function getBitmapData( target:UIComponent ):BitmapData
		{
			var bitmapData:BitmapData = new BitmapData( target.width, target.height, true, 0x00 );
			bitmapData.draw( target );
			
			return bitmapData;
		}
		
		
		
		/**
		 * ArrayCollection에서  각 UIComponent를 bitmap롤 그린다음에 sprite에 하나씩 그려준다 
		 * 
		 * @param targetAC
		 * @param currentTarget	
		 * @return 
		 * 
		 */			
		public static function getMultiBitmapData(targetAC:ArrayCollection, currentTarget:UIComponent ):UIComponent
		{
			var ui:UIComponent = new UIComponent();
			var _sprite:Sprite =  new Sprite();
			
			if( targetAC.length > 0 )
			{
				var target:UIComponent;
				var bitmapData:BitmapData;
				var bit:Bitmap;

				for( var i:int=0; i<targetAC.length; i++ )
				{
					var ts:Sprite = new Sprite();
					bit = new Bitmap();
					target = UIComponent( targetAC[i] );
					
					var __width:Number = target.width;		// 속성창에서 0으로 셋팅됨 bitmapData 에 0값이 들어나면 에러남
					var __height:Number = target.height;
					
					if(__width == 0) __width = 1;
					if(__height == 0) __height = 1;
					
					bitmapData = new BitmapData(__width, __height, true, 0x00 );
					bitmapData.draw( target, null );
					
					bit.bitmapData = bitmapData;
					
					ts.addChild(bit);
					
					ts.x = target.x;
					ts.y = target.y;
					
					_sprite.addChild(ts);					
				}
			}
			
			_sprite.x = (currentTarget.x * -1);
			_sprite.y = (currentTarget.y * -1);

			ui.addChild(_sprite);
			
			return ui;
		}
	}
}