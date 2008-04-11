package wemb.tobit.draw.helper
{
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.core.UIComponent;
	
	public class Handle extends UIComponent {
		public static const NO_FILL:Number = 0;
		public static const SQUARE:Number = 1;		
		public static const CIRCLE:Number = 2;
		
		public var fill:Number = 0xCCCCCC;
		public var line:Number = 0x5C5C5C;
		public var shape:Number = 1;
		public var volume:Number = 8;
		
		public var _setX:Number;
		public var _setY:Number;
		
		public function Handle( shape:Number = Handle.SQUARE, 
								volume:Number = 10, //volume:Number = 8,
								line:Number = 0x5C5C5C,
								fill:Number = 0xCCCCCC ) {
			this.fill = fill;
			this.line = line;
			this.shape = shape;
			this.volume = volume;
			
			this.width = 10;
			this.height = 10;

			initUI();
		}
		
		public function initUI():void {
			buttonMode = true;
			cacheAsBitmap = true;

			drawHandle( line, fill );

			addEventListener( MouseEvent.MOUSE_DOWN, doMouseDown );
			addEventListener( MouseEvent.MOUSE_UP, doMouseUp );
		}
	
		public function drawHandle( line:Number = 0x5C5C5C, 
									fill:Number = 0xCCCCCC ):void {
			with( graphics ) {
				clear();
				lineStyle( 1, line );
				
				if( fill != Handle.NO_FILL ) {
					beginFill( fill );
				} else {
					beginFill( fill, 0 );
				}
				
				switch( shape ) {
					case Handle.SQUARE:
						drawRect( 0 - ( volume / 2 ), 
								  0 - ( volume / 2 ), 
								  volume, 
								  volume );
						break;
						
					case Handle.CIRCLE:
						drawCircle( 0, 0, volume / 2 );
						break;
				}
			}				
		}
		
		public function doMouseDown( event:MouseEvent ):void {
			if( fill == Handle.NO_FILL ) {
				drawHandle( 0xFF0000, Handle.NO_FILL );				
			} else {
				drawHandle( 0xFF0000, 0xFF99FF );				
			}
			
			startDrag();
		}
		
		public function doMouseUp( event:MouseEvent ):void {
			stopDrag();
			drawHandle( line, fill );
		}
	}
}