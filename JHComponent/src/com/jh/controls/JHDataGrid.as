// ActionScript file
package com.jh.controls
{
	import mx.controls.DataGrid;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.dataGridClasses.DataGridItemRenderer;
	import mx.core.mx_internal;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFactory;
	import mx.core.FlexSprite;
	import mx.core.UIComponent;
	import mx.core.FlexShape;
	import mx.managers.CursorManager;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import mx.controls.listClasses.ListItemRenderer;
	import com.jh.controls.dataGridClasses.JHDataGridColumn;

	use namespace mx_internal;

	public class JHDataGrid extends DataGrid
	{
		// DataGrid 원판 복사
	    private var resizeCursorID:int = CursorManager.NO_CURSOR;		// resizeCursor ID
	    
		private var resizingColumnNow:DataGridColumn;					// Resize되는 Column
		
		private var ResizeStartX:Number;					// Resize 시작 위치
		
		private var ResizeMinX:Number;						// Resize 최소값
		
	    private var resizeGraphic:IFlexDisplayObject;		// 
		
		/**
	     *  @private
	     *  A hash table of objects used to calculate sizes
	     */
		private var measuringObjects:Dictionary;
		
		
		private var rowsInfoDic:Dictionary;
		
		/**
		 * MyDataGrid에 새로운 데이타가 들어왔을때 각 로우의 색 정보를 체크하는데, 이런한 프로세스를 수행해야할지 여부를 
		 * _dataProviderUpdate의 상태정보로 가지고 있는다.
		 */
		private var _dataProviderUpdate:Boolean = false;
		
		/**
		 *  @private
		 *  Additional affordance given to header separators.
		 */
		private var separatorAffordance:Number = 3;
    
	    private var columnsChange:Boolean = false;
	    
	    public var startTime:Number = 0;
	    
	    private var multiHeadList:Array = new Array();

		public function JHDataGrid():void
		{
			super();
			var timer:Date = new Date();
			startTime = timer.getTime();
		}
		//--------------------------------------------------------------------------------------
		//
		//	Properties
		//
		//--------------------------------------------------------------------------------------
		
		override public function set columns(value:Array):void
		{
			var n:int = 0;
			
			//기존의 멀티헤더가 있으면 삭제하도록 한다.
			for(n = 0; n < columns.length; n++){
				multiColumnRendererChanged(columns[n]);
			}
			
			columnsChange = true;
			
			super.columns = value;
		}
		
		/**
		 * 
		 * @param c DataGridColumn
		 * 
		 */		
		private function multiColumnRendererChanged(c:DataGridColumn):void
		{
			var item:IListItemRenderer;
			
			var factory:IFactory = null;
			
			if(c is JHDataGridColumn){
				if(JHDataGridColumn(c).isMultiHeader)
					factory = JHDataGridColumn(c).mergeHeaderRenderer;
				else
					return;
			}
			else
				factory = columnItemRendererFactory(c,true);
			
			item  = measuringObjects[factory];
			
			if(item){
				listContent.removeChild(DisplayObject(item));
				measuringObjects[factory] = null;
			}
		}
		
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
		
		
		/**
		 * 
		 * @param value
		 * 
		 */		
		override public function set verticalScrollPosition(value:Number):void
		{
			super.verticalScrollPosition = value;
			mergeProcess();
			headerReplace();
			drawHeaderHorizontalLine();
		}
		
		override public function set horizontalScrollPosition(value:Number):void
		{
			super.horizontalScrollPosition = value;
			var timer:Date = new Date();
			startTime = timer.getTime();
			trace(",,,,,,,,,,horizontalScrollPosition");
		}
		
		override public function measureHeightOfItems(index:int=-1.0, count:int=0.0):Number
		{
			return super.measureHeightOfItems(index, count);
			trace(">>>>>>>>>>>>>>>>>measureHeightOfItems");
		}
		
		//--------------------------------------------------------------------------------------
		//
		//	Override Function
		//
		//--------------------------------------------------------------------------------------
		
		/**
		 * 
		 * @param unscaledWidth
		 * @param unscaledHeight
		 * 
		 */		
		override protected function updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void 
		{
			trace(this, "updateDisplayList");
			
			//==========================================================
			var endTimer:Date = new Date();
			var endTime:Number = endTimer.getTime();
			trace("update Start\t=\t", endTime - startTime);
			//==========================================================
			
			
			if(columnsChange){
				columnsChange = false;
				for(var n:int = 0; n < columnCount; n++){
					if(columns[n] is JHDataGridColumn){
						if(JHDataGridColumn(columns[n]).isMultiHeader){
							var minHeaderHeight:Number = JHDataGridColumn(columns[n]).multiHeaderLength * 20 + 20;
							if(this.headerHeight < minHeaderHeight)
								this.headerHeight = minHeaderHeight;
						}
					}
				}
			}
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			createMultiHeaderX();
			mergeProcess();
			headerReplace();
			drawHeaderHorizontalLine();
		}
		
		
	    /**
	     * 
	     * 
	     */		
	    override protected function drawSeparators():void
	    {
			super.drawSeparators();
			
			trace("drawSeparators", "감춰지는 부분을 그린다.");
			
			var lines:Sprite = Sprite(listContent.getChildByName("lines"));
			
			var n:int = visibleColumns.length;
			for (var i:int = 0; i < n; i++)
			{
				var sep:UIComponent;
				var sepSkin:IFlexDisplayObject;
				
				if (i < lines.numChildren)
				{
				    sep = UIComponent(lines.getChildAt(i));
				    sepSkin = IFlexDisplayObject(sep.getChildAt(0));
				}
				else
				{
					throw new Error(this + ".drawSeparators - " + "에러다 우찌할겨");
				}
				
				if (!listItems || !listItems[0] || !listItems[0][i])
				{
				    sep.visible = false;
				    continue;
				}
				
				var multiHeaders:Array = null;
				if(visibleColumns[i] is JHDataGridColumn)
					multiHeaders = JHDataGridColumn(visibleColumns[i]).multiHeader;
				
				var nextHeaders:Array = null;
				if( i+1 < visibleColumns.length){
					if(visibleColumns[i] is JHDataGridColumn)
						nextHeaders = JHDataGridColumn(visibleColumns[i+1]).multiHeader;
				}
				
				var pos_y:int = headerHeight - 20;
				if(visibleColumns[i] is JHDataGridColumn &&
					JHDataGridColumn(visibleColumns[i]).isMultiHeader){
					//각 헤더의 선을 지우는 거 체크하기
					//var minus_value:int = pos_y / JHDataGridColumn(visibleColumns[i]).multiHeaderLength;
					trace("===="+minus_value);
					var minus_value:int = 20;
					
					var isMulti:Boolean = false;
					
					for(var level:int = 0; level < JHDataGridColumn(visibleColumns[i]).multiHeaderLength; level++){
						if(!columnCheck(visibleColumns[i], visibleColumns[i+1], level)){
							pos_y -= minus_value;
						}else{
							isMulti = true;
						}
					}
					
					if(!isMulti)
						continue;
					
					if(pos_y <=0)
						continue;
					else{
					    sep.y = pos_y;	// 시작 위치
					    sepSkin.setActualSize(sepSkin.measuredWidth, headerHeight-pos_y);	// 길이
					}
				}
				else
				{
					continue;
				}
				
				// Draw invisible background for separator affordance
				sep.graphics.clear();
				sep.graphics.beginFill(0xFFFFFF, 0);
				sep.graphics.drawRect(-separatorAffordance, 0, sepSkin.measuredWidth + separatorAffordance , headerHeight);
				sep.graphics.endFill();
			}
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
							var col:DataGridColumn = columns[colIndex];
							if( col is JHDataGridColumn){
								if(JHDataGridColumn(col).isMergeColumn){
									if(isPreChange){
										mergeColumnsLabel[colIndex] = dataProvider[index][JHDataGridColumn(col).dataField];
										if(isNaN(mergeColumnsCnt[colIndex])){
											mergeColumnsCnt[colIndex] = 0;
										}else{
											mergeColumnsCnt[colIndex] += 1; 
										}
									}else{
										dataProvider[index][JHDataGridColumn(col).dataField];
										mergeColumnsLabel[colIndex];
										if(dataProvider[index][JHDataGridColumn(col).dataField] != mergeColumnsLabel[colIndex]){
											mergeColumnsLabel[colIndex] = dataProvider[index][JHDataGridColumn(col).dataField];
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
		
		
	    /**
	     * Multi Header를 그릴때 상단 버튼 위로 Line 그려지는것믈 막기위해 상속
	     * 
	     * @param s
	     * @param colIndex
	     * @param color
	     * @param x
	     * 
	     */
	    override protected function drawVerticalLine(s:Sprite, colIndex:int, color:uint, x:Number):void
	    {
	        //draw our vertical lines
	        var g:Graphics = s.graphics;
	        if (lockedColumnCount > 0 && colIndex == lockedColumnCount - 1)
	            g.lineStyle(1, 0, 100);
	        else
	            g.lineStyle(1, color, 100);
//	        g.moveTo(x, 1);
	        g.moveTo(x, headerHeight);
	        g.lineTo(x, listContent.height);
	    }
	    
		/**
		 * Sort Arrow가 그려지는 것을 막음
		 * 
		 */
		override protected function placeSortArrow():void{
			super.placeSortArrow();
		}
		
		private function createMultiHeaderX():void{
			if(!measuringObjects)
				measuringObjects = new Dictionary(false);
			
			var count:Number = visibleColumns.length;
			
			//헤더의 위치값
			var comp_x:int	= 0;
			
			var preColumn:JHDataGridColumn	= null;
			
			//기존 해더들을 오비이게한다.
			for(var j:int = 0; j < multiHeadList.length; j++){
				multiHeadList[j].visible = false;
			}
			
			//멀티헤더 리스트 초기화
			multiHeadList = new Array();
			
			for(var i:int = 0; i < count; i++){
				var item:IListItemRenderer		= null;
				var rowData:DataGridListData	= null;
				
				var c:DataGridColumn = visibleColumns[i];
				
				// JHDataGridColumn이 아니면 수행하지 않는다.
				if(!(c is JHDataGridColumn))
					continue;
				
				if (JHDataGridColumn(c).isMultiHeader){
					// 멀티헤더 컴포넌트 처리를 시작한다.
					for(var level:int = JHDataGridColumn(c).multiHeaderLength - 1; level >= 0; level--){
						var comp_Width:int = c.width;
						var headLabel:String = JHDataGridColumn(c).getHeaderLabel(level);
						
						//헤더 컴포넌트의 가로길이를 정의 한다.
					    for(var j:int = i+1; j < count; j++)
						{
							var nextColum:DataGridColumn = visibleColumns[j];
							if(!nextColum is JHDataGridColumn)
								break;
							
							if(JHDataGridColumn(nextColum).isMultiHeader){
								var nextLabel:String = JHDataGridColumn(nextColum).getHeaderLabel(level);
								if(headLabel == nextLabel){
									comp_Width += nextColum.width;
									continue;
								}else{
									break;
								}
							}
							else
								break;
						}
						
						if ( !columnCheck(preColumn, c as JHDataGridColumn, level)){
							item	= getHeaderItem(false, c, level);
							rowData	= DataGridListData(makeListData(c, uid, 0, c.colNum, c));
							rowMap[item.name]	= rowData;
							rowData.label		=  headLabel;
							item.styleName		= this.getStyle("headerStyleName");
							
							if(headLabel == "Main System"){
								item.styleName = "myHeader";
							}
							
							if (item is IDropInListItemRenderer)
								IDropInListItemRenderer(item).listData = rowData;
							
							item.data = c;
							item.visible = true;
							
							//m_arMHbutton[i] = item;
							
							//var comp_y:Number = 20 * (level -1);
							var comp_y:Number = headerHeight - (20 * (level + 2));
							//헤더개수만큼 N분해서 높이 구하기
							// var headerThumHeight:Number = (headerHeight - 20) / JHDataGridColumn(c).multiHeaderLength;
							// (JHDataGridColumn(c).multiHeaderLength - (level + 1)) * headerThumHeight;
							
							drawMultiHeader(item, comp_y, comp_x, comp_Width);
							
							multiHeadList.push(item);
						}else{
							var factory:IFactory = null;
							
							if(c is JHDataGridColumn)
								factory = JHDataGridColumn(c).mergeHeaderRenderer;
							else
								factory = columnItemRendererFactory(c,true);
							
							item  = measuringObjects[factory];
							
							/*
							if(item){
								item.visible = false;
								listContent.removeChild(DisplayObject(item));
								measuringObjects[factory] = null;
								item = null;
							}
							*/
						}
					}
				}
				
				preColumn	= c as JHDataGridColumn;
				//다음 헤더 칼럼의 위치를  계산한다.
				comp_x += c.width;
			}
		}
		
		private function columnCheck(preC:JHDataGridColumn, nextC:JHDataGridColumn, level:int):Boolean
		{
			if(preC == null || nextC == null)
				return false;
			var preLabel:String		= preC.getHeaderLabel(level);
			var nextLabel:String	= nextC.getHeaderLabel(level);
			if(preLabel == nextLabel)
				return true;
			return false;
		}
		
		/**
		 * 
		 * @param forHeader
		 * @param c
		 * @return 
		 * 
		 */		
		private function getHeaderItem(forHeader:Boolean, c:DataGridColumn, level:int = -1):IListItemRenderer
		{
			var factory:IFactory = null;
			if(!forHeader){
				if(c is JHDataGridColumn){
					factory = JHDataGridColumn(c).getHeaderRenderer(level);
				}
			}else{
				factory = columnItemRendererFactory(c,forHeader);
			}
			trace(factory);
			var item:IListItemRenderer  = measuringObjects[factory];
			if (!item)
			{
				item = columnItemRenderer(c, true);
				item.visible = false;
				item.styleName = c;
				listContent.addChild(DisplayObject(item));
				measuringObjects[factory] = item;
			}
			return item;
		}

		/**
		 * Resize 시 Header에 있는 버튼 크기를 조절
		 * 
		 * 사용하지 않는 함수.. 필요 없으실 삭제할것.
		 * 
		 * @param eventObj
		 * 
		 */
		/*
		private function OnmyResize(eventObj:Event = null):void 
		{
			trace("OnmyResize");
			
			var posX:Number = 0;
			
			var c:DataGridColumn	= null;
			
			var preColumn:String	= "";
			
			for(var i:int = 0; i < visibleColumns.length; i++)
			{
    			var item:IListItemRenderer		= null;
	            var rowData:DataGridListData	= null;
				
				c = visibleColumns[i];
				
				// JHDataGridColumn이 아니면 수행하지 않는다.
				if(!(c is JHDataGridColumn)){
					posX += this.columns[i].width;
					continue;
				}
				
	    		if (JHDataGridColumn(c).isMultiHeader)
	    		{
					var posMX:Number = this.columns[i].width;
					
			        for (var j:int = i+1; j < visibleColumns.length; j++)
			    	{
			    		if(visibleColumns[j] is JHDataGridColumn){
			    			if(JHDataGridColumn(visibleColumns[j]).isMultiHeader){
					    		if ( JHDataGridColumn(c).multiHeader == 
					    			JHDataGridColumn(visibleColumns[j]).multiHeader )
					    		{
					    			posMX += this.columns[j].width + 1;
					    			continue;
					    		}
					    		else
					    			break;
			    			}
			    			else
			    				break;
			    		}
			    		else
			    			break;
		    		}
		    		
		    		if ( preColumn != JHDataGridColumn(c).multiHeader)
		    		{
		    			item		= getHeaderItem(false, c);
						item.x		= posX;
						item.width	= posMX;
		    		}
		    	}
		    	posX += this.columns[i].width;
		    	
		    	preColumn = JHDataGridColumn(c).multiHeader;
			}
		}
		*/
	    
		/**
		 * 
		 * @param _button
		 * @param i
		 * @param posX
		 * 
		 */	    
		private function drawSHButton(_button:IListItemRenderer, i:int, posX:int):void
		{
			trace("drawSHButton");
			_button.x = posX;
			_button.y = 00;
			_button.width = this.columns[i].width+1;
			_button.alpha = 1;
			_button.height = this.headerHeight-1;
			_button.visible = true;

			//listContent.addChild(DisplayObject(_button));

	        var sortArrowHitArea:Sprite =
	            Sprite(listContent.getChildByName("sortArrowHitArea"));

			if ( sortArrowHitArea != null )
				listContent.setChildIndex(DisplayObject(_button), listContent.getChildIndex(sortArrowHitArea)-1);
		}
		
		
		/**
		 * 
		 * @param _button
		 * @param i
		 * @param posX
		 * @param posMX
		 * 
		 */		
		private function drawMultiHeader(item:IListItemRenderer, posY:int, posX:int, posMX:int):void
		{
			trace("drawMultiHeader-","X좌표=", posX,", Y좌표=",posY,", 가로길이=", posMX);
			item.x			= posX;
			item.y			= posY;
			item.width		= posMX;
			item.alpha		= 1;
			item.height		= 20;
			item.visible	= true;
			
			//listContent.addChild(DisplayObject(_button));

	        var sortArrowHitArea:Sprite =
	            Sprite(listContent.getChildByName("sortArrowHitArea"));

			if ( sortArrowHitArea != null )
				listContent.setChildIndex(DisplayObject(item), listContent.getChildIndex(sortArrowHitArea)-1);
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
			
			for(index=headerVisible ? 1 : 0; index < listItems.length; index++){
				
				isPreChange = false; // 다음 Row 수행시 초기화 한다.
				
				// DataGrid 한 row의 상태정보를 저장하게된다.
				var rowInfo:Object = new Object();
				
				
				for(colIndex=0; colIndex < visibleColumns.length; colIndex++){
					//칼럼의 존재여부 체크
					if(listItems[index][colIndex]){
						var col:DataGridColumn = visibleColumns[colIndex];
						// 현제 칼럼이 커스텀 JHDataGridColumn인지 체크한다.
						// JHDataGridColumn이 아니면 Merge를 수행하지 않는다.
						if( col is JHDataGridColumn){
							// 현제 칼럼이 Merge하는지 여부 체크
							if(JHDataGridColumn(col).isMergeColumn){
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
						var col:DataGridColumn = columns[i];
						if(col is JHDataGridColumn){
							if(JHDataGridColumn(col).isMergeColumn){
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
							trace("============>>>" + firstColumn);
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
		 * 멀티헤더에 맞춰서 수직 라인을 다시 그리도록 한다.
		 * 
		 */
		protected function drawHeaderHorizontalLine():void{
			// Line Graphics
			var lines:Sprite = Sprite(listContent.getChildByName("lines"));
			if (!lines){
				lines = new UIComponent();
				lines.name = "lines";
				lines.cacheAsBitmap = true;
				lines.mouseEnabled = false;
				listContent.addChild(lines);
			}
			
			listContent.setChildIndex(lines, listContent.numChildren - 1);
			
			var columnPosition_X:Number		= 0;	// 칼럼의 X좌표
			var preColumn:DataGridColumn	= null;
			var count:int					= visibleColumns.length;

			for (var i:int = 0; i < visibleColumns.length; i++){
				var multiHeaders:Array = null;
				if(visibleColumns[i] is JHDataGridColumn)
					multiHeaders = JHDataGridColumn(visibleColumns[i]).multiHeader;
				else
					multiHeaders = new Array();
					
				if ( multiHeaders != null && multiHeaders.length > 0){
					for(var level:int = multiHeaders.length - 1; level >= 0; level--){
						var columnWidth:Number = this.visibleColumns[i].width;
				        for (var j:int = i+1; j < count; j++){
				        	
				    		if ( columnCheck(visibleColumns[i], visibleColumns[j], level)){
					    		columnWidth += this.visibleColumns[j].width;
				    			continue;
				    		}else
				    			break;
						}
						
						var pos_y:Number = headerHeight - (20 * (level+1))
						
						if (!columnCheck( preColumn as JHDataGridColumn, visibleColumns[i] as JHDataGridColumn, level))
						{
							trace(i, " = ",columnWidth);
							//라인그리기
					        var color:uint = getStyle("verticalGridLineColor");
					        var g:Graphics = lines.graphics;
					        g.lineStyle(1, color);
					        g.moveTo(columnPosition_X, pos_y);
					        g.lineTo(columnPosition_X + columnWidth, pos_y);
						}
						
					}
				}
				
				preColumn = visibleColumns[i];
				columnPosition_X += this.visibleColumns[i].width;
			}
		}
		
		
		/**
		 * listItems에서 첫번째 컴포넌트 리스트를 빼온다.(헤더 아이템 컨트럴들)
		 * 각 헤더 아이템을 체크하면서 멀티해더 부모를 가지는 헤더의 높이와 위치를 조절하도록 한다.
		 * 
		 */		
		protected function headerReplace():void
		{
			if(listItems[0] != null){
				var headList:Array = listItems[0];
				for(var n:int = 0; n < headList.length; n++){
					// 헤더 아이템 랜더러
					var item:DataGridItemRenderer = headList[n];
					// 헤더의 DataGridColumn정보 
					var c:DataGridColumn = item.data as DataGridColumn;
					if(c is JHDataGridColumn){
						// multiHeader를 가지고 있을경우 컴포넌트의 속성을 조절하도록 한다.
						if(JHDataGridColumn(c).isMultiHeader){
							item.height = 20;
							item.y = headerHeight - 20;
						}
					}
				}
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
		                                color:uint, column:DataGridColumn):void
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
		
	    override protected function mouseOverHandler(event:MouseEvent):void{
	    	super.mouseOverHandler(event);
	    }
	    
	    override protected function mouseDownHandler(event:MouseEvent):void{
	    	try{
	    		super.mouseDownHandler(event);
	    	}catch(err:Error){
	    		trace(err.getStackTrace());
	    	}
	    }
	}
}