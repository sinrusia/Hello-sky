package com.wemb.tobit.components.charts.renderers
{
	import flash.geom.Rectangle;
	
	import mx.charts.series.items.ColumnSeriesItem;
	import mx.core.IDataRenderer;
	import mx.graphics.GradientEntry;
	import mx.graphics.LinearGradient;
	import mx.skins.ProgrammaticSkin;
	
	public class CylinderChartItemRenderer extends mx.skins.ProgrammaticSkin implements IDataRenderer
	{
     	private var _chartItem:ColumnSeriesItem;
     	
     	private var bgFlag:Boolean;
		
		public function CylinderChartItemRenderer():void
		{		
			super();
		}
	
		public function set data(value:Object):void
		{
			_chartItem = value as ColumnSeriesItem; 
        	invalidateDisplayList();
		}
		
		public function get data():Object
		{
			return _chartItem;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);				
			
			/*
	        graphics.clear();
	        graphics.beginFill(colors[(_chartItem == null)? 0:_chartItem.index]);
	        graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
	        graphics.endFill();
			
			
			trace( bgFlag );
			bgFlag = true;
			
			graphics.lineStyle( 1, 0xffffff, .5 );
			  
			var fill:LinearGradient = new LinearGradient();
			var g1:GradientEntry = new GradientEntry( 0x999999, 0, 0 );
			var g2:GradientEntry = new GradientEntry( 0xffffff, .3, 1 );	
			var g3:GradientEntry = new GradientEntry( 0x999999, .75, 0 );
			var g4:GradientEntry = new GradientEntry( 0xffffff, 1, 0 );
			  
			fill.entries = [ g1, g2, g3, g4 ];
			fill.begin( graphics, new Rectangle( 0, (unscaledHeight-_chartItem.min), unscaledWidth, _chartItem.min ) );
			graphics.drawRoundRect( 0, (unscaledHeight-_chartItem.min), unscaledWidth, _chartItem.min, 0 );
			fill.end( graphics );
			*/
		}
	}
}