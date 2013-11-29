package com.wemb.tobit.components.labels
{
	import mx.containers.HBox;
	import mx.controls.Label;
	import mx.formatters.NumberFormatter;
	
	/**
	 * 기관별 트래픽 Top
	 * 
	 * @author 정태훈(thlife@wemb.co.kr)
	 * 
	 */	
	public class TrafficTopLabel extends HBox
	{
		//--------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------
		/**
		 * Type Define
		 */
		public static const TYPE_SMALL:String = "small";
		
		public static const TYPE_LARGE:String = "large";
		
		public static const TYPE_NOBG:String = "noBG";
		
		[Bindable]
		[Embed('./assets/labels/traffictop5_bg.png')]
		private var bgImgLarge:Class;
		
		[Bindable]
		[Embed('./assets/labels/risk_traffictop_2.png')]
		private var bgImgSmall:Class;
		
		/**
		 * Label 
		 */		
		private var titleLabel:Label;
		
		private var valueLabel:LabelCnt;
		
		private var rateLabel:LabelCnt;
		
		private var unitLabel:Label;
		
		/**
		 * Changed Flag 
		 */		
		private var titleChanged:Boolean;
		
		private var valueChanged:Boolean;
		
		private var unitChanged:Boolean;
		
		private var typeChanged:Boolean;
		
		/**
		 * Data 
		 */		
		private var _title:String = "NAME";
		
		private var _value:Number = -1;
		
		private var _rate:Number = 0;
		
		private var _unit:String = "mbps";
		
		private var _type:String = TYPE_SMALL;
		
		private var nf:NumberFormatter;
		
		public function TrafficTopLabel()
		{
			super();
		}
		
		//--------------------------------------------------
		//
		// Override
		//
		//--------------------------------------------------
		override protected function createChildren():void
		{
			super.createChildren();
			
			type = TYPE_SMALL;
			
			setStyle( "borderStyle", "solid" );
			
			setStyle( "paddingLeft", 2 );
			setStyle( "paddingRight", 10 ); 
			setStyle( "horizontalAlign", "center" );
			setStyle( "verticalAlign", "middle" );
			
			if( !nf )
			{
				nf = new NumberFormatter();
				nf.useThousandsSeparator = true;
			}
			
			if( !titleLabel )
			{
				titleLabel = new Label();
				titleLabel.truncateToFit = false;
				titleLabel.text = title;
				titleLabel.width = 90;
				
				titleLabel.styleName = "trafficLabel";
				
				addChild( titleLabel );
			}
			
			if( !valueLabel )
			{
				valueLabel = new LabelCnt();
				valueLabel.nowValue = value;
				valueLabel.percentWidth = 100;
				valueLabel.styleName = "trafficValueLarge";
				addChild( valueLabel );
			}
			
			if( !rateLabel )
			{
				rateLabel = new LabelCnt();
				rateLabel.nowValue = rate;
				rateLabel.percentWidth = 100;
				rateLabel.styleName = "trafficValueLarge";
				addChild(rateLabel);
			}
			
			if( !unitLabel )
			{
				unitLabel = new Label();
				unitLabel.text = unit;
				unitLabel.width = 50;
				unitLabel.truncateToFit = false;
				
				unitLabel.setStyle( "paddingLeft", 8 );
				unitLabel.styleName = "trafficUnit";
				
				addChild( unitLabel );
			}
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if( titleChanged )
			{
				titleChanged = false;
				
				titleLabel.text = title;
			}
			
			if( valueChanged )
			{
				valueChanged = false;

				valueLabel.nowValue = value;
			}
			
			if( unitChanged )
			{
				unitChanged = false;
				
				unitLabel.text = unit;
			}
			
			//이미지 타입 변경
			if( typeChanged )
			{
				typeChanged = false;
				
				if( type == TYPE_LARGE )
				{
					setStyle( "backgroundImage", bgImgLarge );
					valueLabel.styleName = "trafficValueLarge";
					
					width = 255;
					height = 75;
				}
				else if( type == TYPE_SMALL )
				{
					setStyle( "backgroundImage", bgImgSmall );
					valueLabel.styleName = "trafficValueSmall";
					
					width = 255;
					height = 75;
				}
				else
				{
					width = 296;
					height = 35;
				}
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList( unscaledWidth, unscaledHeight );
			
			if( type == TYPE_LARGE )
			{
				setStyle( "backgroundImage", bgImgLarge );
				width = 255;
				height = 75;
			}
			else
			{
				setStyle( "backgroundImage", bgImgSmall );
				width = 255;
				height = 75;
			}
		}
		
		//--------------------------------------------------
		//
		// Setter / Getter
		//
		//--------------------------------------------------
		public function set title( value:String ):void
		{
			if( this._title != value )
			{
				this._title = value;
				
				titleChanged = true;
				invalidateProperties();
			}
		}
		
		public function get title():String
		{
			return this._title;
		}
		
		public function set value( __value:Number ):void
		{
			if( this._value != __value )
			{
				this._value = __value;
				
				valueChanged = true;
				invalidateProperties();
			}
		}
		
		public function get value():Number
		{
			return this._value;
		}
		
		public function set rate(value:Number):void
		{
			this._rate = value;
			valueChanged = true;
			invalidateProperties();
		}
		
		public function get rate():Number
		{
			return _rate;
		}
		
		public function set unit( value:String ):void
		{
			if( this._unit != value )
			{
				this._unit = value;
				
				unitChanged = true;
				invalidateProperties();
			}
		}
		
		public function get unit():String
		{
			return this._unit;
		}
		
		public function set type( value:String ):void
		{
			if( this._type != value )
			{
				this._type = value;
				
				typeChanged = true;
				invalidateProperties();
			}
		}
		
		public function get type():String
		{
			return this._type;
		}
	}
}