package com
{
	import spark.components.Group;
	import spark.components.SkinnableContainer;
	import spark.core.SpriteVisualElement;
	
	public class MyRack extends SkinnableContainer
	{
		public function MyRack()
		{
			super();
		}
		
		
		
		[SkinPart(required="false")]
		public var rackBackground:Group;
		
		
		private var module1:SpriteVisualElement;
		
		private var module2:SpriteVisualElement;
		
		
		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			
			if (instance == rackBackground) {
				module1 = new SpriteVisualElement();
				module1.graphics.clear();
				
				module1.graphics.beginFill(0xff00ff, 1);
				module1.graphics.drawRect(0, 0, 100, 100);
				module1.graphics.endFill();
				module1.x = 0;
				module1.y = 0;
				module1.width = 100;
				module1.height = 100;
				
				rackBackground.addElement(module1);
				
				
				module2 = new SpriteVisualElement();
				module2.graphics.clear();
				
				module2.graphics.beginFill(0xff0000, 1);
				module2.graphics.drawRect(0, 0, 100, 100);
				module2.graphics.endFill();
				module2.x = 100;
				module2.y = 100;
				module2.width = 100;
				module2.height = 100;
				
				rackBackground.addElement(module2);

			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void {
			super.partRemoved(partName, instance);
			
			if (instance == rackBackground) {
				rackBackground.removeAllElements();
				module1 = null;
				module2 = null;
				
			}
		}
		
	}
}