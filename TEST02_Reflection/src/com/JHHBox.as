package com
{
	import mx.containers.HBox;

	public class JHHBox extends HBox
	{
		public function JHHBox()
		{
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			this.graphics.lineStyle(1, 0x141414);
			this.graphics.drawRect(0, 0, this.width, this.height);
			this.graphics.lineStyle(1, 0x595959);
			this.graphics.beginFill(0x474747);
			this.graphics.drawRect(1, 1, this.width - 2, this.height - 2);
			this.graphics.endFill();
		}
	}
}