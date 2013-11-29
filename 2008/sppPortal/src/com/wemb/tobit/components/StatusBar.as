package com.wemb.tobit.components
{
	import flash.display.Sprite;
	
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.core.UIComponent;
	import mx.effects.AnimateProperty;
	import mx.effects.easing.Exponential;
	
	public class StatusBar extends UIComponent
	{
		[Embed(source="assets/chart/highlightBar.png")]
        public var imgCls:Class;

		private var _animateProperty:AnimateProperty;	// Animates the bar width.
		//private var _label:Label;						// Displays _text.
		private var _label2:Label;						// Displays _text.
		private var _backgroundBar:Sprite;				// The grey background of the colored bar.
		private var _bar:Sprite;						// The colored bar.
		//private var _text:String;						// The value for _label.
		//private var _textChanged:Boolean;				// Flag for commitProperties.
		private var _value:Number;					// The value for the bar.
		private var _valueChanged:Boolean;				// Flag for commitProperties.
		//private var _currentColor:Number;				// The current color of the bar.
		private var _image:Image;
		private var _color:Number;
		
		private static const _BAR_HEIGHT:Number = 12;
		
		function StatusBar()
		{
			super();
			width = 156; // Set a default width.
			height = 25;
			
			_animateProperty = new AnimateProperty(this);
			_animateProperty.property = "barWidth";
			_animateProperty.roundValue = true;
			_animateProperty.easingFunction = Exponential.easeOut;
			_animateProperty.duration = 1500;
		}
		/*
		[Inspectable]
		public function set text(t:String):void
		{
			_text = t;
			_textChanged = true;
			invalidateProperties();
		}*/
		
		override protected function createChildren():void
		{
			super.createChildren();
			/*
			if (!_label)
			{
				_label = new Label();
				_label.setStyle("color", 0xFFFFFF);
				_label.setStyle("fontSize", 14);
				_label.setStyle("paddingLeft", 0);
				addChild(_label);
			}*/
			
			if (!_label2)
			{
				_label2 = new Label();
				_label2.setStyle("color", 0x00fffc);
				_label2.setStyle("fontFamily", "Verdana");
				_label2.setStyle("textAlign", "right");
				_label2.setStyle("fontWeight", "bold");
				_label2.setStyle("paddingRight", 20);
				_label2.setStyle("fontSize", 16);
				addChild(_label2);
			}
			
			if (!_bar)
			{
				_bar = new Sprite();
				_bar.graphics.drawRect(0, 0, 1, _BAR_HEIGHT);
				addChild(_bar);
			}
			
			if (!_image)
			{
				_image = new Image();
				_image.source = imgCls;
				addChild(_image);
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			//_label.width = maxBarWidth;
			//_label.height = 18;
			
			_label2.width = maxBarWidth;
			_label2.height = 22;
			
			_image.y = _label2.height + _label2.y + 7 ;
			_image.width = maxBarWidth;
			_image.height = _BAR_HEIGHT;

			_bar.y = _image.y;//_label2.height + _label2.y;
			_bar.width = Math.round(_value * .01 * maxBarWidth);
			_bar.height = _BAR_HEIGHT;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			/*
			if (_textChanged)
			{
				_label.text = _text;
				_textChanged = false;
			}*/
			
			if (_valueChanged)
			{
				if ( isNaN(_value) ) _label2.text = "";
				else _label2.text = _value.toString();
				
				// Stop
				if ( _animateProperty != null && _animateProperty.isPlaying ) _animateProperty.end();
				
				_bar.graphics.clear();
				_bar.graphics.beginFill(_color);
				_bar.graphics.drawRect(0, 0, 1, _BAR_HEIGHT);
				
				_animateProperty.fromValue = barWidth;
				_animateProperty.toValue = Math.round(_value * .01 * maxBarWidth);
				_animateProperty.play();
				
				_valueChanged = false;
			}
		}
		
		public function set barWidth(w:Number):void
		{
			_bar.width = w;
		}
		
		public function get barWidth():Number
		{
			return _bar.width;
		}
		
		// Returns the max available width for the bar.
		private function get maxBarWidth():Number
		{
			return width;// - _LABEL_WIDTH;
		}
		
		public function set value(n:Number):void
		{
			if ( _value != n )
			{
				_value = n;
				_valueChanged = true;
				invalidateProperties();
			}
		}
		
		public function set color(n:Number):void
		{
			if (_value != n)
			{
				_color = n;
				_valueChanged = true;
				invalidateProperties();
			}
		}
		
		// Since we are using device fonts only show the font if the alpha is 1 so we get proper fading.
		override public function set alpha(value:Number):void
		{
			super.alpha = value;
			_label2.visible = value == 1;
		}
	}
}