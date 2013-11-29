package com.wemb.tobit.renderers
{
	import mx.charts.ChartItem;
	import mx.containers.HBox;
	import mx.controls.TextArea;
	import mx.core.IDataRenderer;
	import mx.core.UIComponent;
	import mx.formatters.NumberFormatter;	
	
	public class ColumnSeriesRender extends UIComponent implements IDataRenderer
	{
		private var _hbox:HBox;
		private var _text:TextArea;
		private var _chartItem:ChartItem;
		private var _nf:NumberFormatter;
		
		public function ColumnSeriesRender():void
		{		
			super();
    		
    		_hbox = new HBox();
    		//_hbox.setStyle("backgroundColor", 0xff00ff);
    		_hbox.setStyle("verticalAlign", "bottom");
    		
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
			_nf.precision = 3;
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
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		  
		   	_hbox.width = width;
		   	 /* 
		   	_hbox.height = height;
		   	 */
		   	_text.width = width;
		   	_hbox.height = unscaledHeight;
		   	_text.setStyle("fontSize", 11);
			_text.setStyle("borderStyle", "none");
			_text.setStyle("backgroundAlpha", 0);
			
			
 			if ( _hbox.height < 22 ) _hbox.height = 22;
	   		_text.height = 22; 
	   		
	   		
		   	/* if ( data.element.items.length > 18 )
			{
				_text.setStyle("fontSize", 8);
				_text.setStyle("borderStyle", "none");
				_text.setStyle("backgroundAlpha", 0);
				_text.setStyle("paddingLeft", -5);
				_text.setStyle("paddingRight", -5);
				
				if ( _hbox.height < 12 ) _hbox.height = 12;
		   		_text.height = 12;
			}
			else
			{
				_text.setStyle("fontSize", 11);
				_text.setStyle("borderStyle", "none");
				_text.setStyle("backgroundAlpha", 0);
				
				if ( _hbox.height < 22 ) _hbox.height = 22;
		   		_text.height = 22;
			} */
			
			if ( data.element.yField == "total"){
		   		_text.text = _nf.format(Number(_chartItem.item.run));
		   		 _text.visible = true;
		   		if(_text.text.toString() == "0.000" || _text.text.toString() == "0"){
		   			_text.visible = false;
		   		} 
		    }
		   	else if ( data.element.yField == "total2"){
		   		_text.text = _nf.format(Number(_chartItem.item.con_user));
		   		 _text.visible = true;
		   		 
		   		if(_text.text.toString() == "0.000" || _text.text.toString() == "0"){
		   			_text.visible = false;
		   		} 
		   	}
		   	else if ( data.element.yField == "total3"){
		   		_text.text = String(Number(_chartItem.item.a00)+Number(_chartItem.item.a01)+Number(_chartItem.item.a02)+Number(_chartItem.item.a03));
		   		 _text.visible = true;
		   		if(_text.text.toString() == "0.000" || _text.text.toString() == "0"){
		   			_text.visible = false;
		   		} 
		   	}
		   	else if(data.element.yField == "total4"){
		   		_text.text = _nf.format(Number(_chartItem.item.tps));
		   		 _text.visible = true;
		   		if(_text.text.toString() == "0.000" || _text.text.toString() == "0"){
		   			_text.visible = false;
		   		} 
		   	}
		   
		   _hbox.y = -5;
		   invalidateProperties();
		   invalidateSize();
		}
	}
}
