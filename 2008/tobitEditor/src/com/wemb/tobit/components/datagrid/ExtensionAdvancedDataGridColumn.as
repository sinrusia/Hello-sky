////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.components.datagrid
{
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;

	/**
	 * AdvancedDataGridColumn 확장 컴포넌트
	 */
	public class ExtensionAdvancedDataGridColumn extends AdvancedDataGridColumn
	{
		public function ExtensionAdvancedDataGridColumn(columnName:String=null)
		{
			super(columnName);
		}
		
		/**
		 * 칼럼의 merge 여부를 저장한다.
		 * true : merge 수행
		 */
		private var _isMergeColumn:Boolean = false;
		
		public function set isMergeColumn(value:Boolean):void
		{
			_isMergeColumn = value;
		}
		
		public function get isMergeColumn():Boolean
		{
			return _isMergeColumn;
		}
		
	}
}