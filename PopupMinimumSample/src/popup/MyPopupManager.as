package popup
{
	import comp.WorkBar;
	
	import flash.system.System;
	import flash.utils.Endian;
	
	import mx.core.IFlexDisplayObject;
	import mx.events.EffectEvent;
	import mx.managers.SystemManager;
	import mx.utils.UIDUtil;
	
	import spark.effects.Animate;
	import spark.effects.AnimateTransform;
	import spark.effects.Move;
	import spark.effects.animation.MotionPath;
	import spark.effects.animation.SimpleMotionPath;

	public class MyPopupManager
	{
		public function MyPopupManager()
		{
		}
		
		private static var popupMap:Array = new Array();
		
		public static var workBar:WorkBar;
		
		public static function minimumPopup(target:IFlexDisplayObject):void {
			var id:String = UIDUtil.createUID();
			target.name = id;
			popupMap[id] = {
				popup: target,
				x: target.x,
				y: target.y,
				width: target.width,
				height: target.height
			};
			// Animate
			var animate:Animate = new Animate(target);
			animate.motionPaths = new Vector.<MotionPath>();
			// move
			animate.motionPaths.push(new SimpleMotionPath("x", target.x, 0));
			animate.motionPaths.push(new SimpleMotionPath("y", target.y, target.stage.height));
			// resize
			animate.motionPaths.push(new SimpleMotionPath("width", target.width, 10));
			animate.motionPaths.push(new SimpleMotionPath("height", target.height, 10));
			// alpha
			animate.motionPaths.push(new SimpleMotionPath("alpha", 1, 0.1));
				
			animate.addEventListener(EffectEvent.EFFECT_END, minimumEndHandler);
			animate.play();
		}
		
		protected static function minimumEndHandler(event:EffectEvent):void
		{
			var id:String = event.currentTarget.target.name;
			var title:String = event.currentTarget.target["title"];
			
			if(workBar) {
				workBar.addWorkItem(id, title);
			}

		}
		
		public static function returnPopup(id:String):void {
			var popupInfo:Object = popupMap[id];
			if(popupInfo) {
				var target:IFlexDisplayObject = popupInfo.popup;
				
				// Animate
				var animate:Animate = new Animate(target);
				animate.motionPaths = new Vector.<MotionPath>();
				// move
				animate.motionPaths.push(new SimpleMotionPath("x", target.x, popupInfo.x));
				animate.motionPaths.push(new SimpleMotionPath("y", target.y, popupInfo.y));
				// resize
				animate.motionPaths.push(new SimpleMotionPath("width", target.width, popupInfo.width));
				animate.motionPaths.push(new SimpleMotionPath("height", target.height, popupInfo.height));
				// alpha
				animate.motionPaths.push(new SimpleMotionPath("alpha", 0.1, 1));

				animate.play();
			}
		}
	}
}