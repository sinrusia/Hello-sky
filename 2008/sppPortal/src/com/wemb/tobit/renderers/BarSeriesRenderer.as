package com.wemb.tobit.renderers
{
	import mx.charts.ChartItem;
	import mx.containers.HBox;
	import mx.controls.TextArea;
	import mx.core.IDataRenderer;
	import mx.core.UIComponent;
	import mx.formatters.NumberFormatter;	
	
	public class BarSeriesRenderer extends UIComponent implements IDataRenderer
	{
		private var _hbox:HBox;
		private var _text:TextArea;
		private var _chartItem:ChartItem;
		private var _nf:NumberFormatter;
		
		public function BarSeriesRenderer():void
		{		
			super();
    		
    		_hbox = new HBox();
    		_hbox.horizontalScrollPolicy = "off";
    		_hbox.verticalScrollPolicy = "off";
    		_hbox.setStyle("horizontalAlign", "right");
    		_hbox.setStyle("verticalAlign", "center");
			addChild(_hbox);
			
			_text = new TextArea();
			_text.editable = false;
			_text.selectable = false;
			_text.setStyle("color", 0xd1d1d1);
			_text.setStyle("textAlign", "center");
			_text.setStyle("fontWeight", "bold");
			_text.setStyle("backgroundColor", 0xFFFFFF);
			_text.setStyle("borderThickness", .5);
			_text.setStyle("cornerRadius", 5);
						
			_hbox.addChild(_text);
			
			_nf = new NumberFormatter();
			_nf.precision = 0;
			_nf.useThousandsSeparator = true;
		}
	
		public function get data():Object
		{
			return _chartItem;
		}
	
		public function set data(value:Object):void
		{
			if (_chartItem == value)
				return;
				
			_chartItem = ChartItem(value);
		}
		 									 
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{	
			super.updateDisplayList(100, unscaledHeight);
		   
		   	_hbox.width = 	_text.width = 100;
		   	_hbox.height = height;
		   	
		   	_text.setStyle("fontSize", 14);
			_text.setStyle("borderStyle", "none");
			_text.setStyle("backgroundAlpha", 0);
			
			/* if ( _hbox.height < 22 ) _hbox.height = 22;
	   		_text.height = 22; */
			
		   	_text.text = _nf.format(Number(_chartItem.item.critical) + 
		   							Number(_chartItem.item.major) + 
		   							Number(_chartItem.item.minor) + 
		   							Number(_chartItem.item.warning) + 
		   							Number(_chartItem.item.normal) + 
		   							Number(_chartItem.item.outage) ) + "(건)";
		    
		  // _hbox.y = -5;
		   invalidateProperties();
		   invalidateSize();
		}
	}
}
