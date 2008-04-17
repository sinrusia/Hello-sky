package com.jh.controls.dataGridClasses
{
	import mx.controls.dataGridClasses.DataGridItemRenderer;

	public class JHDataGridItemRenderer extends DataGridItemRenderer
	{
		public function JHDataGridItemRenderer()
		{
			super();
			textAlign = "center"; 
		}
		
		public function set textAlign(value:String):void
		{
			setStyle("textAlign", value);
		}
		
		public function get textAlign():String
		{
			return this.getStyle("textAlign");
		}
	}
}