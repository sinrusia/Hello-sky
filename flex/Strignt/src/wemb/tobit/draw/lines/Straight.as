package wemb.tobit.draw.lines
{
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.managers.ToolTipManager;
	
	import wemb.tobit.draw.helper.Handle;
	import wemb.tobit.vo.PropertyData;

	
	public class Straight extends UIComponent 
	{
		import mx.binding.utils.*;
        import mx.events.FlexEvent;
		
		public var start:Handle = null;
		public var end:Handle = null;
		private var isMove:Boolean = false;
		private var thisCM:ContextMenu;
		
		private var _to_name:String="LineName"; // sid(name)
		
		private var _to_startX:Number = 0;	
		private var _to_startY:Number = 0;	
		
		private var _to_endX:Number = 300;
		private var _to_endY:Number= 300;
		private var _to_thick:Number = 2;
		private var _to_color:Number=0xffffff;
		private var _to_visible:Boolean = true;
		private var _to_stype:String = "toLine";
		
		private var _to_severity:String = "Normal";
		
		private var _to_hostName:String = ""; // Line Name(hostName)
		
		private var _to_label:String = ""; // Line Label(text)
		
		private var _NormalColor:Number = 0xffffff; //to_color 의 값을 저장 default->0xffffff
		
		private var _CriticalColor:Number = 0xff0000; // Critical Color -> 0xff0000
		
			
		public var properties:ArrayCollection;	//속성값.
		
		
		private var severityTimer:Timer;
		
		private var _interval:Number = 300;
		
		private var _isToggle:Boolean = false;
		
		private var bindWacher0:ChangeWatcher = BindingUtils.bindSetter( 
														function():void
														{
														}, this, "x");
		
		public function setHandleVisible(val:Boolean):void 
		{
			this.buttonMode = val; //편집 모드일때  Button Mode true 이기윤 추가...2007.12.7
			to_visible = val;
           
           	if((start != null) && (end != null))
	        	start.visible = end.visible = to_visible;
	       	
	       	if ( to_visible )
	       	{
				if(_to_label != null)
				{
					ToolTipManager.enabled = false;
				}	
				    		
	       		severityLine(_NormalColor);
	       		stopTimer();
	       		
	       		thisCM = new ContextMenu();
	       		thisCM.hideBuiltInItems();
				
				var dl:ContextMenuItem = new ContextMenuItem("삭제..." );
				dl.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Application.application.delHandler);
				thisCM.customItems.push(dl);
				
				this.contextMenu = thisCM;
	       	}
	       	else
	       	{
	       		if(_to_label != null)
				{
					ToolTipManager.enabled = true;
				}	
	       		
	       		thisCM = null;
	       	}
        }
        
        private function initTimer():void
        {
        	severityTimer = new Timer(_interval);
        	severityTimer.addEventListener(TimerEvent.TIMER, onTimer);
        }
        
        /** 싱글턴, 장애 효과 타이머 **/
        private function onTimer(e:TimerEvent):void
        {
        	stopTimer();
        	//trace("Timer~~ " + _to_severity);
        	var changeColor:Number = _NormalColor;
        	// toggle color
        	if(_isToggle)
        	{
        		changeColor = _NormalColor;
        		_isToggle = false;
        	}
        	else
        	{
        		changeColor = _CriticalColor;
        		_isToggle = true;
        	}
        	severityLine(changeColor);
        	if(_to_visible == false)
        		startTimer();
        }
        
        public function stopTimer():void
        {
        	if(severityTimer)
        		severityTimer.stop();
        }
        
        public function startTimer():void
        {
        	if(severityTimer)
        		severityTimer.start();
        }
		
		//name:String,startX:Number, startY:Number, endX:Number, endY:Number, thick:Number, color:Number, visible:Boolean
		public function Straight()
		{
			ToolTipManager.enabled = false;
			if(_to_label != null)
			{
				toolTip = _to_label;
				ToolTipManager.enabled = true;
			}
			initTimer();
			
			this.buttonMode = true;
			
			initUI(_to_startX, _to_startY, _to_endX, _to_endY, _to_thick, _to_color, _to_visible);
		}
		
		
		public function severityLine(sev_color:Number):void 
		{				
			if(start == null)
				return;
				
			//trace("drawLine >> ", start.x, start.y, end.x, end.y,  _to_thick, sev_color, 1 );
			with( graphics ) 
			{				
				clear();
				lineStyle( _to_thick, sev_color, 1 );
				moveTo( start.x, start.y );
				lineTo( end.x, end.y );
			}
		}
		
		public function reDraw():void
		{
			trace("reDraw", to_startX, ",", to_startY);
			start.x = to_startX;
			start.y = to_startY;			
			
			end.x = to_endX;
			end.y = to_endY;			
			//trace("reDraw()!!");
			drawLine();			
		}
			
		public function initUI( startX:Number, 
								startY:Number, 
								endX:Number, 
								endY:Number, 
								thick:Number, 
								color:Number, 
								visible:Boolean ):void 
		{
			_to_thick = thick;
			
			_to_color = color;
			_to_visible = visible;
			
			start = new Handle(Handle.CIRCLE );
			start.x = startX;
			start.y = startY;
			
			start.addEventListener( MouseEvent.MOUSE_UP, doMouseUp );
			start.addEventListener( MouseEvent.MOUSE_MOVE, doMouseMove );
			start.addEventListener( MouseEvent.MOUSE_DOWN, doMouseDown );
			
			addChild( start );
			
			end = new Handle(Handle.CIRCLE );
			end.x = endX;
			end.y = endY;
			
			end.addEventListener( MouseEvent.MOUSE_UP, doMouseUp );
			end.addEventListener( MouseEvent.MOUSE_MOVE, doMouseMove );
			end.addEventListener( MouseEvent.MOUSE_DOWN, doMouseDown );
			addChild( end );
			
			drawLine();
			
			this.addEventListener( MouseEvent.MOUSE_UP, doMouseUp );
			this.addEventListener( MouseEvent.MOUSE_DOWN, doMouseDown );

			start.visible = end.visible = _to_visible;
		}

		public function drawLine():void 
		{	
			//trace("drawLine >> ", start.x, start.y, end.x, end.y,  _to_thick, _to_color, 1 );
			trace("drawLine", start.x);
			with( graphics ) 
			{				
				clear();
				lineStyle( _to_thick, _to_color, 1 );
				moveTo( start.x, start.y );
				lineTo( end.x, end.y );
				
				settingPropertyData();
				
				this.width = Math.abs(end.x - start.x);
				this.height = Math.abs(end.y - start.y);
			}
		}
		
		private function settingPropertyData():void
		{
			trace(start.x," = ",start.y);
			var myP:Point = this.localToGlobal(new Point(start.x, start.y));
			trace(myP.x," = ",myP.y);
			
			
			PropertyData.getInstance().startX = myP.x;
			PropertyData.getInstance().startY = myP.y;
			
			myP = this.localToGlobal(new Point(end.x, end.y));
			
			PropertyData.getInstance().endX = myP.x;
			PropertyData.getInstance().endY = myP.y;
			
			PropertyData.getInstance().x = this.x;
			PropertyData.getInstance().y = this.y;
		}
		
		private var offSetX:Number;
		private var offSetY:Number;
		
		public function doMouseDown( event:MouseEvent ):void
		{	
			if( event.target is Handle ) isMove = true;
			else
			{
				this.startDrag();
				
				offSetX = event.stageX - start.x;
				offSetY = event.stageY - start.y;
				
				this.addEventListener(MouseEvent.MOUSE_MOVE, draggingEvent);
			} 
		}		
		
		public function doMouseMove( event:MouseEvent ):void
		{
			if ( isMove ) 
			{
				this.addEventListener(Event.ENTER_FRAME, doEnterFrame);
			}
			//drawLine();
			event.updateAfterEvent();
		}
		
		private function doEnterFrame(event:Event):void
		{
			drawLine();
		}
		
		/**
		 * To. 재학 형님
		 * 선 드래그 이벤트
		 * 선 시작과 끝에 Handler 객체가 붙어 있는데,
		 * 좌표값처리가 잘 안됨,,, 봐주세욤  ㅜ_ㅜ
		 */
		private function draggingEvent(e:MouseEvent):void
		{
			/*
			start.x = e.stageX - offSetX;
			start.y = e.stageY - offSetY;
			*/
			//trace("stageX: " + e.stageX + ", " + e.stageY);
			trace("xy: " + x + ", " + y);
			//trace("xy: " + x + ", " + y);
			//var pp:Point = this.localToGlobal(new Point(x, y));
			//var pp:Point = new Point(x, y);
			
			//start.x = pp.x/2;
			//start.y = pp.y/2;
			//start.x = pp.x/2;
			//start.y = pp.y/2;
			
			trace(e.stageX);
			
			PropertyData.getInstance().stageX = e.stageX;
			PropertyData.getInstance().stageY = e.stageY;
			
			settingPropertyData();
			
			e.updateAfterEvent();
		}
		
		public function doMouseUp( event:MouseEvent ):void
		{
			if( isMove )
			{
				this.removeEventListener(Event.ENTER_FRAME, doEnterFrame);
				isMove = false;
				drawLine();
				event.updateAfterEvent();
			}
			else
			{
				this.stopDrag();
				
				this.removeEventListener(MouseEvent.MOUSE_MOVE, draggingEvent);
				
			}
		}
		
		
		
		/** GET SET Method **/
		
		public function get startX():Number { return start.x; }
		
		public function get startY():Number { return start.y; }
		
		public function get endX():Number { return end.x; }
		
		public function get endY():Number { return end.y; }
		
		public function get thick():Number { return _to_thick; }
		
		public function get color():Number { return _to_color; }
		
		
		public function set to_name(value:String):void
		{
			_to_name = value;
		}
		
		public function get to_name():String
		{
			return _to_name;
		}
				
		public function set to_startX(value:Number):void
		{
			//trace("set to_startX : " + value);
			_to_startX = value;
		}
		
		public function get to_startX():Number
		{
			return _to_startX;
		}
		
				
		public function set to_startY(value:Number):void
		{
			_to_startY = value;
		}
		
		public function get to_startY():Number
		{
			return _to_startY;
		}
		
		public function set to_endX(value:Number):void
		{
			_to_endX = value;
		}
		
		public function get to_endX():Number
		{
			return _to_endX;
		}
				
		public function set to_endY(value:Number):void
		{
			_to_endY = value;
		}
		
		public function get to_endY():Number
		{
			return _to_endY;
		}
				
		public function set to_thick(value:Number):void
		{
			_to_thick = value;
		}
		
		public function get to_thick():Number
		{
			return _to_thick;
		}
		
		public function set to_color(value:Number):void
		{
			_NormalColor = value;
			_to_color = value;
		}
		
		public function get to_color():Number
		{
			return _to_color;
		}
		
		public function set to_visible(value:Boolean):void
		{
			_to_visible = value;
		}
		
		public function get to_visible():Boolean
		{
			return _to_visible;
		}
		
		//severity 표현 추가 2008.04.04 이기윤
		public function set severity(value:String):void
		{
			_to_severity = value;

			if( value == "Critical" ) startTimer();	
			else stopTimer();
		}
		
		public function get severity():String
		{
			return _to_severity;
		}
		
		// host name
		public function set to_hostName(value:String):void
		{
			_to_hostName = value;
		}
		
		public function get to_hostName():String
		{
			return _to_hostName;
		}	
		
		// host label
		public function set to_label(value:String):void
		{
			if(value != null)
			{
				toolTip = "" + value;
				ToolTipManager.enabled = true;
			}
			else
				ToolTipManager.enabled = false;
			
			_to_label = value;
		}
		
		public function get to_label():String
		{
			return _to_label;
		}
		
	}
}