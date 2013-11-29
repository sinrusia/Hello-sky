package com.wemb.tobit.components
{
	import flash.display.Sprite;
	import mx.controls.TileList;
	import mx.controls.listClasses.IListItemRenderer;
	
	public class TileListNostyle extends TileList
	{
		override protected function drawSelectionIndicator (
		      indicator:Sprite, x:Number, y:Number, width:Number, 
		      height:Number, color:uint, 
		      itemRenderer:IListItemRenderer 
	      ):void
		{
	      return;
		}
	}
}