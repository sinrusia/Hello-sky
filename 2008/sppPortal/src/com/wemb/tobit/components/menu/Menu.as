package com.wemb.tobit.components.menu
{
	import com.wemb.tobit.pure.ApplicationFacade;
	import com.wemb.tobit.pure.Constants;
	import com.wemb.tobit.vo.PageInfo;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.HRule;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.controls.Tree;
	import mx.core.UIComponent;
	import mx.events.ListEvent;

	public class Menu extends UIComponent
	{
		//메뉴 바탕 이미지
		[Embed("/assets/menu/Lmenu_bg.png")]
		[Bindable]private var bg_img:Class;
		
		//메뉴 버튼 
		[Embed("/assets/menu/Lmenu_open.png")]
		[Bindable]private var btnOpen:Class;
		
		[Embed("/assets/menu/Lmenu_close.png")]
		[Bindable]private var btnClose:Class;
		
		private var _bg:DisplayObject;
		
		private var _btnOpen:Image;
		
		private var _btnClose:Image;
		
		private var _tree:Tree;
		
		private var _dataProvider:ArrayCollection;
		
		private var menuTitle:Label;
		
		private var _title:String;
		
		private var _mode:String = "close"; //close, open
		
		private var _isDataChange:Boolean = false;
		
		private var hline:HRule;
		
		public function Menu()
		{
			super();
		}
		
		public function set dataProvider(value:ArrayCollection):void{
			_dataProvider = value;
			_isDataChange = true;
			invalidateProperties();
		}
		
		public function get dataProvider():ArrayCollection{
			return _dataProvider;
		}
		
		public function set title(value:String):void{
			_title = value;
			invalidateProperties();
		}
		
		public function get title():String{
			return _title;
		}
		
		public function set mode(value:String):void{
			_mode = value;
			invalidateProperties();
		}
		
		public function get mode():String{
			return _mode;
		}
		
		
		override protected function createChildren():void{
			super.createChildren();
			
			_bg = DisplayObject(mx.core.IFlexDisplayObject(new bg_img()));
			addChild(_bg);
			
			_btnOpen = new Image();
			_btnOpen.source = btnOpen;
			_btnOpen.buttonMode = true;
			_btnOpen.useHandCursor = true;
			_btnOpen.mouseChildren = false;
			_btnOpen.addEventListener(MouseEvent.CLICK, showHandler);
			addChild(_btnOpen);
			
			
			_btnClose = new Image();
			_btnClose.source = btnClose;
			_btnClose.buttonMode = true;
			_btnClose.useHandCursor = true;
			_btnClose.mouseChildren = false;
			_btnClose.addEventListener(MouseEvent.CLICK, closeHandler);
			addChild(_btnClose);
			
			_tree = new Tree();
			_tree.showRoot = false;
			_tree.labelField = "name";
			_tree.styleName = "treeStyle";
			_tree.setStyle("backgroundAlpha", 0);
			_tree.setStyle("borderStyle", "none");
			_tree.setStyle("fontFamily","Yoon 윤고딕 530_TT");
			_tree.setStyle("fontSize",12);
			_tree.setStyle("fontWeight", "bold");
			_tree.setStyle("color", "#ffffff");
			_tree.setStyle("selectionColor", "#6387c3");
			_tree.setStyle("rollOverColor", "#88a4d1");
			
			//menu.addEventListener(TreeEvent.ITEM_OPEN, openHandler);
			//menu.addEventListener(TreeEvent.ITEM_CLOSE, openHandler);
			_tree.addEventListener(ListEvent.ITEM_CLICK, itemClickHandler);
			addChild(_tree);
			
			menuTitle =  new Label();
			menuTitle.setStyle("fontFamily","Yoon 윤고딕 530_TT");
			menuTitle.setStyle("fontSize",15);
			menuTitle.setStyle("fontWeight", "bold");
			menuTitle.setStyle("color", "#6ff0ff");
			addChild(menuTitle);
			
			hline = new HRule();
			hline.height = 1;
			addChild(hline);
			
		}
		
		override protected function commitProperties():void{
			super.commitProperties();
			
			if(_isDataChange){
				_isDataChange = false;
				_tree.dataProvider = _dataProvider;
			}
			
			menuTitle.text = title;
			
			if(_mode == "close"){
				_btnClose.visible = false;
				_btnOpen.visible = true;
			}else{
				_btnClose.visible = true;
				_btnOpen.visible = false;
			}
		}
		
		override protected function measure():void{
			measuredWidth = _bg.width;
			measuredHeight = _bg.height;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			_tree.width = _bg.width - 30;
			_tree.height = _bg.height - 100;
			
			_tree.x = 10;
			_tree.y = 70;
			
			hline.x = 15;
			hline.y = _tree.y + _tree.height + 1;
			hline.width = _tree.width;
			hline.height = 1;
			
			_btnClose.x = 234;
			_btnClose.y = 18;
			
			_btnClose.setActualSize(
				_btnClose.getExplicitOrMeasuredWidth(),
				_btnClose.getExplicitOrMeasuredHeight());
			
			_btnOpen.x = 234;
			_btnOpen.y = 18;
			
			_btnOpen.setActualSize(
				_btnOpen.getExplicitOrMeasuredWidth(),
				_btnOpen.getExplicitOrMeasuredHeight());
			
			menuTitle.setActualSize(menuTitle.getExplicitOrMeasuredWidth(), 
				menuTitle.getExplicitOrMeasuredHeight());
			
			if(menuTitle){
				menuTitle.x = 30;
				menuTitle.y	= 17;
			}
		}
		
		private function closeHandler(event:MouseEvent):void{
			dispatchEvent(new Event("tabClick"));
		}
		
		private function showHandler(event:MouseEvent):void{
			dispatchEvent(new Event("tabClick"));
		}
		
		/**
		 * 	관리모드의 left Menu item 클릭시 notification 발생 
		 * 
		 */
		private function itemClickHandler(event:ListEvent):void{
			var facade:ApplicationFacade = ApplicationFacade.getInstance();
			if(_tree.selectedItem){
				var info:PageInfo = new PageInfo();
				info.mainPageId	= _tree.selectedItem.pageID;
				info.subPageId	= _tree.selectedItem.subID;
				info.pageClass	= _tree.selectedItem.pageClass;
				facade.sendNotification(Constants.PAGE_CHANGE, info);
			}
		}
		
	}
}