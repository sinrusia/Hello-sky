package com.wemb.tobit.components.datagrid
{ 
	import flash.display.Graphics;
	
	import mx.core.BitmapAsset;
	import mx.skins.ProgrammaticSkin; 
	 
	/** 
	* DataGrid Header에 점선을 그린다. 
	*/ 
	public class CustomDataGridHeaderBackgroundSkin extends ProgrammaticSkin 
	{ 
		[Embed(source="/assets/datagrid/dataGrid_Header.png")] 
		[Bindable] 
		public var chartPattern:Class;

		[Embed(source="/assets/datagrid/dataGrid_HeaderLong.png")] 
		[Bindable] 
		public var chartPatternLong:Class;

		    
		private var bit_bg:BitmapAsset =  new chartPattern()as BitmapAsset;

		private var bitLong_bg:BitmapAsset =  new chartPatternLong()as BitmapAsset;
					
		/** 
		*  Constructor. 
		*/     
		public function CustomDataGridHeaderBackgroundSkin() 
		{ 
			super(); 
		} 
		/** 
		*  @private 
		*/     
		override protected function updateDisplayList(w:Number, h:Number):void
		{ 
			super.updateDisplayList(w, h);
			graphics.clear();   
			if(h < 30){
				graphics.beginBitmapFill(bit_bg.bitmapData);  
			} else {
				graphics.beginBitmapFill(bitLong_bg.bitmapData);  
			} 
			graphics.drawRect(0,0,w, h);   
			graphics.endFill();   
		}        
	} 
}


