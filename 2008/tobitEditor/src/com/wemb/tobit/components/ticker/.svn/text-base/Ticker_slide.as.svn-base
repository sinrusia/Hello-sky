package com.wemb.tobit.components.ticker
{
	
	import com.wemb.tobit.utils.Logger;
	import com.wemb.tobit.vo.Message;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.controls.Label;
	import mx.effects.Move;
	import mx.events.EffectEvent;

	public class Ticker_slide extends Canvas
	{
		//-----------------------------------------------
		//
		// Variables
		//
		//-----------------------------------------------
		private var tickerText:Label;
		
		private var mvEff:Move;
		
		private var _textDataProvider:ArrayCollection;
			
		private var index:int=0;
		
		private var isTickerChange:Boolean = false;
		
		private var _defaultText:String = "등록된 메세지가 없습니다.";
		
		//-----------------------------------------------
		//
		// Functions
		//
		//-----------------------------------------------
		public function Ticker()
		{
			super();
		}
		
		/**
		 * 
		 * 
		 */		
		public function reset():void
		{
			if( mvEff.hasEventListener( EffectEvent.EFFECT_END ) )
			{
				mvEff.removeEventListener( EffectEvent.EFFECT_END, effectEndEvent );
			}
			
			if( mvEff.isPlaying )	mvEff.end();
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function start():void
		{
			if( !mvEff.hasEventListener( EffectEvent.EFFECT_END ) )
			{
				mvEff.addEventListener( EffectEvent.EFFECT_END, effectEndEvent );
			}
			
			mvEff.play();
		}

		
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function effectEndEvent( event:EffectEvent ):void
		{
			isTickerChange = true;
			
			invalidateProperties();
		}
		
		
		//-----------------------------------------------
		//
		// Override
		//
		//-----------------------------------------------
		
		/**
		 * 
		 * 
		 */		
		override protected function createChildren():void
		{
			super.createChildren();
			
			percentWidth = percentHeight = 100;
			verticalScrollPolicy = "off";
			horizontalScrollPolicy = "off";
			
			buttonMode = true;
			useHandCursor = true;
			
			if( !tickerText )
			{
				tickerText = new Label();
				tickerText.percentHeight = 100;
				tickerText.setStyle( "fontAlign", "left" );
				tickerText.styleName = "textTicker";
				
				addChild( tickerText );
				tickerText.y = 4;
			}
			
			if( !mvEff )
			{
				mvEff = new Move(tickerText);
				mvEff.addEventListener( EffectEvent.EFFECT_END, effectEndEvent );
			}
		}
		
		
		/**
		 * Ticker Message Display
		 * 
		 */	
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if( isTickerChange )
			{
				isTickerChange = false;
				
				if( textDataProvider && textDataProvider.length > 0 )
				{
					try
					{
						var currentIndex:int = index % textDataProvider.length;
						
						var message:Message = textDataProvider[currentIndex] as Message;
						
						tickerText.text = message.textpart;
						tickerText.width = message.textpart.length * 15;
						
						if( mvEff.isPlaying ) mvEff.end();
						
						mvEff.duration = 20000 + (15*tickerText.width);
						
						width == 0 ? mvEff.xFrom = 900 : mvEff.xFrom = width;
						mvEff.xTo = 0 - tickerText.width;
						
						mvEff.play();
						
						// index 카운팅
						index++;
					}
					catch( error:Error )
					{
						Logger.data( "Ticker displayMessage Error: " + error.message );
					}
				}
				else
				{
					if( mvEff.isPlaying ) mvEff.end();
					
					tickerText.text = defaultText;

					tickerText.x = 0;
					tickerText.percentWidth = 100;
				}
			}
		}
		
		
		/**
		 * 
		 * @param unscaledWidth
		 * @param unscaledHeight
		 * 
		 */		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList( unscaledWidth, unscaledHeight );
		}
		
		
		
		//-----------------------------------------------
		//
		// Setter / Getter
		//
		//-----------------------------------------------
		
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set textDataProvider( value:ArrayCollection ):void
		{
			this._textDataProvider = value;
			
			if( _textDataProvider )
			{
				index = 0;
				isTickerChange = true;
			}
			invalidateProperties();
		}
		
		public function get textDataProvider():ArrayCollection
		{
			return this._textDataProvider;
		}
		
		
		public function set defaultText( value:String ):void
		{
			this._defaultText = value;
		}
		
		public function get defaultText():String
		{
			return this._defaultText;
		}
	}
}