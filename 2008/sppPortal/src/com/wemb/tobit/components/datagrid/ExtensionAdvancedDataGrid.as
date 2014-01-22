/**
 * Copyright (C) 2004-2009 WeMB INC. 
 * All Rights Reserved.
 **	@date			:	2009-04-24
 *	@auther			:	고재학
 *	@ver			:	1.0
 *	@description 	:	AdvancedDataGrid 확장 컴포넌트, row칼럼 머지하는 기능이추가 되었습니다.
 */
package com.wemb.tobit.components.datagrid
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import mx.controls.AdvancedDataGrid;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.controls.listClasses.BaseListData;
	import mx.core.FlexShape;
	import mx.core.FlexSprite;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	
	public class ExtensionAdvancedDataGrid extends AdvancedDataGrid
	{
		
		/**
		 * 열정보를 포함하고 있다.
		 */
		private var rowsInfoDic:Dictionary;
		
		/**
		 * MyDataGrid에 새로운 데이타가 들어왔을때 각 로우의 색 정보를 체크하는데, 이런한 프로세스를 수행해야할지 여부를 
		 * _dataProviderUpdate의 상태정보로 가지고 있는다.
		 */
		private var _dataProviderUpdate:Boolean = false;
		
		
		public function ExtensionAdvancedDataGrid()
		{
			super();
		}
		
		//--------------------------------------------------------------------------------------
		//
		//	Properties
		//
		//--------------------------------------------------------------------------------------
		
		/**
		 * 
		 * @param value
		 * 
		 */
		override public function set dataProvider(value:Object):void
		{
			_dataProviderUpdate= true;
			super.dataProvider = value;
		}
		
		override public function set verticalScrollPosition(value:Number):void{
			super.verticalScrollPosition = value;
			
			mergeProcess();
		}
		
		/**
		 * 
		 * 
		 */		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			// dataprovider이 업데이트 되면 다음 프로세스를 수행한다.
			// 칼럼의 상태정보를 Dictionary에 저장한다.
			if(_dataProviderUpdate){
				_dataProviderUpdate	= true;
				rowsInfoDic			= new Dictionary();
				
				var index:int				= 0;
				var colIndex:int			= 0;
				var isPreChange:Boolean		= false;
				var mergeColumnsLabel:Array = new Array();
				var mergeColumnsCnt:Array	= new Array();
				
				if(dataProvider != null && dataProvider.length > 0){
					for(index=0; index < dataProvider.length; index++){
						
						isPreChange = false; // 다음 Row 수행시 초기화 한다.
						var rowInfo:Object = new Object();
						
						for(colIndex=0; colIndex < columns.length; colIndex++){
							var col:AdvancedDataGridColumn = columns[colIndex];
							if( col is ExtensionAdvancedDataGridColumn){
								if(ExtensionAdvancedDataGridColumn(col).isMergeColumn){
									if(isPreChange){
										mergeColumnsLabel[colIndex] = dataProvider[index][ExtensionAdvancedDataGridColumn(col).dataField];
										if(isNaN(mergeColumnsCnt[colIndex])){
											mergeColumnsCnt[colIndex] = 0;
										}else{
											mergeColumnsCnt[colIndex] += 1; 
										}
									}else{
										dataProvider[index][ExtensionAdvancedDataGridColumn(col).dataField];
										mergeColumnsLabel[colIndex];
										if(dataProvider[index][ExtensionAdvancedDataGridColumn(col).dataField] != mergeColumnsLabel[colIndex]){
											mergeColumnsLabel[colIndex] = dataProvider[index][ExtensionAdvancedDataGridColumn(col).dataField];
											if(isNaN(mergeColumnsCnt[colIndex])){
												mergeColumnsCnt[colIndex] = 0;
											}else{
												mergeColumnsCnt[colIndex] += 1; 
											}
											isPreChange = true;
										}
									}
									rowInfo[colIndex.toString()] = mergeColumnsCnt[colIndex];
								}
							}
						}
						
						rowsInfoDic[index.toString()] = rowInfo;
					}
				}
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			mergeProcess();
		}
		
		
		/**
		 * 데이타그리드 머지처럼 보이기 위한 프로세스
		 * 
		 */
		private function mergeProcess():void
		{
			trace("mergeProcess");
			drawLinesAndColumnBackgrounds();
			
			//trace(">>>>>>>>>시작해요");
			//상태정보 Dictionary Class를 초기화한다.
			//_rowInfoDic = new Dictionary();
			
	        var colors:Array = getStyle("alternatingItemColors");
			
			var mergeColumnsCnt:Array = new Array();
			var mergeColumnsLabel:Array = new Array();
			var isPreChange:Boolean = false;
			
			//trace(listItems.length);
			//trace(visibleColumns.length);
			
			// ColumnBackgroundColor Graphic
			var colBGs:Sprite = Sprite(listContent.getChildByName("colBGs"));
			if (!colBGs)
			{
				colBGs = new FlexSprite();
				colBGs.mouseEnabled = false;
				colBGs.name = "colBGs";
				listContent.addChildAt(colBGs, listContent.getChildIndex(listContent.getChildByName("rowBGs")) + 1);
			}
			for(var n:int = 0; n < colBGs.numChildren; n++){
				if(colBGs.getChildAt(n) is DisplayObject){
					DisplayObject(colBGs.getChildAt(n)).visible = false;
				}
			}
			
			// Line Graphics
			var lines:Sprite = Sprite(listContent.getChildByName("lines"));
			if (!lines)
			{
				lines = new UIComponent();
				lines.name = "lines";
				lines.cacheAsBitmap = true;
				lines.mouseEnabled = false;
				listContent.addChild(lines);
			}
			
			listContent.setChildIndex(lines, listContent.numChildren - 1);

			//lines.graphics.clear();

			var tmpHeight:Number = unscaledHeight - 1; // FIXME: can remove?
			var lineCol:uint;

			//var i:int;

			//var len:uint = (listItems && listItems[0]) ? listItems[0].length : visibleColumns.length;
			// defend against degenerate case when width == 0
			//if (len > visibleColumns.length)
			//len = visibleColumns.length;

			// draw horizontalGridlines if needed.
			lineCol = getStyle("verticalGridLineColor");
			
			
			var index:int = 0;
			var rowIndex:int = 0;
			var colIndex:int=0
			
			//==========================================================
			var endTimer:Date = new Date();
			var endTime:Number = endTimer.getTime();
			//trace("Test01\t=\t", endTime - startTime);
			//==========================================================
			
			mergeColumnsLabel = new Array();
			
			var lineCheckLabel:String	= "";
			var preNumber:int = -1;
			var rowCount:int	= 0;
			rowIndex = verticalScrollPosition;
			
			//for(index=headerVisible ? 1 : 0; index < listItems.length; index++){
			for(index=0; index < listItems.length; index++){
				
				isPreChange = false; // 다음 Row 수행시 초기화 한다.
				
				// DataGrid 한 row의 상태정보를 저장하게된다.
				var rowInfo:Object = new Object();
				
				
				for(colIndex=0; colIndex < visibleColumns.length; colIndex++){
					//칼럼의 존재여부 체크
					if(listItems[index][colIndex]){
						var col:AdvancedDataGridColumn = visibleColumns[colIndex];
						// 현제 칼럼이 커스텀 JHDataGridColumn인지 체크한다.
						// JHDataGridColumn이 아니면 Merge를 수행하지 않는다.
						if( col is ExtensionAdvancedDataGridColumn){
							// 현제 칼럼이 Merge하는지 여부 체크
							if(ExtensionAdvancedDataGridColumn(col).isMergeColumn){
								// 앞 칼럼에서 로우 교체가 일어났는지 체크한다.
								var listData:BaseListData = listItems[index][colIndex].listData;
								if(isPreChange){
									mergeColumnsLabel[colIndex] = listData.label;
									if(isNaN(mergeColumnsCnt[colIndex])){
										var obj:Object = rowsInfoDic[rowIndex.toString()];
										//trace(obj[colIndex.toString()]);
										mergeColumnsCnt[colIndex] = int(obj[colIndex.toString()]);
									}else{
										mergeColumnsCnt[colIndex] += 1; 
									}
								}else{
									if(listData.label != mergeColumnsLabel[colIndex]){
										mergeColumnsLabel[colIndex] = listData.label;
										if(isNaN(mergeColumnsCnt[colIndex])){
											var info:Object = rowsInfoDic[rowIndex.toString()];
											//trace(obj[colIndex.toString()]);
											mergeColumnsCnt[colIndex] = int(info[colIndex.toString()]);
										}else{
											mergeColumnsCnt[colIndex] += 1; 
										}
										isPreChange = true;
									}
								}
								
								/*
								if(colIndex == 0 && isPreChange){
									var firstColumn:int = int(rowsInfoDic[rowIndex.toString()]["0"]);
									trace("============>>>" + firstColumn);
									if(preNumber != firstColumn){
										drawHorizontalLine(lines, index -1, lineCol, this.rowInfo[index -1].y + this.rowInfo[index - 1].height);
									}
									
									//if(index != (headerVisible ? 1 : 0))
									//	drawHorizontalLine(lines, index -1, lineCol, this.rowInfo[index -1].y + this.rowInfo[index - 1].height);
								}
								*/
								
								if(isPreChange){
									//MyRenderer(listItems[index][colIndex]).textVisible = true;
									listItems[index][colIndex].visible = true;
								}else{
									//MyRenderer(listItems[index][colIndex]).textVisible = false;
									listItems[index][colIndex].visible = false;
								}
							}
						}
					}
				}
				
				
				for(var i:int = 0; i < columns.length; i++){
					if(listItems[index][i]){
						var col:AdvancedDataGridColumn = columns[i];
						if(col is ExtensionAdvancedDataGridColumn){
							if(ExtensionAdvancedDataGridColumn(col).isMergeColumn){
								var obj:Object = rowsInfoDic[rowIndex.toString()];
								if(lineCheckLabel != obj["0"]){
									drawHorizontalLine(lines, index -1, lineCol, this.rowInfo[index -1].y + this.rowInfo[index - 1].height);
									lineCheckLabel = obj["0"];
								}
								continue;
							}
						}
					}
				}
				
				for(var i:int = 0; i < mergeColumnsCnt.length; i++){
					if(mergeColumnsCnt[i] is int){
						//trace(i, "-", colors[mergeColumnsCnt[i] % colors.length]);
						if(listItems[index][i]){
							rowInfo[i] = colors[mergeColumnsCnt[i] % colors.length];
							
							drawOneColumnBackground(colBGs, i, index, colors[mergeColumnsCnt[i] % colors.length], columns[i]);
							//listItems[index][i].setStyle("backgroundColor", colors[mergeColumnsCnt[i] % colors.length]);
						}
					}
				}
				//_rowInfoDic[index] = rowInfo;
				/*
				if(dataProvider != null){
					if((rowIndex + index) > dataProvider.length){
						drawHorizontalLine(lines, index -1, lineCol, this.rowInfo[index -1].y + this.rowInfo[index - 1].height);
					}
				}
				*/
				if(rowsInfoDic){
					if(rowsInfoDic[(rowIndex+rowCount).toString()]){
						//if(rowsInfoDic[(rowIndex+rowCount).toString()]["0"]){
							var firstColumn:int = int(rowsInfoDic[(rowIndex+rowCount).toString()]["0"]);
							//trace("============>>>" + firstColumn);
							if(preNumber != firstColumn){
								if(preNumber != -1)
									drawHorizontalLine(lines, index -1, lineCol, this.rowInfo[index].y);
									//drawHorizontalLine(lines, index -1, lineCol, this.rowInfo[index].y + this.rowInfo[index].height);
									
								preNumber = firstColumn;
							}
						//}
					}
				}
				rowCount++;
			}
		}
		
		/**
		 * 머지한 칼럼의 백그라운드를 칠한다.
		 * 
		 * @param s
		 * @param columnIndex
		 * @param rowIndex
		 * @param color
		 * @param column
		 * 
		 */		
		protected function drawOneColumnBackground(s:Sprite, columnIndex:int, rowIndex:int, 
		                                color:uint, column:AdvancedDataGridColumn):void
		{
			//trace("drawOneColumnBackground");
			var background:Shape;
			background = Shape(s.getChildByName(columnIndex.toString() + rowIndex.toString()));
			if (!background)
			{
				background = new FlexShape();
				s.addChild(background);
				background.name = columnIndex.toString() + rowIndex.toString();
			}
			background.visible = true;
			var g:Graphics = background.graphics;
			g.clear();
			g.beginFill(color);
			
			var lastRow:Object = rowInfo[listItems.length - 1];
			var xx:Number = listItems[rowIndex][columnIndex].x
			var yy:Number = rowInfo[rowIndex].y
			//if (headerVisible)
			//	yy += rowInfo[0].height;
			
			// Height is usually as tall is the items in the row, but not if
			// it would extend below the bottom of listContent
			var height:Number = Math.min(lastRow.y + lastRow.height,
			                         listContent.height - yy);
			
			g.drawRect(xx, yy, listItems[rowIndex][columnIndex].width,
			       listItems[rowIndex][columnIndex].height);
			g.endFill();
		}
		
	}
}