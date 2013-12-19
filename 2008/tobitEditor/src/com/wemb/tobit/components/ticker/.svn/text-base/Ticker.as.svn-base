package com.wemb.tobit.components.ticker
{
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.controls.Label;
	import mx.effects.Fade;
	import mx.effects.Move;
	import mx.effects.Sequence;
	import mx.events.EffectEvent;

	public class Ticker extends Canvas
	{
		//-----------------------------------------------
		//
		// Variables
		//
		//-----------------------------------------------
		private var tickerText:Label;
		
		private var mvEff:Move;
		
		//EFFECT
		private var tickerChangeSequence:Sequence;
		
		private var hideFade:Fade;
		
		private var showFade:Fade;
		
		private var _textDataProvider:ArrayCollection;
			
		private var index:int=0;
		
		private var isTickerChange:Boolean = false;
		
		private var _defaultText:String = "등록된 메세지가 없습니다.";
		
		//Timer
		private var timer:Timer;
		
		//Mouse Over 상태를 표시한다.
		private var isOver:Boolean = false;
		
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
		
		public function play():void{
			index = 0;
			displayMessage();			
		}
		public function stop():void{
			timer.stop();
		}
		
		private function tickerTimerEvent( event:TimerEvent ):void
		{
			timer.stop();
			tickerChangeSequence.play();
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
		
		
		private function hideHandler(event:EffectEvent):void
		{
			if( !isOver )
			{
				displayMessage();
			}
		}
		
		private function onRollOver(event:MouseEvent):void
		{
			isOver = true;
			tickerChangeSequence.reverse();
			timer.stop();
		}
		
		private function onRollOut(event:MouseEvent):void
		{
			isOver = false;
			timer.start();
		}
		
		private function displayMessage():void
		{
			//타이머 멈춤
			timer.stop();
			
			//위치 초기화한다.
			tickerText.x = 0;
			
			if( textDataProvider && textDataProvider.length > 0 )
			{
				var currentIndex:Number = index % textDataProvider.length;
				
				tickerText.text = textDataProvider[currentIndex].text_part;
				tickerText.validateNow();
				
				if( tickerText.textWidth > width )
				{ 
					if( mvEff.isPlaying )
						mvEff.end();
					
					mvEff.target = tickerText;
					mvEff.xTo = width -tickerText.textWidth - 5;
					mvEff.duration = Math.round(tickerText.textWidth * 4.5);
					
					timer.delay = mvEff.duration + 10000;
					
					mvEff.play();
				}
				
				//타이머 재시작
				timer.start();
				
				// index 카운팅
				index++;
				
			}
			else
			{
				tickerText.text = "등록된 메세지가 없습니다.";
			}
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
			
			if( !timer )
			{
				timer = new Timer(10000);
				timer.addEventListener( TimerEvent.TIMER, tickerTimerEvent );
			} 
			
			if( !tickerText )
			{
				tickerText = new Label();
				tickerText.percentHeight = 100;
				tickerText.styleName = "textTicker";
				addChild( tickerText );
				tickerText.y = 4;
			}
			
			if( !mvEff )
			{
				mvEff = new Move(tickerText);
				mvEff.duration = 1200; 
			}
			
			if( !showFade )
			{
				showFade = new Fade(tickerText);
				showFade.alphaFrom = 1;
				showFade.alphaTo = 0;
				showFade.duration = 600;
			}
			
			if( !hideFade )
			{
				hideFade = new Fade(tickerText);
				hideFade.alphaFrom = 0;
				hideFade.alphaTo = 1;
				hideFade.duration = 600;
				hideFade.addEventListener(EffectEvent.EFFECT_END, hideHandler );
			}
			
			if( !tickerChangeSequence )
			{
				tickerChangeSequence = new Sequence();
				tickerChangeSequence.addChild( showFade );
				tickerChangeSequence.addChild( hideFade );
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
				
				index = 0;
				displayMessage();
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