package com.wemb.tobit.components.charts.renderers
{
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import mx.charts.effects.effectClasses.SeriesSlideInstance;
	import mx.controls.Label;
	import mx.core.IDataRenderer;
	import mx.core.UIComponent;
	import mx.events.EffectEvent;
	import mx.formatters.NumberFormatter;
	import mx.graphics.GradientEntry;
	import mx.graphics.LinearGradient;
	
	/**
	 * 컬럼 차트 라벨 아이템 렌더러
	 * 
	 * 
	 * @author 정태훈 (thlife@wemb.co.kr)
	 * 
	 */	
	public class LabelChartItemRenderer extends UIComponent implements IDataRenderer
	{
		//--------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------
		
		/**
		 * 수치 표현 라벨
		 */
	    protected var _label:Label;
	    
	    /**
	     * Data 
	     */	    
	    protected var _data:Object;
	    
	    /**
	     * 데이터 변경 Flag 
	     */	    
	    protected var dataChanged:Boolean;
	    
	    /**
	     * 이펙트 종료 Flag
	     */	    
	    protected var effectEndFlag:Boolean;
	    
	    /**
	     * 실린더 표현 
	     */	    
	    protected var _bg:UIComponent;
	    
	    /**
	     * Number Formatter 
	     */	    
	    protected var nf:NumberFormatter;
	    
	    //--------------------------------------------------------
		//
		// Functions
		//
		//--------------------------------------------------------
		
	    public function LabelChartItemRenderer():void
	    {
	        super();
	    }
	    
	    
		//--------------------------------------------------------
		//
		// Override
		//
		//--------------------------------------------------------
		
		/**
		 * 컴포넌트 생성
		 * 
		 */		
		override protected function createChildren():void
		{
			super.createChildren();
			
			if( !nf )
			{
				nf = new NumberFormatter();
				nf.useThousandsSeparator = true;
			}
			
			if( !_bg )
			{
				_bg = new UIComponent();
				_bg.percentHeight = 100;
				parent.addChild( _bg );
			}
			
			//Label Create and Style Setting
	        if( !_label )
	    	{
	    		_label = new Label();
		    	_label.visible = false;
		    	
	    		_label.setStyle( "textAlign", "center" );
	    		_label.setStyle( "color", getStyle("color") );
	    		_label.setStyle( "fontSize", getStyle("fontSize") );
	    		_label.setStyle( "fontWeight", getStyle("fontWeight") );
	    		
	    		parent.addChild( _label );
	    	}
			
        	//ColumnChart에 이벤트 등록
        	parent["owner"].addEventListener( "dataChanged", function(e:Event):void{
	        	effectEndFlag = false;
	        	_label.visible = false;
	        });
		    
	        parent.addEventListener( EffectEvent.EFFECT_END, function(e:EffectEvent):void{
	        	if( SeriesSlideInstance(e.effectInstance).direction == "up" )
	        	{
		        	effectEndFlag = true;
	        	}
	        	if( SeriesSlideInstance(e.effectInstance).direction == "down" )
	        	{
		        	effectEndFlag = false;
		        	_label.visible = false;
	        	}
	        });
		}
		
		
		/**
		 * 데이터 변경시 라벨에 데이터 Setting 
		 * 
		 */		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if( dataChanged )
			{
				dataChanged = false;
				
				//Text Setting
				_label.text = nf.format(data.item[data.element.yField]);
			}
		}
		
		
	    /**
	     * 화면 Draw시, 컬럼을 Draw 하고, 라벨 위치를 셋팅한다.
	     * 
	     * @param unscaledWidth
	     * @param unscaledHeight
	     * 
	     */		
	    override protected function updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void
	    {
	        super.updateDisplayList(unscaledWidth, unscaledHeight);
	        
	        //Chart Draw
	        var rc:Rectangle = new Rectangle( 0, 0, unscaledWidth, unscaledHeight );
	        var g:Graphics = graphics;
	        g.clear();        
	        
	        g.moveTo( rc.left, rc.top);
	        g.beginFill( data.fill.color, data.fill.alpha );
	        
	        g.lineTo( rc.right, rc.top );
	        g.lineTo( rc.right, rc.bottom );
	        g.lineTo( rc.left, rc.bottom );
	        g.lineTo( rc.left, rc.top );
	        
	        g.endFill();
	        
	        
	        //실린더 모양의 배경 Draw
	        g = _bg.graphics;
	        g.clear();

			var fill:LinearGradient = new LinearGradient();
			var g1:GradientEntry = new GradientEntry( 0xffffff, 0, .38 );
			var g2:GradientEntry = new GradientEntry( 0xffffff, .14, .29 );	
			var g3:GradientEntry = new GradientEntry( 0xffffff, .40, .35 );
			var g4:GradientEntry = new GradientEntry( 0xffffff, .79, .12 );
			var g5:GradientEntry = new GradientEntry( 0xffffff, 1, .38 );
			
			  
			fill.entries = [ g1, g2, g3, g4, g5 ];
			fill.begin( g, new Rectangle( 0, 0, width, data.element.height ) );
			g.drawRoundRect( 0, 0, width, data.element.height, 0 );
			fill.end( g );

			_bg.alpha = 1;
			_bg.move( x, 0 );
	        
	        try{
		        //com.wemb.tobit.components.charts.LabelColumnChart 에 정의된 속성을 가져와서
		        //라벨 Visible 컨트롤
		        var labelVisible:Boolean = true;
		        if( parent && parent["owner"].hasOwnProperty("labelVisible") )
		        {
					labelVisible = parent["owner"].labelVisible;
		        }
		        
		        //이펙트에 따라 라벨 Control
		    	if( effectEndFlag && labelVisible )
		    	{
			        //Visible & Size & Position Setting
		        	_label.visible = true;
			        _label.setActualSize( _label.getExplicitOrMeasuredWidth(), 
			        					  _label.getExplicitOrMeasuredHeight() );
					
					//사이즈를 넘으면, 라벨을 차트 아래로 표시
					if( data.element.height < unscaledHeight + _label.getExplicitOrMeasuredHeight() )
					{
						_label.move( data.x - _label.getExplicitOrMeasuredWidth()/2, 
									 data.y );
					}
					else
					{
						_label.move( data.x - _label.getExplicitOrMeasuredWidth()/2, 
									 data.y - _label.getExplicitOrMeasuredHeight() );
					}
		    	}
		    	else
		    	{
		    		_label.visible = false;
		    	}
	        }catch(error:Error){
	        	trace( "LabelChartItemRenderer: ", error.message );
	        }
	    	
	    	//컴포넌트 Index Change
	    	parent.setChildIndex( _bg, parent.numChildren-1 );
	        parent.setChildIndex( _label, parent.numChildren-1 );
		}
		
		//--------------------------------------------------------
		//
		// Setter / Getter
		//
		//--------------------------------------------------------
		public function set data(value:Object):void
		{
			this._data = value;
			
			if( data )
			{
				dataChanged = true;
			}
			invalidateProperties();
		}
		
		public function get data():Object
		{
			return this._data;
		}
	}
}