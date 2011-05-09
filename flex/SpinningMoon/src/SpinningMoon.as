package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

	public class SpinningMoon extends Sprite
	{
		
		private var sphere:Bitmap;
		
		private var textureMap:BitmapData;
		
		private var sourceX:int = 0;
		
		private var radius:int	= 0;
		
		public function SpinningMoon(){
			var imageloader:Loader = new Loader();
			imageloader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompleteHandler);
			//imageloader.load(new URLRequest("moonMap.png"));
			sphere = new Bitmap();
			sphere.bitmapData = createFisheyeMap(50);
			addChild(sphere);
		}
		
		private function loadCompleteHandler(event:Event):void{
			textureMap = event.target.content.bitmapData;
			
			radius	= textureMap.height / 2;
			
			sphere = new Bitmap();
			sphere.bitmapData = new BitmapData(textureMap.width / 2, textureMap.height);
			sphere.bitmapData.copyPixels(textureMap, new Rectangle(0, 0, sphere.width, sphere.height),
				new Point(0, 0));
			
			
			//var fisheyeLens:BitmapData = new BitmapData(radius * 2, radius * 2);
			var fisheyeLens:BitmapData = createFisheyeMap(radius);
			
			var displaceFilter:DisplacementMapFilter;
			displaceFilter = new DisplacementMapFilter(fisheyeLens,
													new Point(radius, 0),
													BitmapDataChannel.RED,
													BitmapDataChannel.BLUE,
													radius, 0);
			sphere.filters = [displaceFilter];
			this.addChild(sphere);
			
			
			var moonMask:Shape = new Shape();
			moonMask.graphics.beginFill(0);
			moonMask.graphics.drawCircle(radius * 2, radius, radius);
			this.addChild(moonMask);
			this.mask	= moonMask; 
			
			var rotationTimer:Timer = new Timer(15);
			rotationTimer.addEventListener(TimerEvent.TIMER, rotateMoon);
			rotationTimer.start();
			
			// add a slight atmospheric glow effect
			this.filters = [new GlowFilter(0xC2C2C2, .75, 20, 20, 2, BitmapFilterQuality.HIGH, true)];
			
			dispatchEvent(event);
			
		}
		
		private function createFisheyeMap(radius:int):BitmapData{
			var diameter:int = 2 * radius;
			
			var result:BitmapData = new BitmapData(diameter, diameter, false, 0x808080);
			
			for(var x:int = 0; x < diameter; x++){
				for(var y:int = 0; y < diameter; y++){
					
					var pctX:Number = (x - radius) / radius;
					var pctY:Number = (y - radius) / radius;
					var inputValue:Number = pctX*pctX+pctY*pctY
					var pctDistance:Number = Math.sqrt(inputValue);
					
					if(pctDistance < 1){
						var red:int;
						var green:int;
						var blue:int;
						var rgb:uint;
						
						var tempX:Number = 0.75 * pctX * pctX * pctX;
						var tempY:Number = 1 - pctY * pctY;
						
						red = 128 * (1 + tempX / tempY);
						green = 0;
						blue = 0;
						rgb = (red << 16 | green << 6 | blue);
						result.setPixel(x, y, rgb);

					}
				}
			}
			
			return result;
		}
		
		private function rotateMoon(event:TimerEvent):void{
			sourceX += 1;
			
			if(sourceX >  textureMap.width /2){
				sourceX = 0;
			}
			
			sphere.bitmapData.copyPixels(textureMap, new Rectangle(sourceX, 0, sphere.width, sphere.height),
				new Point(0, 0));
			
			event.updateAfterEvent();
		}
	}
}
