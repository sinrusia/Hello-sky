package com.wemb.tobit.components.menu
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.effects.Move;

	[Event(name="menuClick", type="com.wemb.tobit.events.MenuEvent")];
	public class LeftMenu extends UIComponent
	{
		/*
		[Embed("/assets/menu/frameLeft.png")]
		[Bindable]private var leftImg:Class
		*/
		private var leftbg:DisplayObject;
		
		private var menu:Menu;
		
		private var _menuList:ArrayCollection;
		
		private var _title:String;
		
		//메뉴를 고정할 것인지 설정, 고정이면 마우스 이벤트가 처리되지 않는다.
		public var isFixed:Boolean = false;
		
		// 처음 로딩시 메뉴를 보일것인지 설정이다.
		private var _isView:Boolean = false;
		
		public function LeftMenu()
		{
			super();
		}
		
		public function set isView(value:Boolean):void{
			_isView = value;
			invalidateDisplayList();
		}
		
		public function get isView():Boolean{
			return _isView;
		}
		
		public function set menuList(value:ArrayCollection):void{
			_menuList = value;
			
			invalidateProperties();
			invalidateSize();
		}
		
		public function get menuList():ArrayCollection{
			return _menuList;
		}
		
		public function set title(value:String):void{
			_title = value;
			invalidateProperties();
		}
		
		public function get title():String{
			return _title;
		}
		
		private var showState:Boolean = false;
		
		private var moveEffect:Move;
			
		public function showMenu():void
		{
			if( !showState )
			{
				moveEffect.end();
				showState = true;
				moveEffect.target = menu;
				moveEffect.xFrom = -(menu.width - 7);
				moveEffect.xTo = 9;
				moveEffect.play();
				Application.application.addEventListener(MouseEvent.MOUSE_MOVE,isPoint);
				menu.mode = "open";
			}
		}
		
		public function closeMenu():void
		{
			if( !moveEffect.isPlaying && showState )
			{
				moveEffect.end();
				showState = false;
				moveEffect.target = menu;
				moveEffect.xFrom = 9;
				moveEffect.xTo = -(menu.width - 7);
				moveEffect.play();
				Application.application.removeEventListener(MouseEvent.MOUSE_MOVE,isPoint);
				menu.mode = "close";
			}
		}
		
		public function isPoint(e:Event):void
		{
			// 마우스 포인터 마다 이동하게 되어 있는데 설정이 홀딩이면 
			// 처리를 안하도록 한다.
			if( !isFixed )
			{
				if( e.target.mouseX > menu.width )
					closeMenu();
			}
			
		}
		
		
		override protected function createChildren():void
		{
			menu = new Menu();

			if( _menuList )
				menu.dataProvider = _menuList;
			
			menu.addEventListener("tabClick", clickHandler)
			addChild(menu);
			
			/*
			leftbg = DisplayObject(mx.core.IFlexDisplayObject(new leftImg()));
			addChild(leftbg);
			*/
			
			moveEffect = new Move();
			moveEffect.duration = 300;
		}
		
		override protected function commitProperties():void
		{
			if( _menuList )
				menu.dataProvider = _menuList;
			
			menu.title = title;
		}
		
		override protected function measure():void
		{
			measuredHeight = getExplicitOrMeasuredHeight();
			measuredWidth = getExplicitOrMeasuredWidth();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			menu.setActualSize(menu.getExplicitOrMeasuredWidth(), menu.getExplicitOrMeasuredHeight());
			//menu.width = 200;
			//menu.height = 300;
			
			if( isView )
			{
				menu.x = 9;
			}
			else
			{
				menu.x = - (menu.width - 7);
			}
			
		}
		
		private function clickHandler(event:Event):void
		{
			if( menu.mode == "close" )
			{
				showMenu();
			}
			else
			{
				closeMenu();
			}
		}
	}
}