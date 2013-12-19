////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.components.datagrid
{
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.IFactory;
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.core.ClassFactory;
	import mx.controls.dataGridClasses.DataGridItemRenderer;
	
	use namespace mx_internal;

	/**
	 * DataGridColumn 확장 컴포넌트
	 */
	public class ExtensionDataGridColumn extends DataGridColumn
	{
		
		
	    //----------------------------------
	    //  mergeHeaderRenderer
	    //----------------------------------
	    
	    private var _mergeHeaderRenderers:Array;
	
	    /**
	     *  @private
	     *  Storage for the mergeHeaderRenderer property.
	     */
	    private var _mergeHeaderRenderer:IFactory;
		
	    [Bindable("headerRendererChanged")]
	    [Inspectable(category="Other")]
		
		/**
		 *  The class factory for item renderer instances that display the 
		 *  column header for the column.
		 *  You can specify a drop-in item renderer,
		 *  an inline item renderer, or a custom item renderer component as the 
		 *  value of this property.
		 *
		 *  <p>The default item renderer is the DataGridItemRenderer class,
		 *  which displays the item data as text. </p>
		 */
	    public function get mergeHeaderRenderer():IFactory
	    {
			return _mergeHeaderRenderer;
	    }
		
	    /**
	     * @private
	     * 
	     */
	    public function set mergeHeaderRenderer(value:IFactory):void
	    {
	        _mergeHeaderRenderer = value;
	
	        // rebuild the headers
	        if (owner)
	        {
	            owner.invalidateList();
	            owner.columnRendererChanged(this);
	        }
	
	        dispatchEvent(new Event("headerRendererChanged"));
	    }
		
		public function getHeaderRenderer(level:int):IFactory
		{
			if(_mergeHeaderRenderers != null){
				return _mergeHeaderRenderers[level];
			}
			return null;
		}
		
		public function ExtensionDataGridColumn(columnName:String=null)
		{
			//TODO: implement function
			super(columnName);
			mergeHeaderRenderer = new ClassFactory(mx.controls.dataGridClasses.DataGridItemRenderer);
		}
		
		private var _isMergeColumn:Boolean = false;
		
		public function set isMergeColumn(value:Boolean):void
		{
			_isMergeColumn = value;
		}
		
		public function get isMergeColumn():Boolean
		{
			return _isMergeColumn;
		}
		
		private var _multiHeader:Array = null;
		
		public function set multiHeader(value:Array):void
		{
			_mergeHeaderRenderers = new Array();
			for(var i:int = 0; i < value.length; i++){
				_mergeHeaderRenderers[i] = new ClassFactory(mx.controls.dataGridClasses.DataGridItemRenderer);
			}
			_multiHeader = value;
		}
		
		public function get multiHeader():Array
		{
			return _multiHeader;
		}
		
		public function get multiHeaderLength():int
		{
			return _multiHeader.length;
		}
		
		public function getHeaderLabel(level:int):String
		{
			if(_multiHeader != null && _multiHeader.length > level){
				return _multiHeader[level];
			}
			
			return null;
		}
		
		public function get isMultiHeader():Boolean{
			if(_multiHeader != null && _multiHeader.length > 0)
				return true;
			
			return false;
		}
	}
}