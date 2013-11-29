package com.wemb.tobit.components.charts
{
	import mx.containers.VBox;
	import mx.controls.Label;
	
	/**
	 * Chart Label
	 * 
	 * <p>White 색의 라벨과 배경이 검정색에, </p>
	 * 
	 * @author 정태훈 (thlife@wemb.co.kr)
	 * 
	 */
	public class ChartLabel extends VBox
	{
		//-----------------------------------------------------------------
        //
        // Variables
        //
        //-----------------------------------------------------------------
        /**
         * TITLE Label 
         */        
        private var titleLabel:Label;
        
        /**
         * Title Text
         */        
        private var _title:String;
        
        /**
         * Title Change Flag
         */        
        private var titleChanged:Boolean;
        
        /**
         * 배경이 Black인 라벨인지,,,
         */        
        private var _isBlackLabel:Boolean = false;
        
        /**
         * 
         */        
        private var bgTypeChanged:Boolean;
        
		public function ChartLabel()
		{
			super();
		}
		
		//-----------------------------------------------------------------
        //
        // Override
        //
        //-----------------------------------------------------------------
        override protected function createChildren():void
        {
        	super.createChildren();
        	
        	height = 30;
        	width = 150;
        	
        	setStyle( "horizontalAlign", "center" );
        	setStyle( "verticalAlign", "middle" );
        	
        	setStyle( "cornerRadius", 5 );
        	
        	if( !titleLabel )
        	{
        		titleLabel = new Label();
        		titleLabel.setStyle( "fontSize", 12 );
        		titleLabel.setStyle( "textAlign", "center" );
        		titleLabel.setStyle( "color", 0xffffff );
        		
        		titleLabel.height = 20;
        		titleLabel.width = 200;
        		
        		addChild( titleLabel );
        	}
        }
        
        override protected function commitProperties():void
        {
        	super.commitProperties();
        	
        	if( titleChanged )
        	{
        		titleChanged = false;
        		
        		titleLabel.text = title;
        		
        		width = title.length * 12 + 100; 
        	}
        	
        	if( bgTypeChanged )
        	{
        		bgTypeChanged = false;
        		
        		//배경이 검정이면,
        		if( _isBlackLabel )
        		{
        			setStyle( "backgroundColor", 0x000000 );
        			titleLabel.setStyle( "color", "yellow" );
        		}
        		else
        		{
        			setStyle( "backgroundColor", null );
        			titleLabel.setStyle( "color", 0xffffff );
        		}
        	}
        	
        }
        
        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
        	super.updateDisplayList( unscaledWidth, unscaledHeight );
        	
        	//글자수에 따라 Label 크기 변경
        	titleLabel.width = unscaledWidth;
        	
        	graphics.clear();
			
			if( _isBlackLabel )
			{
				graphics.beginFill( this.getStyle( "backgroundColor" ), this.getStyle( "backgroundAlpha" ) );
				
				graphics.drawRoundRectComplex( 0, 0, 
												unscaledWidth, unscaledHeight, 
												5,  
												5,  
												5,  
												5 );
			}
			
			graphics.endFill();	        
        }
        //-----------------------------------------------------------------
        //
        // Functions
        //
        //-----------------------------------------------------------------
        
        //-----------------------------------------------------------------
        //
        // Setter / Getter
        //
        //-----------------------------------------------------------------
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
        
        public function set isBlackLabel( value:Boolean ):void
        {
        	if( this._isBlackLabel != value )
        	{
        		this._isBlackLabel = value;
        		
        		bgTypeChanged = true;
        		invalidateProperties();
        	}
        }
        
        public function get isBlackLabel():Boolean
        {
        	return this._isBlackLabel;
        }
	}
}