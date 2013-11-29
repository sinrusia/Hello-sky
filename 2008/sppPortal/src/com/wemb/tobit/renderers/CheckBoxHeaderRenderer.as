/**
 * CheckBoxHeaderRenderer, Version 1.0
 * datagrid 헤더 부분에 체크박스 삽입
 * @author 
 * @version 
 * @date 
 */ 
package com.wemb.tobit.renderers
{
import flash.events.MouseEvent;
import mx.controls.CheckBox;
import mx.controls.DataGrid;
import mx.controls.dataGridClasses.DataGridColumn;
import mx.events.DataGridEvent;

	public class CheckBoxHeaderRenderer extends CheckBox
	{
		public function CheckBoxHeaderRenderer()
		{
			super();
		}
		private var _data:DataGridColumn;
	
		override public function get data():Object
		{
			return _data;
		}
	
		override public function set data(value:Object):void
		{
			_data = value as DataGridColumn;
			DataGrid(listData.owner).addEventListener(DataGridEvent.HEADER_RELEASE, sortEventHandler);
			selected = (data.getStyle("plainText") == true);
		}

		private function sortEventHandler(event:DataGridEvent):void
		{
			if (event.itemRenderer == this)
				event.preventDefault();
		}
	
		override protected function clickHandler(event:MouseEvent):void
		{
			super.clickHandler(event);
			if (selected)
				data.setStyle("plainText", true);
			else
				data.setStyle("plainText", false);

			parentDocument.datagridHeadClickEvent(selected);
		}

	}
}