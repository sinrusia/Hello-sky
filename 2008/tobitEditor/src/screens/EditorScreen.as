////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package screens
{
	import avmplus.getQualifiedClassName;
	
	import com.wemb.bms.CloseButton;
	import com.wemb.puremvc.interfaces.INotification;
	import com.wemb.tobit.commands.TobitCommand;
	import com.wemb.tobit.components.ITobitComponent;
	import com.wemb.tobit.components.TobitComponent;
	import com.wemb.tobit.components.TobitInfraComponent;
	import com.wemb.tobit.core.MapSystem;
	import com.wemb.tobit.events.TobitMapEvent;
	import com.wemb.tobit.events.ToolBarEvent;
	import com.wemb.tobit.events.ToolEvent;
	import com.wemb.tobit.factory.ITobitItemDefinition;
	import com.wemb.tobit.factory.TobitComponentDefinition;
	import com.wemb.tobit.factory.TobitComponentFactory;
	import com.wemb.tobit.factory.TobitItemDefinition;
	import com.wemb.tobit.line.Handle;
	import com.wemb.tobit.line.LinePointContainer;
	import com.wemb.tobit.line.LinePointer;
	import com.wemb.tobit.map.MapEditorModeDefinition;
	import com.wemb.tobit.navigator.Navigator;
	import com.wemb.tobit.panel.ComponentPanel;
	import com.wemb.tobit.panel.OutlinePanel;
	import com.wemb.tobit.panel.PropertyPanel;
	import com.wemb.tobit.popup.GroupTreePopup;
	import com.wemb.tobit.popup.NodeTreePopup;
	import com.wemb.tobit.popup.TamplatePagePopup;
	import com.wemb.tobit.popup.TemplateListPopup;
	import com.wemb.tobit.puremvc.TobitMapNotifications;
	import com.wemb.tobit.puremvc.containers.ObserverBorderContainer;
	import com.wemb.tobit.puremvc.containers.ObserverCanvas;
	import com.wemb.tobit.puremvc.containers.ObserverGroup;
	import com.wemb.tobit.puremvc.containers.SkinnableContainerObserver;
	import com.wemb.tobit.puremvc.core.TobitMapView;
	import com.wemb.tobit.spark.components.TobitPage;
	import com.wemb.tobit.spark.map.MapBackground;
	import com.wemb.tobit.spark.map.MapEditor;
	import com.wemb.tobit.spark.map.ResizerContainer;
	import com.wemb.tobit.spark.map.TobitMap;
	import com.wemb.tobit.spark.toolbar.ToolBar;
	import com.wemb.tobit.utils.DomainUtil;
	import com.wemb.tobit.vo.ComponentInfo;
	import com.wemb.tobit.vo.ComponentInfoExt;
	import com.wemb.tobit.vo.InterfaceInfo;
	import com.wemb.tobit.vo.NavigatorItem;
	import com.wemb.tobit.vo.Parameter;
	import com.wemb.tobit.vo.ResultMapping;
	import com.wemb.tobit.vo.TobitMapInfo;
	import com.wemb.tobit.vo.TobitRequest;
	import com.wemb.tobit.vo.TriggerEvent;
	import com.wemb.tobit.vo.TriggerNotification;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.text.FontStyle;
	import flash.text.TextColorType;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.Mouse;
	import flash.utils.getDefinitionByName;
	
	import flashx.textLayout.elements.BreakElement;
	import flashx.textLayout.formats.BackgroundColor;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.operations.RedoOperation;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.containers.ApplicationControlBar;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.Label;
	import mx.controls.Menu;
	import mx.controls.MenuBar;
	import mx.controls.menuClasses.MenuListData;
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.events.MenuEvent;
	import mx.events.Request;
	import mx.events.ResizeEvent;
	import mx.graphics.SolidColor;
	import mx.managers.DragManager;
	import mx.managers.PopUpManager;
	import mx.skins.Border;
	import mx.states.SetStyle;
	import mx.styles.ISimpleStyleClient;
	import mx.utils.ObjectUtil;
	import mx.utils.UIDUtil;
	
	import spark.components.BorderContainer;
	import spark.components.Group;
	import spark.components.List;
	import spark.components.Scroller;
	import spark.layouts.HorizontalLayout;
	import spark.primitives.BitmapImage;
	import spark.primitives.Rect;
	
	[Style(name="backgroundImage", inherit="no", type="Class" )]
	
	[Style(name="menubarBgSkin", inherit="no", type="Class" )]
	
	[Style(name="menuDownSkin", inherit="no", type="Class" )]
	
	[Style(name="menuOverSkin", inherit="no", type="Class" )]
	
	[Style(name="menuUpSkin", inherit="no", type="Class" )]
	
	/**
	 * @author miseon
	 */
	public class EditorScreen extends SkinnableContainerObserver
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		public function EditorScreen()
		{
			super();
			
			if( !identificationId || identificationId == "" )
			{
				identificationId = UIDUtil.createUID();
			}
			var view:TobitMapView = new TobitMapView();
			
			facade.registerGroupView(identificationId, view);
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			this.addEventListener(KeyboardEvent.KEY_UP, keyboardEventHandler);
			
			this.dataProvider = null;
			
			var page:TobitPage = new TobitPage();
			TobitPage(page).mapEditable = true;
			page.width = 1024;
			page.height = 600;
			page.percentWidth = 100;
			page.percentHeight = 100;
			page.visible = true;
			page.name = "NewMap";
			this.ownerMap = page;
			
			var tobitMapInfo:TobitMapInfo = new TobitMapInfo();
			tobitMapInfo.mapId = UIDUtil.createUID();
			tobitMapInfo.mapName = "NewMap";
			tobitMapInfo.mapType = "CD00000041";
//			tobitMapInfo.layout = "dynamic";
			tobitMapInfo.generateDate = null;
			tobitMapInfo.updateDate = null;
			
			this.mapId = tobitMapInfo.mapId;
			this.mapEditable = true;
			
			this.tobitMapInfo = tobitMapInfo;
//			this.ownerMap = {width:1024, height:768};
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		private var background:BitmapImage;

		/**
		 *  @private
		 */
		private var menubarBgSkin:Class;
		
		/**
		 *  @private
		 */
		private var menuDownSkin:Class;
		
		/**
		 *  @private
		 */
		private var menuOverSkin:Class;
		
		/**
		 *  @private
		 */
		private var menuUpSKin:Class;
		
		/**
		 * @private
		 */
		private var closeBtn:CloseButton;
		
		/**
		 * @private
		 * Display Component List for drawing map
		 */
		private var componentPanel:ComponentPanel;
		
		/**
		 * @private
		 * adjust properties for selected component
		 */
		private var propertyPanel:PropertyPanel;
		
		/**
		 * @private
		 * Display Component Maptree List for drawing maptree
		 */
		private var outlinePanel:OutlinePanel;
		
		/**
		 * @private
		 */
		private var main:ObserverGroup; 
		
		/**
		 * @private
		 */
		private var mapContainer:ObserverGroup;
		
		/**
		 * @private
		 */
		private var mapEditorContainer:ObserverGroup;
		
		/**
		 * @private
		 */
		private var mapEditorGroup:ObserverGroup;
		
		/**
		 * @private
		 */
		private var menuBar:MenuBar;
		
		/**
		 * @private
		 */
		private var overviewContainer:ObserverGroup;
		
		[Bindable]
		private var _menuAC:ArrayCollection = new ArrayCollection([
			{label:"File" , children:[
				{label:"새로만들기(Clear)" },
				{label:"템플릿 가져오기" },
				{label:"저장" },
				{label:"템플릿으로 저장" },
				{label:"공통노드로 저장" },
				{label:"종료" }
			]} ,
			{label:"Edit" , children:[
				{label:"Undo" },
				{label:"Redo" },
				{label:"Cut" },
				{label:"Copy" },
				{label:"Paste" },
				{label:"Export" },
				{label:"Import" }
			]} , 
			{label:"View" , children:[
				{label:"Zoom In" },
				{label:"Zoom Out" },
				{label:"Show All" },
				{label:"Actual Size" },
				{label:"Grid" ,type:"check",toggled:"true"}
				
			]} , 
			{label:"Objects" , children:[
				{label:"Group" },
				{label:"Un Group" },
				{label:"To Front" },
				{label:"Forward" },
				{label:"To Back" },
				{label:"Backward" }
				
			]} , 
			{label:"Help" , children:[
				{label:"About Tobit" } 
			]} 
		]);
		
		/**
		 * 컴포넌트 목록
		 */
		private var _componentList:Array;
		
		/** Insert List */
		protected var _ac_insertList:ArrayCollection;
		
		/** Update List */
		protected var _ac_updateList:ArrayCollection;
		
		/** Delete List */
		protected var _ac_deleteList:ArrayCollection;
		
		/** Outline List */
		protected var _outlineList:ArrayCollection;
		
		/** Dataprovider 변경 여부  */
		private var changedDataprovider:Boolean = false;
		
		protected var iterator:IViewCursor;
		
		//맵편집 구성 컴포넌트의 위치가 바뀌었는지 체크 플래그
		private var _changedComponentOrder:Boolean = false;
		
		private var _isExitSave:Boolean = false;
		
		// 맵의 레이아웃을 결정하는 요소가 변경됨
		private var changeMapInfo:Boolean = false;
		
		private var updateMapInfo:Boolean = false;
		
		/**
		 * N : none
		 * U : update
		 */
		private var updateFlag:String = "N";
		
		//----------------------------------
		//  Owner Map
		//----------------------------------
		private var _ownerMap:Object;
		
		public function get ownerMap():Object
		{
			return _ownerMap;
		}
		
		public function set ownerMap(value:Object):void
		{
			if(_ownerMap === value)
				return;
			
			_ownerMap = value;
			
			// 맵정보가 업데이트 되어 레이아웃을 변경해야함
			changeMapInfo = true;
			invalidateDisplayList();
		}
		
		//----------------------------------
		//  GroupId
		//----------------------------------
		private var _groupId:String;

		public function get groupId():String
		{
			return _groupId;
		}

		public function set groupId(value:String):void
		{
			_groupId = value;
			
			if(mapEditor) {
				mapEditor.groupId = value;
			}
		}
		
		
		//----------------------------------
		//  Map ID
		//----------------------------------
		private var _mapId:String;
		private var changedMapId:Boolean = false;
		
		public function set mapId(value:String):void
		{
			this._mapId = value;
			changedMapId = true;
			invalidateProperties();
		}
		
		[Bindable]
		public function get mapId():String
		{
			return _mapId;
		}		
		//----------------------------------
		//  symbolValues
		//----------------------------------
		
		private var _symbolValues:ArrayCollection;
		
		private var _changedSymbolValues:Boolean = false;
		
		public function set symbolValues(value:ArrayCollection):void
		{
			if(!this.editMode){
				_symbolValues = value;
				_changedSymbolValues = true;
				invalidateProperties();
			}
		}
		
		public function get symbolValues():ArrayCollection
		{
			return _symbolValues;
		}
		
		//----------------------------------
		//  tobitMapInfo
		//----------------------------------
		/**
		 * @private
		 * Storage for tobitMapInfo property
		 */
		[Bindable]
		private var _tobitMapInfo:TobitMapInfo;
		
		public function get tobitMapInfo():TobitMapInfo
		{
			return _tobitMapInfo;
		}
		
		public function set tobitMapInfo(value:TobitMapInfo):void
		{
			if (_tobitMapInfo) {
				_tobitMapInfo.removeEventListener("change", changeTobitMapInfoHandler);
			}
			
			_tobitMapInfo = value;
			
			var mapWidth:Number = 0;
			var mapHeight:Number = 0;
			
			if (ownerMap) {
				mapWidth = ownerMap.width;
				mapHeight = ownerMap.height;
			}
			
			if (_tobitMapInfo) {
				// 레이아웃 설정값을 적용
				if (_tobitMapInfo.layout == "fixed") {
					mapWidth = Number(_tobitMapInfo.width);
					mapHeight = Number(_tobitMapInfo.height);
				}
				
				if (!_tobitMapInfo.minWidth || _tobitMapInfo.minWidth == "") {
					_tobitMapInfo.minWidth = String(mapWidth);
				}
				
				if(!_tobitMapInfo.minHeight || _tobitMapInfo.minHeight == "") {
					_tobitMapInfo.minHeight = String(mapHeight);
				}
			}
			
			
			
			if(_tobitMapInfo) {
				_tobitMapInfo.addEventListener("change", changeTobitMapInfoHandler);
			}
			
			// 맵정보가 업데이트 되어 레이아웃을 변경해야함
			changeMapInfo = true;
			invalidateDisplayList();
		}
		
		//----------------------------------
		//  Navigator Container
		//----------------------------------
		/** 네비게이터 */
		private var _navigator:Navigator;
		
		private var _changedNavigator:Boolean = false;
		
		public function set navigator(value:Navigator):void
		{
			// reset
			if(_navigator){
				if(_navigator.parent == this){
					removeElement(_navigator);
				}
				
				if(this.hasEventListener(TobitMapEvent.SYMBOL_DOUBLIE_CLICK))
					removeEventListener(TobitMapEvent.SYMBOL_DOUBLIE_CLICK, symbolDoubleClickToNavigatorHandler);
				
				if(this.hasEventListener(TobitMapEvent.NAVIGATOR_CLICK_EVENT))
					removeEventListener(TobitMapEvent.NAVIGATOR_CLICK_EVENT, symbolDoubleClickFromNavigatorHandler);
			}
			
			// set
			_navigator = value;
			
			//initialize
			if(_navigator) {
				this.addEventListener(TobitMapEvent.SYMBOL_DOUBLIE_CLICK, symbolDoubleClickToNavigatorHandler);
				this.addEventListener(TobitMapEvent.NAVIGATOR_CLICK_EVENT, symbolDoubleClickFromNavigatorHandler);
			}
			
			
			// initialize
			_changedNavigator = true;
			
			invalidateProperties();
		}
		
		//----------------------------------
		//  Resizer Container 
		//----------------------------------
		protected var _resizerContainer:ResizerContainer;
		
		public function set resizerContainer(value:ResizerContainer):void
		{
			_resizerContainer = value;
		}
		
		public function get resizerContainer():ResizerContainer
		{
			return _resizerContainer;
		}
		
		//----------------------------------
		//  LinePoint Container
		//----------------------------------
		protected var _linePointContainer:LinePointContainer;
		
		public function set linePointContainer(value:LinePointContainer):void
		{
			_linePointContainer = value;
		}
		
		public function get linePointContainer():LinePointContainer
		{
			return _linePointContainer;
		}
		//----------------------------------
		//  ToolBar component
		//----------------------------------
		private var _toolBar:ToolBar;
		
		//----------------------------------
		//  GroupTreePopup
		//----------------------------------
		private var groupTreePopup:GroupTreePopup;
		
		//----------------------------------
		//  NodeTreePopup
		//----------------------------------
		private var nodeTreePopup:NodeTreePopup;
		
		//----------------------------------
		//  TemplateListPopup
		//----------------------------------
		private var templateListPopup:TemplateListPopup;
		
		//----------------------------------
		//  nametemplatePopup
		//----------------------------------
		private var templatePopup:TamplatePagePopup;
		
		//----------------------------------
		// Collection
		//----------------------------------
		public function set dataProvider(value:Object):void
		{
			if(collection)
			{
				collection.removeEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler);
			}
			
			if(value is Array)
			{
				collection = new ArrayCollection(value as Array);
			}
			else if (value is ArrayCollection)
			{
				collection = ArrayCollection(value);
			}
			else if (value is ICollectionView)
			{
				//collection = ICollectionView(value);
			}
			else if (value is IList)
			{
				//collection = new ListCollectionView(IList(value));
			}
			else if (value is XMLList)
			{
				//collection = new XMLListCollection(value as XMLList);
			}
			else if (value is XML)
			{
				var xl:XMLList = new XMLList();
				xl += value;
				//collection = new XMLListCollection(xl);
			}
			else
			{
				var tmp:Array = [];
				if (value != null)
					tmp.push(value);
				collection = new ArrayCollection(tmp);
			}
			
			// get an iterator
			iterator = collection.createCursor();
			
			collection.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler);
			
			//Arraycollection 초기화
			_ac_insertList = new ArrayCollection();
			_ac_updateList = new ArrayCollection();
			_ac_deleteList = new ArrayCollection();
			
			//기존 데이타들 초가화 작업 시작
			changedDataprovider = true;
			
			//컴포넌트 갱신 작업 시작
			invalidateProperties();
			invalidateSize();
			invalidateDisplayList();
		}
		
		public function get dataProvider():Object
		{
			return collection;
		}
		private var _infraList:ArrayCollection;

		public function get infraList():ArrayCollection
		{
			return _infraList;
		}

		public function set infraList(value:ArrayCollection):void
		{
			_infraList = value;
		}

		private var _networkList:ArrayCollection;
		

		public function get networkList():ArrayCollection
		{
			return _networkList;
		}

		public function set networkList(value:ArrayCollection):void
		{
			_networkList = value;
		}
		
		
		protected var collection:ArrayCollection = new ArrayCollection () ;

		protected function collectionChangeHandler(event:CollectionEvent):void
		{
			if( event.items )
			{
				if (event.kind == CollectionEventKind.ADD) {
					//ArrayCollection 초기화
					if( !_ac_insertList )
						_ac_insertList = new ArrayCollection();
					
					var addItems:Array = event.items;
					for (var i:int=0; i<addItems.length; i++) {
						var a_item:Object = addItems[i];
						// insert할 아이템 추가.
						_ac_insertList.addItem(a_item);
					}
				} else if( event.kind == CollectionEventKind.REMOVE ) {
					//ArrayCollection 초기화
					if( !_ac_deleteList )
						_ac_deleteList = new ArrayCollection();
					
					var removeItems:Array = event.items;
					for( i=0; i<removeItems.length; i++ ) {
						// 삭제할 아이템
						var r_item:Object = removeItems[i];
						
						if (_ac_insertList.contains(r_item)) {
							_ac_insertList.removeItemAt(_ac_insertList.getItemIndex(r_item));
						} else if (_ac_updateList.contains(r_item)) {
							_ac_updateList.removeItemAt(_ac_updateList.getItemIndex(r_item));
						}
						_ac_deleteList.addItem(r_item);
						// 컴포넌트 삭제 property 속성 삭제 위치
						// 임시 삭제 위치 위치가 좀 이상한 듯 다른 곳을 찾자
						propertyPanel.targets = null;
					}
				} else if( event.kind == CollectionEventKind.UPDATE ) {
					//ArrayCollection 초기화
					if( !_ac_updateList )
						_ac_updateList = new ArrayCollection();
					
					var updateItems:Array = event.items;
					
					for( i=0; i<updateItems.length; i++ )
					{
						//trace("업데이트.",this);
						var u_item:Object = updateItems[i].source;
						
						if (!_ac_insertList.contains(u_item) && !_ac_updateList.contains(u_item)) {
							_ac_updateList.addItem(u_item);
						}
					}
				}
			}
		}
		//----------------------------------
		// bmsMapType, editorType
		//----------------------------------
		private var _changedEditorType:Boolean= false;
		[Inspectable(defaultValue="bms", enumeration="tobit,bms", type="String")]
		private var _editorType:String; 

		public function get editorType():String
		{
			return _editorType;
		}

		public function set editorType(value:String):void
		{
			_changedEditorType = true;
			_editorType = value;
			invalidateProperties();
		}
		
		private var _changeMapType:Boolean = false;
		private var _mapType:String;

		public function get mapType():String
		{
			return _mapType;
		}

		public function set mapType(value:String):void
		{
			_changeMapType = true;
			_mapType = value;
			invalidateProperties();
		}

		
		//----------------------------------
		// Pure MVC
		//----------------------------------
		override public function onRegister():void{
		}
		
		override public function onRemove():void{
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				TobitMapNotifications.GET_MAP,
				TobitMapNotifications.SAVE_MAP,
				TobitMapNotifications.GET_COMPONENT_LIST,
				TobitMapNotifications.EXPORT_TO_XML,
				TobitMapNotifications.IMPORT_FROM_XML,
				TobitMapNotifications.CHANGE_EDITORMODE,
				TobitMapNotifications.GET_INTERFACE,
				TobitMapNotifications.UPDATE_INTERFACE,
				TobitMapNotifications.COMMON_TEMPLATE_SAVE_MAP,
				TobitMapNotifications.TEMPLATE_GET_MAP
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var command:String = notification.getName();
			
			if(notification.getBody() is TobitRequest){
				TobitRequest(notification.getBody()).pageName = "EditorScreen13";
				if(TobitRequest(notification.getBody()).pageName != this.name){
					return;
				}
			}

			switch(command)
			{
				case TobitMapNotifications.GET_MAP:
					rs_getMap(notification.getBody() as TobitRequest);
					break;
				case TobitMapNotifications.SAVE_MAP:
					rs_saveMap(notification.getBody() as TobitRequest);
					break;
				case TobitMapNotifications.GET_COMPONENT_LIST:
					rs_getComponentList(notification.getBody() as TobitRequest);
					break;
				case TobitMapNotifications.EXPORT_TO_XML:
					rs_exportMap(notification.getBody() as TobitRequest);
					break;
				case TobitMapNotifications.IMPORT_FROM_XML:
					rs_importMap(notification.getBody() as TobitRequest);
					break;
				case TobitMapNotifications.CHANGE_EDITORMODE:
					break;
				case TobitMapNotifications.GET_INTERFACE:
					rs_getInterface(notification.getBody() as TobitRequest);
					break;
				case TobitMapNotifications.UPDATE_INTERFACE:
					rs_updateInterface(notification.getBody() as TobitRequest);
					break;
				case TobitMapNotifications.COMMON_TEMPLATE_SAVE_MAP:
					rs_commontemplateSaveMap(notification.getBody() as TobitRequest);
					break;
				case TobitMapNotifications.TEMPLATE_GET_MAP:
					rs_templateGetMap(notification.getBody() as TobitRequest);
					break;
			}
		}
		
		//-------------------------------------------------------------------
		// getMap 매정보 요청
		//-------------------------------------------------------------------
		/**
		 * 맵정보 요청 메소드
		 */
		public function getMap():void{
			// 맵 아이디 확인
			if(mapId){
				// 현재 맵이 등록되어 있는지 확인후 요청
				if(facade.hasMediator(this.mediatorName)){
					// 맵정보 조회 요청
					
					sendTobitRTMP(TobitMapNotifications.GET_MAP, {mapId:this.mapId, updateDate:null, type:"edit"});
				}
			}
		} // getMap
		
		/**
		 * 맵인터페이스 정보 요청 메소드
		 */
		public function getInterface():void{
			// 맵 아이디 확인
			if(mapId){
				// 현재 맵이 등록되어 있는지 확인후 요청
				if(facade.hasMediator(this.mediatorName)){
					// 맵정보 조회 요청
					
					sendTobitRTMP(TobitMapNotifications.GET_INTERFACE, {mapId:this.mapId, updateDate:null});
				}
			}
		} // getInterface
		
		/**
		 * 맵정보 요청결과 처리
		 */
		private function rs_getMap(request:TobitRequest):void
		{
			// 맵 구성정보
			tobitMapInfo = request.getResult("mapConfig") as TobitMapInfo;
			
			// 맵 컴포넌트정보
			var mapComponents:Array = request.getResult("mapComponents") as Array;
			// 맵 인터페이스정보
			var mapInterfaces:Array = request.getResult("mapInterfaces") as Array;
			
			// 맵을 구성하는 컴포넌트 정보값을 dataProvider에 설정
			this.dataProvider = mapComponents;
			
			this.interfaceArr = mapInterfaces;
			
			_mapEditor.interfaceArr = mapInterfaces;
			
			if (propertyPanel) {
				propertyPanel.tobitMapInfo = tobitMapInfo;
			}
		} // rs_getMap
		
		/**
		 * 맵정보 요청결과 처리
		 */
		private function rs_getInterface(request:TobitRequest):void
		{
			// 맵 인터페이스정보
			var interfaces:Array = request.getResult("interfaces") as Array;
			
			this.interfaceArr = interfaces;
			
//			_mapEditor.interfaceArr = interfaces;
			
		} // rs_getInterface
		
		private function rs_updateInterface(request:TobitRequest):void{
			var result:int = request.result as int;
			trace("Interface 저장 성공 : ", result);
			/*if(result == 0){
				Alert.show( "업데이트된 정보가 없습니다.", "알림", Alert.OK );
			}else if(result == -1){
				Alert.show( "업데이트중 에러가 발생 하였습니다.", "알림", Alert.OK );
			}else if(result > 0){
				Alert.show( "저장 되었습니다.", "알림", Alert.OK );
			}else{
				Alert.show( "알수없는 결과입니다.", "알림", Alert.OK );
			}*/
		}
		
		private function changeTobitMapInfoHandler(event:Event):void {
			// 맵정보가 업데이트 되어 레이아웃을 변경해야함
			changeMapInfo = true;
			updateMapInfo = true;
			invalidateDisplayList();
		}
		
		//-------------------------------------------------------------------
		// saveMap 맵 구성정보 업데이트
		//-------------------------------------------------------------------
		/**
		 * 맵 구성정보 업데이트 요청
		 */
		public function saveMap(event:ContextMenuEvent = null):void
		{
			var updateDate:Object = new Object();
			updateDate.insertItems = this._ac_insertList.source;
			updateDate.updateItems = this._ac_updateList.source;
			updateDate.deleteItems = this._ac_deleteList.source;
			updateDate.map = tobitMapInfo;
			
			// 등록 해야할 컴포넌트 인터페이스 정보 저장
			if (this._ac_insertList) {
				var defaultInterfaces:Array = [];
				for each(var info:ComponentInfo in this._ac_insertList.source) {
					var iComp:ITobitComponent = _mapEditor.components[info.id] as ITobitComponent;
					if (iComp && iComp.defaultInterfaces) {
						defaultInterfaces = defaultInterfaces.concat(iComp.defaultInterfaces);
					} 
					if (iComp) {
						if (iComp.interfaceArr) {
							var params:Object = new Object();
							params.insertItems = iComp.interfaceArr;
							sendTobitRTMP(TobitMapNotifications.UPDATE_INTERFACE, params);
						}
					}
				}
				sendTobitRTMP(TobitMapNotifications.CHECK_DEFAULT_INTERFACES, {defaultInterfaces:defaultInterfaces});
			}
			sendTobitRTMP(TobitMapNotifications.SAVE_MAP, updateDate, true);
		} // saveMap
		
		/**
		 * 맵 구성정보 업데이트 결과처리
		 */
		private function rs_saveMap(request:TobitRequest):void
		{
			var updateCount:int = request.result as int;
			if(updateCount > 0 ){
				updateFlag = "U";
				Alert.show("저장되었습니다.","정보");
				if(_isExitSave){
					_isExitSave = false;
					// 종료
					closeBMSMapEditor();
				}else{
					updateDataReset();
				}
			}else if(updateCount == 0 ) {
				Alert.show("저장된 정보가 없습니다.","정보");
			}else{
				Alert.show("알수없는 오류입니다.","예");
			}
		} // rs_saveMap
		
		//-------------------------------------------------------------------
		// commonMap, templateMap 맵 구성정보 저장
		//-------------------------------------------------------------------
		/**
		 * commonMap, templateMap save 요청
		 */
		public function commonTemplateSaveMap(mapName:String, mapType:String, event:ContextMenuEvent = null):void
		{
			
			var newComponentItems:ArrayCollection = new ArrayCollection();
			var newInterfaceItems:ArrayCollection = new ArrayCollection();
			var insertDate:Object = new Object();
			
			// tobitMapInfo copy&modify
			var modifiedTobitMapInfo:TobitMapInfo = newTobitMapInfo(mapName, mapType);
			insertDate.map = modifiedTobitMapInfo;
			
			if (collection) {
				//componentList, interfaceList copy
				newComponentItems.source = copyObjectList(collection.source);
				newInterfaceItems.source = copyObjectList(interfaceArr);
				
				//component, interface 재정의
				for each(var componentInfo:ComponentInfo in newComponentItems.source) {
					var tempMcId:String = componentInfo.mcId;	//mcId 임시 저장
					var tempId:String = componentInfo.id;		//id 임시 저장
					componentInfo.id = UIDUtil.createUID();
					componentInfo.mcId = UIDUtil.createUID();
					componentInfo.mapId = modifiedTobitMapInfo.mapId;
					
					//component가 properties를 가지고 있을 경우 component의 mcId를 부여한다.
					if (componentInfo.properties) {
						for each(var componentInfoExt:ComponentInfoExt in componentInfo.properties) {
							componentInfoExt.mcId = componentInfo.mcId;
						}
					}
					
					//component가 부모id를 가지고 있을 경우 맵핑되는 component의 새로운 id를 부여한다.
					for each(var tempComponentInfo:ComponentInfo in newComponentItems.source) {
						if (tempId == tempComponentInfo.parent) {		//tempId를 부모로 가지고 있는 component의 parent를 새로운 id로 수정한다
							tempComponentInfo.parent = componentInfo.id;
						}
					}
					
					//component가 새로운 interfaceInfo를 추가 되었을 경우 component에서 추출하여 저장 정보에 추가한다.
					if (_mapEditor.components[tempId].interfaceArr) {
						for each (var newInterfaceInfo:InterfaceInfo in _mapEditor.components[tempId].interfaceArr) {
							var mapInterfaceInfo:InterfaceInfo = InterfaceInfo(ObjectUtil.copy(newInterfaceInfo));
							mapInterfaceInfo.id = UIDUtil.createUID();
							mapInterfaceInfo.mcId = componentInfo.mcId;
							//interfaceInfo의 events가 존재하면 재정의한다.
							mapInterfaceInfo = modifiedList(mapInterfaceInfo, "events");
							//interfaceInfo의 params가 존재하면 재정의한다.
							mapInterfaceInfo = modifiedList(mapInterfaceInfo, "params");
							//interfaceInfo의 notifications가 존재하면 재정의한다.
							mapInterfaceInfo = modifiedList(mapInterfaceInfo, "notifications");
							//interfaceInfo의 mappings가 존재하면 재정의한다.
							mapInterfaceInfo = modifiedList(mapInterfaceInfo, "mappings");
							
							newInterfaceItems.addItem(mapInterfaceInfo);
						}
					} 
					//기존 component가 interfaceInfo를 가지고 있을 경우 interfaceInfo를 수정하여 새로운 아이디를 부여한다.
					if (newInterfaceItems) {
						for each (var interfaceInfo:InterfaceInfo in newInterfaceItems.source) {
							if (tempMcId == interfaceInfo.mcId) {
								interfaceInfo.id = UIDUtil.createUID();
								interfaceInfo.mcId = componentInfo.mcId;
								//interfaceInfo의 events가 존재하면 재정의한다.
								interfaceInfo = modifiedList(interfaceInfo, "events");
								//interfaceInfo의 params가 존재하면 재정의한다.
								interfaceInfo = modifiedList(interfaceInfo, "params");
								//interfaceInfo의 notifications가 존재하면 재정의한다.
								interfaceInfo = modifiedList(interfaceInfo, "notifications");
								//interfaceInfo의 mappings가 존재하면 재정의한다.
								interfaceInfo = modifiedList(interfaceInfo, "mappings");
							}
						}
					}
				}
				//인터페이스 정보를 저장
				var params:Object = new Object();
				params.insertItems = newInterfaceItems.source;
				sendTobitRTMP(TobitMapNotifications.UPDATE_INTERFACE, params);
			}
			
			//맵 정보를 저장
			insertDate.insertItems = newComponentItems.source;
			sendTobitRTMP(TobitMapNotifications.COMMON_TEMPLATE_SAVE_MAP, insertDate, true);
			// 임시 객체들 초기화
			modifiedTobitMapInfo = null;
			newComponentItems = null;
			newInterfaceItems = null;
			insertDate = null;
		} // commonMapSave
		
		/**
		 * tobitMapInfo를 복사하여 새로운 객체로 반환
		 */
		private function newTobitMapInfo(mapName:String, mapType:String):TobitMapInfo {
			// tobitMapInfo copy
			var newTobitMapInfo:TobitMapInfo = TobitMapInfo(ObjectUtil.copy(tobitMapInfo));
			newTobitMapInfo.mapId = UIDUtil.createUID();
			newTobitMapInfo.mapName = mapName;
			newTobitMapInfo.mapType = mapType;
			newTobitMapInfo.generateDate = null;
			newTobitMapInfo.updateDate = null;
			return newTobitMapInfo;
		}
		
		/**
		 * 객체를 새로운 객체로 복사하여 반환
		 */
		private function copyObjectList(copyList:Array):Array {
			var newList:Array = new Array();
			for each(var obj:Object in copyList) {
				var tempObj:Object = Object(ObjectUtil.copy(obj));
				newList.push(tempObj);
			}
			return newList;
		}
		
		/**
		 * interfaceInfo 정보를 수정하여 반환
		 */
		private function modifiedList(interfaceInfo:InterfaceInfo, propertyName:String):InterfaceInfo {
			//속성의 정보값이 존재하면
			if (interfaceInfo[propertyName]) {
				for (var i:int = 0; i < interfaceInfo[propertyName].length; i++) {
					if (interfaceInfo[propertyName][i] is TriggerEvent) {
						
						var triggerEvnet:TriggerEvent = interfaceInfo[propertyName][i];
						triggerEvnet.interfaceId = interfaceInfo.id;
						triggerEvnet.id = UIDUtil.createUID();
						interfaceInfo[propertyName][i] = triggerEvnet;
						
					} else if (interfaceInfo[propertyName][i] is Parameter) {
						
						var param:Parameter = interfaceInfo[propertyName][i];
						param.interfaceId = interfaceInfo.id;
						param.id = UIDUtil.createUID();
						interfaceInfo[propertyName][i] = param;
						
					} else if (interfaceInfo[propertyName][i] is TriggerNotification) {
						
						var notification:TriggerNotification = interfaceInfo[propertyName][i];
						notification.interfaceId = interfaceInfo.id;
						notification.id = UIDUtil.createUID();
						interfaceInfo[propertyName][i] = notification;
						
					} else if (interfaceInfo[propertyName][i] is ResultMapping) {
						
						var mapping:ResultMapping = interfaceInfo[propertyName][i];
						mapping.interfaceId = interfaceInfo.id;
						mapping.id = UIDUtil.createUID();
						interfaceInfo[propertyName][i] = mapping;
					}
				}
			}
			return interfaceInfo;
		}
		
		//-------------------------------------------------------------------
		// 여기까지 commonMap, templateMap 맵 저장 공통 메소드
		//-------------------------------------------------------------------
		
		/**
		 * 공통, 탬플릿 맵 구성정보 업데이트 결과처리
		 */
		private function rs_commontemplateSaveMap(request:TobitRequest):void
		{
			var updateCount:int = request.result as int;
			if(updateCount > 0 ){
				updateFlag = "U";
				Alert.show("저장되었습니다.","정보");
				if(_isExitSave){
					_isExitSave = false;
					// 종료
					closeBMSMapEditor();
				}else{
					updateDataReset();
				}
			}else if(updateCount == 0 ) {
				Alert.show("저장된 정보가 없습니다.","정보");
			}else{
				Alert.show("알수없는 오류입니다.","예");
			}
		} // rs_commonTemplateSaveMap
		
		/**
		 * 템플릿 맵정보 요청결과 처리
		 */
		private function rs_templateGetMap(request:TobitRequest):void
		{
			_mapEditor.removeAll();
			// 맵 구성정보
			var templateTobitMapInfo:TobitMapInfo = request.getResult("mapConfig") as TobitMapInfo;
			// 맵 컴포넌트정보
			var mapComponents:Array = request.getResult("mapComponents") as Array;
			// 맵 인터페이스정보
			var mapInterfaces:Array = request.getResult("mapInterfaces") as Array;
			// 삭제 후 로딩한 컴포넌트를 추가한다.
			var newInters:Array = new Array();
			var newItems:Array = new Array();
			
			//가져온 템플릿에 현재 페이지 정보 등록
			templateTobitMapInfo.mapId = tobitMapInfo.mapId;
			templateTobitMapInfo.mapName = tobitMapInfo.mapName;
			templateTobitMapInfo.mapType = tobitMapInfo.mapType;
			
			tobitMapInfo = templateTobitMapInfo;
			
			for each(var componentInfo:ComponentInfo in mapComponents) {
				componentInfo.mcId = UIDUtil.createUID();
				componentInfo.mapId = this.mapId;
				componentInfo.initFlag = true;
				
				//subMapId가 존재 할 경우 새로운 subMapId 부여한다.
				if (componentInfo.subMapId) {
					componentInfo.subMapId = UIDUtil.createUID();
					componentInfo.groupId = this.groupId;
				}
				
				//component가 properties를 가지고 있을 경우 component의 mcId를 부여한다.
				if (componentInfo.properties) {
					for each(var componentInfoExt:ComponentInfoExt in componentInfo.properties) {
						componentInfoExt.mcId = componentInfo.mcId;
					}
				}
				
				this.collection.addItem(componentInfo as ComponentInfo);
				for each(var interfaceInfo:InterfaceInfo in mapInterfaces) {
					if(componentInfo.id == interfaceInfo.componentId) {
						interfaceInfo.mcId = componentInfo.mcId;
						interfaceInfo.id = UIDUtil.createUID();
						//interfaceInfo의 events가 존재하면 재정의한다.
						interfaceInfo = modifiedList(interfaceInfo, "events");
						//interfaceInfo의 params가 존재하면 재정의한다.
						interfaceInfo = modifiedList(interfaceInfo, "params");
						//interfaceInfo의 notifications가 존재하면 재정의한다.
						interfaceInfo = modifiedList(interfaceInfo, "notifications");
						//interfaceInfo의 mappings가 존재하면 재정의한다.
						interfaceInfo = modifiedList(interfaceInfo, "mappings");
						
						newInters.push(interfaceInfo);
					}
				}
			}
			//			this.collection.addItem(newItems);
			
			if (this._ac_insertList) {
				var defaultInterfaces:Array = [];
				for each(var info:ComponentInfo in this._ac_insertList.source) {
					var iComp:ITobitComponent = _mapEditor.components[info.id] as ITobitComponent;
					var setInterfaceInfo:Array = new Array();
					if (iComp) {
						for each (var interfaceInfo:InterfaceInfo in newInters) {
							if (iComp.componentInfo.id == interfaceInfo.componentId) {
								setInterfaceInfo.push(interfaceInfo);
							}
							iComp.interfaceArr = setInterfaceInfo;
						}
					}
				}
			}
			this.interfaceArr = newInters;
			_mapEditor.interfaceArr = newInters;
			
			if (propertyPanel) {
				propertyPanel.tobitMapInfo = tobitMapInfo;
			}
			mapEditor.unSelected();
			//			}
		} // rs_templateGetMap
		//-------------------------------------------------------------------
		// getComponentList 사용되는 컴포넌트 목록을 조회한다.
		//-------------------------------------------------------------------
		
		/**
		 * 컴포넌트목록 조회
		 */
		private function getComponentList():void{
			sendTobitRTMP(TobitMapNotifications.GET_COMPONENT_LIST, {});
		} // getComponentList
		
		/**
		 * 컴포넌트목록 조회 결과를 처리
		 */
		private function rs_getComponentList(request:TobitRequest):void{
			_componentList = request.result as Array;
			
			if(componentPanel)
			{
				componentPanel.componentList = _componentList;
			}
			
		} // rs_getComponentList
		
		//-------------------------------------------------------------------
		// Map Information export to xml
		//-------------------------------------------------------------------
		private function exportMap():void{
			sendTobitRTMP(TobitMapNotifications.EXPORT_TO_XML, {items:dataProvider, inters:interfaceArr});
		} // exportMap
		
		private function rs_exportMap(request:TobitRequest):void{
			var fileName:String = request.getResult("fileName") as String;
			var filePath:String = "";
			// start fileDownload
			var urlRequest:URLRequest = new URLRequest(DomainUtil.getDomain() + "/download?" + filePath + ":" + fileName + ":" + fileName);
			
			navigateToURL(urlRequest, "this");
		} // rs_exportMap
		
		//-------------------------------------------------------------------
		// Import map Information 
		//-------------------------------------------------------------------
		private function importMap(fileName:String):void{
			// all clear
			this._mapEditor.allSelected();
			this._mapEditor.removeSelectedSymbol();
			// file loading...
			sendTobitRTMP(TobitMapNotifications.IMPORT_FROM_XML, {fileName:fileName});
		} // importMap
		
		private function rs_importMap(request:TobitRequest):void{
			// 파일을 정상적으로 읽어 올 경우 기존 컴포넌트 정보는 삭제한다.
			_mapEditor.removeAll();
			// 삭제 후 로딩한 컴포넌트를 추가한다.
			var result:Array = request.getResult("result") as Array;
			var inters:Array = result["inters"];
			var items:Array = result["items"];
			
			//새로운 컴포넌트와 인터페이스를 담을 변수
			var newInters:Array = new Array();
			var newItems:Array = new Array();
			
			for each(var componentInfo:ComponentInfo in items) {
				var tempMcId:String = componentInfo.mcId;
				var tempId:String = componentInfo.id;
				componentInfo.mcId = UIDUtil.createUID();
				componentInfo.id = UIDUtil.createUID();
				componentInfo.mapId = this.mapId;
				componentInfo.initFlag = true;
				
				//subMapId를 가지고 있을 경우 새로운 아이디를 부여한다
				if (componentInfo.subMapId) {
					componentInfo.subMapId = UIDUtil.createUID();
					componentInfo.groupId = this.groupId;
				}
				//properties를 가지고 있을 경우 component의 mcId를 맵핑한다.
				if (componentInfo.properties) {
					for each(var componentInfoExt:ComponentInfoExt in componentInfo.properties) {
						componentInfoExt.mcId = componentInfo.mcId;
					}
				}
				
				//부모 id를 가지고 있을경우 새로운 아이디로 연동한다.
				for each(var tempComponentInfo:ComponentInfo in items) {
					if (tempId == tempComponentInfo.parent) {
						tempComponentInfo.parent = componentInfo.id;
					}
				}
				
				this.collection.addItem(componentInfo);
				for each(var interfaceInfo:InterfaceInfo in inters) {
					if(tempMcId == interfaceInfo.mcId) {
						interfaceInfo.mcId = componentInfo.mcId;
						interfaceInfo.id = UIDUtil.createUID();
						//interfaceInfo의 events가 존재하면 재정의한다.
						interfaceInfo = modifiedList(interfaceInfo, "events");
						//interfaceInfo의 params가 존재하면 재정의한다.
						interfaceInfo = modifiedList(interfaceInfo, "params");
						//interfaceInfo의 notifications가 존재하면 재정의한다.
						interfaceInfo = modifiedList(interfaceInfo, "notifications");
						//interfaceInfo의 mappings가 존재하면 재정의한다.
						interfaceInfo = modifiedList(interfaceInfo, "mappings");
						
						newInters.push(interfaceInfo);
					}
				}
			}
			
			if (this._ac_insertList) {
				var defaultInterfaces:Array = [];
				for each(var info:ComponentInfo in this._ac_insertList.source) {
					var iComp:ITobitComponent = _mapEditor.components[info.id] as ITobitComponent;
					var setInterfaceInfo:Array = new Array();
					if (iComp) {
						for each (var interfaceInfo:InterfaceInfo in newInters) {
							if (iComp.componentInfo.mcId == interfaceInfo.mcId) {
								setInterfaceInfo.push(interfaceInfo);
							}
							iComp.interfaceArr = setInterfaceInfo;
						}
					}
				}
			}
			this.interfaceArr = newInters;
			_mapEditor.interfaceArr = newInters;
			mapEditor.unSelected();

		} // rs_importMap
		
		//-------------------------------------------------------------------
		// 파일 다운로드를 시작한다.
		//-------------------------------------------------------------------
		
		//----------------------------------
		//  MapEditor component
		//----------------------------------
		private var _mapEditor:MapEditor;
		
		private var _changedMapEditor:Boolean = false;
		public function get mapEditor():MapEditor
		{
			return _mapEditor;
		}

		public function set mapEditor(value:MapEditor):void
		{
			// default property reset
			if(_mapEditor){
				if(_mapEditor.parent == this)
					removeElement(_mapEditor);
				
				if(_mapEditor.hasEventListener(TobitMapEvent.CHANGED_EDITOR_MODE)){
					_mapEditor.removeEventListener(TobitMapEvent.CHANGED_EDITOR_MODE, changedEditorModeHandler);
					//_mapEditor.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
				}
			}
			
			// setting component
			_mapEditor = value;
			
			// initialize property
			_changedMapEditor = true;
			
			invalidateProperties();
		}
		protected function changedEditorModeHandler(event:TobitMapEvent):void
		{
			if(event.editorMode == MapEditorModeDefinition.NORMAL_MODE)
			{
			}
			else
			{
				
			}
		}
		///////////////////////////////////////////////////////////////////////////
		/* 화면                                                     member*/
		///////////////////////////////////////////////////////////////////////////
		private var editorViewPort:ObserverGroup;
		private var zoomContainer:ObserverGroup;
		private var editorScroller:Scroller;
		
		
		private var _changedMapBackground:Boolean = false;
		private var _tobitmap:TobitMap;
		public function get tobitmap():TobitMap
		{
			return _tobitmap;
		}
		
		public function set tobitmap(value:TobitMap):void
		{
			if(_tobitmap){
				if(_tobitmap.parent == this)
					removeElement(_tobitmap);
			}
			_tobitmap = value;
		}
		private var _mapBackground:MapBackground;
		public function get mapBackground():MapBackground
		{
			return _mapBackground;
		}
		public function set mapBackground(value:MapBackground):void
		{
			// reset
			if(_mapBackground){
				if(_mapBackground.parent == this)
					removeElement(_mapBackground);
			}
			// set
			_mapBackground = value;
			
			// initialize
			_changedMapBackground = true;
			
			invalidateProperties();
		}

		/**
		 * @private
		 */
		protected override function createChildren():void 
		{
			super.createChildren();
			
			// eventlistner 등록
			
			this.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			
			///////////////////////////////////a////////////////////////////////////////
			/* 화면                                                     start*/
			///////////////////////////////////////////////////////////////////////////
			
			// 현재 보여지는 윈도우 사이즈 크기에 맞춘다.
			this.width = systemManager.getTopLevelRoot().width;
			this.height = systemManager.getTopLevelRoot().height;
			
			// MapContainer
			mapContainer = new ObserverGroup();
			mapContainer.left = 8;
			mapContainer.right = 6;
			mapContainer.top = 4;
			mapContainer.bottom = 10;
			mapContainer.identificationId = this.identificationId;
			this.addElement(mapContainer);
			
			// Head menuBar
			menuBar = new MenuBar();
			menuBar.dataProvider = _menuAC;
			menuBar.left = 75;
			menuBar.addEventListener(MenuEvent.CHANGE, menuChageEventHandler);
			menuBar.addEventListener(MenuEvent.ITEM_CLICK, menuItemClickEventHandler);
			menuBar.styleName = "mapMenuBar";
			
			menuBar.setStyle("backgroundSkin", menubarBgSkin);
			menuBar.setStyle("itemDownSkin", menuDownSkin);
			menuBar.setStyle("itemOverSkin", menuOverSkin);
			menuBar.setStyle("itemUpSkin", menuUpSKin);
			mapContainer.addElement(menuBar);
			
			// generate ToolBar
			_toolBar = new ToolBar();
			_toolBar.top = 25;
			_toolBar.addEventListener(ToolEvent.ITEM_CLICK, itemClickHandler);
			mapContainer.addElement(_toolBar);
			
			
			// Body horizental Container
			main = new ObserverGroup();
			main.top = 71;
			main.left = main.right = main.bottom = 0;
			mapContainer.addElement(main);
			
			//MapEditorContainer
			mapEditorContainer = new ObserverGroup();
			mapEditorContainer.percentHeight = 100;
			mapEditorContainer.percentWidth = 100;
			main.addElement(mapEditorContainer);
			
			// map editor group( scroller, viewPort)
			mapEditorGroup = new ObserverGroup();
			mapEditorGroup.percentHeight = 100;
			mapEditorGroup.percentWidth = 100;
			mapEditorContainer.addElement(mapEditorGroup);
			
			// scroller
			editorScroller = new Scroller();
			editorScroller.name="editorScroller";
			editorScroller.percentHeight = 100;
			editorScroller.percentWidth = 100;
			mapEditorGroup.addElement(editorScroller);
			
			//EditorViewPort
			editorViewPort= new ObserverGroup();
			editorViewPort.name ="editorViewPort";
			editorViewPort.identificationId = this.identificationId;
			//editorViewPort.addEventListener(FlexEvent.UPDATE_COMPLETE, viewPortUpdateHandler);
			//editorViewPort.addEventListener(ResizeEvent.RESIZE, viewPortResizeHandler);
			editorScroller.viewport= editorViewPort ;
			
			// zoom container
			zoomContainer = new ObserverGroup();
			zoomContainer.name = "zoomContainer";
			zoomContainer.identificationId = this.identificationId;
			zoomContainer.horizontalCenter = 0;
			zoomContainer.verticalCenter = 0;
			editorViewPort.addElement(zoomContainer);
			
			
			//mapBackGround
			_mapBackground = new MapBackground();
			_mapBackground.name = "mapBackground";
			_mapBackground.editMode = this.editMode;
			_mapBackground.identificationId = this.identificationId;
			_mapBackground.percentWidth = 100;
			_mapBackground.percentHeight = 100;
			_mapBackground.tobitMapInfo = this.tobitMapInfo;
			zoomContainer.addElement(_mapBackground);
			
			// TobitItemDefinition
			if(!_tobitItemDefinition)
				_tobitItemDefinition = new TobitItemDefinition();

			//mapeEditor
			_mapEditor = new MapEditor(); 
			_mapEditor.tobitItemDefinition = tobitItemDefinition;
			_mapEditor.addEventListener(TobitMapEvent.CHANGED_EDITOR_MODE, changedEditorModeHandler);
			_mapEditor.componentFactory = new TobitComponentFactory();
			_mapEditor.addEventListener(TobitMapEvent.SYMBOL_CREATE_COMPLETE, createCompleteHandler);
			_mapEditor.width = 1280;
			_mapEditor.height = 768;
			_mapEditor.percentWidth = 100;
			_mapEditor.percentHeight = 100;
			// 그룹아이디 설정
			if (this.groupId) {
				_mapEditor.groupId = this.groupId;
			}
			zoomContainer.addElement(_mapEditor); 
			
			// resizer 컨테이너를 생성하고 설정한다.
			_resizerContainer = new ResizerContainer();
			_resizerContainer.percentWidth = 100;
			_resizerContainer.percentHeight = 100;
			zoomContainer.addElement(_resizerContainer);
			
			_linePointContainer = new LinePointContainer();
			_linePointContainer.percentWidth = 100;
			_linePointContainer.percentHeight = 100;
			zoomContainer.addElement(_linePointContainer);
			
			propertyPanel = new PropertyPanel();
			propertyPanel.identificationId = this.identificationId;
			propertyPanel.x = this.width - 250;
			propertyPanel.width = 230;
			
			if(tobitMapInfo) {
				propertyPanel.tobitMapInfo = tobitMapInfo;
			}
			main.addElement(propertyPanel);
			
			componentPanel = new ComponentPanel();
			componentPanel.identificationId = this.identificationId;
			componentPanel.x = this.width - 460;
			componentPanel.width = 200;
			main.addElement(componentPanel);
			
			outlinePanel = new OutlinePanel();
			outlinePanel.identificationId = this.identificationId;
			outlinePanel.x = this.width - 220;
			outlinePanel.y = this.height / 1.5;
			outlinePanel.width = 200;
			main.addElement(outlinePanel);
			
			
			// Close Button
			/*closeBtn = new CloseButton();
			closeBtn.top = 5;
			closeBtn.right = 6;
			closeBtn.addEventListener(MouseEvent.CLICK, function():void{
				exitHandler(null);
			});
			this.addElement(closeBtn);*/
			
			//Navigator 생성
			//if(!_navigator){
			//	navigator = new Navigator();
			//}
			
			setMapEditMode();
		}
		
		protected function createCompleteHandler(event:Event):void
		{
			if(_mapEditor && _mapEditor.components) {
				/*if (!_outlineList) {
					_outlineList = new ArrayCollection();
				}
				_outlineList = _mapEditor.children;*/
				
				/*if (_ac_deleteList) {
					for each (var obj:Object in _mapEditor.children.source) {
						for each(var delObj:Object in _ac_deleteList.source) {
							if(obj.componentInfo == delObj) {
								_mapEditor.children.removeItemAt(_mapEditor.children.getItemIndex(obj));
							}
						}
					}
				}*/
//				outlinePanel.outlineList = _mapEditor.children;
			}
		}
		
		private var isChangedSize:Boolean = false;
		
		protected function viewPortResizeHandler(event:ResizeEvent):void
		{
			isChangedSize = true;
		}
		
		protected function mouseWheelHandler(event:MouseEvent):void
		{
			/*
			var transform:Matrix = mapEditor.transform.matrix;
			transform.translate(-0, -0);
			*/
			if(event.delta > 0){
				zoomIn();
				/*
				if(mapEditor.scaleX >= 10 ||
					mapEditor.scaleY >= 10)
					return;
				
				transform.scale(11/10, 11/10);
				*/
				
			}else if(event.delta < 0){
				zoomOut();
				/*
				if(mapEditor.scaleX <= 0.1 ||
					mapEditor.scaleY <= 0.1)
					return;
				
				transform.scale(10/11, 10/11);
				*/
			}
			
			/*
			transform.translate(0, 0);
			
			mapEditor.transform.matrix = transform;
			mapBackground.transform.matrix = transform;
			resizerContainer.transform.matrix = transform;
			linePointContainer.transform.matrix = transform;
			*/
			
		}
		
		protected function mouseUpHandler(event:MouseEvent):void
		{
			//overview 기능을 위한 process;
		}
		
		/**
		 * keyboardEventHandler
		 * MapEditor keyboardEventHandler과 연동
		 */
		protected function keyboardEventHandler(event:KeyboardEvent):void
		{
			// keyboardEvent focus problem solution
			mapEditor.keyboardEventHandler(event);
		}
		
		protected function menuChageEventHandler(event:MenuEvent):void
		{
			//Alert.show("menu change Event ! ");
		}
		protected function setMapEditMode():void
		{
			this.mapEditor.editMode =  this.resizerContainer.editMode= this.mapBackground.editMode = this.linePointContainer.editMode = this.editMode = true;
		}
		//----------------------------------
		//  ITobitItemDefinition 
		//----------------------------------
		private var _tobitItemDefinition:ITobitItemDefinition;
		
		private var _changedTobitItemDefinition:Boolean = false;
		
		public function set tobitItemDefinition(value:ITobitItemDefinition):void
		{
			//reset
			
			//set
			_tobitItemDefinition = value;
			
			//initialize
			
		}
		
		public function get tobitItemDefinition():ITobitItemDefinition
		{
			return _tobitItemDefinition;
		}
		
		
		//---------------------------------------------------------------
		//
		// Handler Function
		//
		//---------------------------------------------------------------
		
		/**
		 * 심볼 Drag Enter Event Handler
		 * 
		 * @param event
		 */
		
		/**
		 * 팝업 생성이 완료되었을떄
		 */
		private function creationCompleteHandler(event:FlexEvent):void{
			this.registerMediator();
			//facade.registerMediator(this);
			// 컴포넌트 목록 조회
			getComponentList();

			getMap();
			getInterface();
		}
		
		/**
		 * 팝업이 사라질때 호출된다.
		 */
		private function removeHandler(event:FlexEvent):void{
			facade.removeGroupView(this.identificationId);
			
			this.removeMediator();
		}
		
		protected function mapEditor_dragEnterHandler(event:DragEvent):void
		{
			if( event.dragSource.hasFormat("treeItems")){
				// tree 컴포넌트에서 드래그 된 것을 처리하도록 한다.
				var targetArr:Array = event.dragSource.dataForFormat( "treeItems" ) as Array;
				
				for each(var node:Object in targetArr){
					if(node.hasOwnProperty("children")){
						if(node["children"] && node["children"]["length"] > 0){
							return;
						}
					}
					
					//트리 그룹일경우 리턴
					if( node.componentName == "GROUP" )
						return;
				}
			}
			
			// drag and drop 데이터를 받아들인다. 
			if(event.currentTarget is UIComponent){
				DragManager.acceptDragDrop(event.currentTarget as UIComponent);
			}
		}
		
		protected function moveSymbolProc( mousePoint:Point, stagePoint:Point, targets:ArrayCollection):void
		{
			var gapX:Number = -1;
			var gapY:Number = -1;
			var tX:int = 0;
			var tY:int = 0;
			
			for( var i:int=0; i<targets.length; i++ )
			{
				var target:TobitComponent = TobitComponent(targets[i]);
				
				if( target == _mapEditor.selectedComponent )
				{
					// 현재 타겟의 좌표를 저장해 둔다. 
					var targetBeforePoint:Point = new Point( target.x, target.y );
					// 변경된 타겟의 좌표 값 = 변경된 실제 좌표 값 - 타겟 중심으로부터의 offset   
					tX = _mapEditor.mouseX - _mapEditor.selectedComponent.mouseOffset.x;
					tY = _mapEditor.mouseY - _mapEditor.selectedComponent.mouseOffset.y;
					// 이전 좌표 값과의 차이 값  = 변경된 타겟의 좌표값 - 타겟의 이전 좌표 값   
					gapX = tX - targetBeforePoint.x;
					gapY = tY - targetBeforePoint.y;
					
					break;
				}
			}
			
			_mapEditor.addCoordinates("x", gapX);
			_mapEditor.addCoordinates("y", gapY);
		}
		
		protected override function commitProperties():void
		{
			super.commitProperties();
			if(changedDataprovider)
			{
				changedDataprovider = false;
				if(mapEditor)
				{
					mapEditor.collection = collection;
					outlinePanel.outlineList = mapEditor.children;
				}
			}
			
			if(changedMapId)
			{
				changedMapId = false;
				if(mapEditor)mapEditor.mapId = this.mapId;
			}
			
			// 맵편집 컴포넌트 등록
			if(_changedMapEditor){
				_changedMapEditor = false;
				if(mapEditor){
					if(zoomContainer.getChildIndex(mapEditor) == -1){
						zoomContainer.addElement(mapEditor);
					}
				}
			}
			
			// 배경을 컴포넌트를 등록
			if(_changedMapBackground){
				_changedMapBackground = false;
				if(mapBackground){
					zoomContainer.addElement(mapBackground);
				}
				_changedComponentOrder = true;
			}
			
			//네비게이터
			if(_changedNavigator){
				_changedNavigator = false;
				if(_navigator){
					this.addElementAt(_navigator, 0);
				}
			}
			
			if(_changedSymbolValues){
				_changedSymbolValues = true;
				
				if(_mapEditor){
					_mapEditor.symbolValues = this.symbolValues;
				}
			}
			
			if (_changeMapType) {
				_changeMapType = false;
				
				
				var toolBars:Array = [
					{label:"저장", type:"save", icon:"save", style:"save", selectable:"N"},
					{label:"실행취소", type:"cancel", icon:"defaultIcon", style:"cancel", selectable:"N"},
					{label:"다시실행", type:"redo", icon:"defaultIcon", style:"redo", selectable:"N"},
					{label:"선", type:"line_s", icon:"defaultIcon", style:"line", selectable:"Y", children:[
						{label:"직선", type:"line_s", icon:"straightLine"}, 
						{label:"곡선", type:"line_ap", icon:"cirveLine"},
						{label:"꺽은선", type:"line_p", icon:"polygonLine"},
						{label:"처리흐름", type:"line_ss", icon:"straightLine"},
						{label:"처리흐름", type:"line_ps", icon:"polygonLine"}
						 
					]},
					{label:"텍스트 입력상자", type:"text", icon:"defaultIcon", style:"text", selectable:"Y"},
					{label:"기본도형", type:"rectangle", icon:"defaultIcon", style:"rectangle", selectable:"Y", children:[
						{label:"사각형", type:"rectangle", icon:"rectangle"}, 
						{label:"둥근 모서리 사각형", type:"rectangle_c", icon:"rediusRectangle"},
						{label:"삼각형", type:"triangle", icon:"triangle"},
						{label:"다각형", type:"polygon", icon:"polygon"},
						{label:"원", type:"circle", icon:"circle"}]},
					{label:"블록 화살표", type:"ra", icon:"defaultIcon", style:"ra", selectable:"Y", children:[
						{label:"좌", type:"arrow_left", icon:"arrowLeft"}, 
						{label:"우", type:"arrow_right", icon:"arrowRight"},
						{label:"상", type:"arrow_top", icon:"arrowTop"},
						{label:"하", type:"arrow_bottom", icon:"arrowBottom"}
					]},
					{label:"정렬", type:"al", icon:"defaultIcon", style:"align", selectable:"N", children:[
						{label:"왼쪽 맞춤", type:"align_left", icon:"alignLeft"},
						{label:"가운데 맞춤", type:"align_middle", icon:"alignMiddle"},
						{label:"오른쪽 맞춤", type:"align_right", icon:"alignRight"},
						{label:"위쪽 맞춤", type:"align_top", icon:"alignTop"},
						{label:"중간 맞춤", type:"align_center", icon:"alignCenter"},
						{label:"아래쪽 맞춤", type:"align_bottom", icon:"alignBottom"},
						{label:"가로 간격을 동일하게", type:"align_width", icon:"alignWidth"},
						{label:"세로 간격을 동일하게", type:"align_height", icon:"alignHeight"}
					]},
					{label:"이미지업로드", type:"upload", icon:"save", style:"upload", selectable:"Y"}
				];
				
				switch(mapType)
				{
					case "CD00000041":
						// 업무 노드
						toolBars.push({label:"자산", type:"bizNode", icon:"defaultIcon", style:"server", selectable:"N"});
						break;
					case "CD00000042":
						// 업무 그룹
						toolBars.push({label:"그룹", type:"bizGroup", icon:"defaultIcon", style:"group", selectable:"N"});
						break;
					case "CD00000043":
						// 자산 그룹
						toolBars.push({label:"그룹", type:"assetGroup", icon:"defaultIcon", style:"group", selectable:"N"});
						break;
					case "CD00000053":
						// 자산 노드
						toolBars.push({label:"자산", type:"assetNode", icon:"defaultIcon", style:"server", selectable:"N"});
						break;
				}
				
				this._toolBar.dataProvider = toolBars;
			}
			
			invalidateDisplayList();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			setContextMenu();
			
			if(_changedComponentOrder)
			{
				_changedComponentOrder = false;
				
				if(linePointContainer)
					if(linePointContainer.parent == zoomContainer)
						zoomContainer.setElementIndex(linePointContainer, 0)
				
				if(resizerContainer)
					if(resizerContainer.parent == zoomContainer)
						zoomContainer.setElementIndex(resizerContainer, 0)
				
				if(mapEditor)
					if(mapEditor.parent == zoomContainer)
						zoomContainer.setElementIndex(mapEditor, 0);
				
				if(mapBackground)
					if(mapBackground.parent == zoomContainer)
						zoomContainer.setElementIndex(mapBackground, 0);
			}
			
			if (changeMapInfo) {
				changeMapInfo = false;
				
				var mapWidth:Number = 0;
				var mapHeight:Number = 0;
				
				if (ownerMap) {
					mapWidth = ownerMap.width;
					mapHeight = ownerMap.height;
				} else {
					mapWidth = this.width;
					mapHeight = this.height;
				}
				
				if (_tobitMapInfo) {
					// 레이아웃 설정값을 적용
					if (_tobitMapInfo.layout == "fixed") {
						mapWidth = Number(_tobitMapInfo.width);
						mapHeight = Number(_tobitMapInfo.height);
						
						mapWidth = Math.max(mapWidth, Number(_tobitMapInfo.minWidth));
						mapHeight = Math.max(mapHeight, Number(_tobitMapInfo.minHeight));
					}
				}
				
				zoomContainer.width = mapWidth;
				zoomContainer.height = mapHeight;
				
				if(tobitMapInfo != null){
					_mapBackground.tobitMapInfo = tobitMapInfo;
				}
			}

			
			this.graphics.clear();
			/**
			 * map background color
			 */
			this.graphics.beginFill(0x201E20, 1);
			
			this.graphics.drawRect(0, 0, this.width, this.height);
			
			this.graphics.endFill();
		}
		
		
		
		protected function setContextMenu():void
		{
			// 편집모드에서 ContextMenu 
			var reContext:ContextMenu = new ContextMenu();
			reContext.hideBuiltInItems();
			
			var menuItem:ContextMenuItem = null;
			
			if( editMode )
			{
				menuItem = new ContextMenuItem("undo");
				menuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, undoHandler);
				reContext.customItems.push( menuItem );
				
		
				
				/*menuItem = new ContextMenuItem("exit");
				menuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, exitHandler);
				reContext.customItems.push( menuItem );*/
			}
		
			this.contextMenu = reContext;
		}
		
		protected function undoHandler(event:ContextMenuEvent):void
		{
			this._mapEditor.undo();
		}		
		
		
		/**
		 * 심볼 더블클릭시 수행 하는 Navigator hander
		 * 
		 * @param event 심볼에서 넘어오는 이벤트
		 * 
		 */
		protected function symbolDoubleClickToNavigatorHandler(event:TobitMapEvent):void{
			
			try {
				if( !_navigator ) return;
				
				var item:ComponentInfo = event.data as ComponentInfo;
				_navigator.addItem( new NavigatorItem(item.label, item.subMapId) );
				
			} catch( error:Error ) {
				trace("BMSMapEditor", "navigatorSymbolDoubleClickHandler error: ", error.message );
			}
			
		}
		
		/**
		 * 심볼 더블클릭시 수행 하는 Navigator hander
		 * 
		 * @param event 심볼에서 넘어오는 이벤트
		 * 
		 */
		protected function symbolDoubleClickFromNavigatorHandler(event:TobitMapEvent):void{
			
			try {
				//편집중이면,,, 종료
				if( editMode ) {
					event.stopImmediatePropagation();
					return;
				}
				
				if( !_navigator ) {
					event.stopImmediatePropagation();
					return;
				}
				
				var item:NavigatorItem = event.data as NavigatorItem;
				
				//같으면 이벤트 bubbling stop
				if( item.mapId == mapId ) {
					event.stopImmediatePropagation();
				} else {
					_navigator.removeItem(item);
				}
				
			} catch( error:Error ) {
				trace("BMSMapEditor", "navigatorSymbolDoubleClickHandler error: ", error.message );
			}
			
		}

		protected function menuItemClickEventHandler(event:MenuEvent):void
		{
			//Alert.show("menu item Click event!");
			var itemName:String = event.item.label ; 
			
			switch(itemName)
			{
				/*case "종료":
				{
					exitHandler(null);
					break;
				}*/
					
				case "템플릿 가져오기":
				{
					if (!templateListPopup) {
						templateListPopup = PopUpManager.createPopUp(this, TemplateListPopup, false) as TemplateListPopup;
						templateListPopup.cbFunction = templateCallBackFunction;
						templateListPopup.addEventListener(CloseEvent.CLOSE, templateListPopupCloseHandler);
					}
					break;
				}
					
				case "템플릿으로 저장":
				{
					if (!templatePopup) {
						templatePopup = PopUpManager.createPopUp(this, TamplatePagePopup, false) as TamplatePagePopup;
						templatePopup.mapName = tobitMapInfo.mapName;
						templatePopup.cbFunction = templateNameCallBackFunction;
						templatePopup.addEventListener(CloseEvent.CLOSE, namePopupCloseHandler);
					}
					break;
				}
				
				case "공통노드로 저장":
				{
					if (!templatePopup) {
						templatePopup = PopUpManager.createPopUp(this, TamplatePagePopup, false) as TamplatePagePopup;
						templatePopup.mapName = tobitMapInfo.mapName;
						templatePopup.cbFunction = commonNameCallBackFunction;
						templatePopup.addEventListener(CloseEvent.CLOSE, namePopupCloseHandler);
					}
					break;
				}
					
				case "저장":
				{
					saveMap(null);
					break;
				}
					
				case "새로만들기(Clear)":
				{
					this._mapEditor.allSelected();
					this._mapEditor.removeSelectedSymbol();
					break;
				}
					
				case "Undo":
				{
					this._mapEditor.undo();
					break;
				}
				case "Redo":
				{
					this._mapEditor.redo();
					break;
				}
				case "Cut":
				{
					this._mapEditor.cut();
					break;
				}
				case "Copy":
				{
					this._mapEditor.copy();
					break;
				}
				case "Paste":
				{
					this._mapEditor.paste();
					break;
				}
				case "Zoom In":
				{
					zoomIn();
					break;
				}
				case "Zoom Out":
				{
					zoomOut();
					break;
				}
				case "To Front":
				{
					this._mapEditor.bringToFirst(this._mapEditor.selectedComponent);
					break;
				}
				case "Forward":
				{
					this._mapEditor.bringToFront(this._mapEditor.selectedComponent);
					break;
				}
				case "To Back":
				{
					this._mapEditor.sendToLast(this._mapEditor.selectedComponent);
					break;
				}
				case "Backward":
				{
					this._mapEditor.sendToBack(this._mapEditor.selectedComponent);
					break;
				}
				case "Grid":
				{
					//mapbackground
					/*if(editorViewPort.containsElement(mapBackground)){
						editorViewPort.removeElement(mapBackground);
					}else{
						editorViewPort.addElement(mapBackground);
					}*/
					if(mapBackground.editMode)
						mapBackground.editMode= false;
					else 
						mapBackground.editMode = true;
					break;
				}
				case "Show All":
				{
					showAll();
					
					break;
				}	
				case "Actual Size":
				{
					actualSize();
					break;
				}	
				case "About Tobit":
				{
					
					break;
				}
				case "Export":
				{
					// 현재 맵정보를 XML문서로 생성하여 다운받도록한다.
					exportMap();
					break;
				}
				case "Import":
				{
					//import할 파일을 선택한 후 파일업로드를 시작한다.
					var fr:FileReference = new FileReference();
					fr.addEventListener(Event.SELECT, selectHandler);
					fr.addEventListener(Event.COMPLETE, uploadCompleteHandler);
					fr.addEventListener(IOErrorEvent.IO_ERROR, uploadErrorHandler);
					fr.addEventListener(SecurityErrorEvent.SECURITY_ERROR, uploadSecurityErrorHandler);
					fr.addEventListener(ProgressEvent.PROGRESS, uploadProgress);
					fr.browse();
					
					break;
				}
				default:
				{
					break;
				}
			}
		}
		private function templateCallBackFunction(item:TobitMapInfo):void {
			// 맵 아이디 확인
			if(item.mapId){
				// 현재 맵이 등록되어 있는지 확인후 요청
				if(facade.hasMediator(this.mediatorName)){
					// 맵정보 조회 요청
					
					sendTobitRTMP(TobitMapNotifications.TEMPLATE_GET_MAP, {mapId:item.mapId});
					templateListPopup = null;
				}
			}
		}
		
		private function templateNameCallBackFunction(item:String):void {
			commonTemplateSaveMap(item, "template", null);
			templatePopup = null;
		}
		
		private function commonNameCallBackFunction(item:String):void {
			commonTemplateSaveMap(item, "common", null);
			templatePopup = null;
		}
		
		private function selectHandler(event:Event):void
		{
			var fr:FileReference = event.currentTarget as FileReference;
			
			var variables:URLVariables = new URLVariables();
			variables.type=fr.type
			variables.savedName = fr.name;
			
			var urlRequest:URLRequest = new URLRequest(DomainUtil.getDomain() + "/fileUpload");
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = variables;
			
			fr.upload(urlRequest, "FileData", false);
		}
		
		// Get upload progress
		private function uploadProgress(event:ProgressEvent):void
		{
			var value:Number = Math.round((event.bytesLoaded / event.bytesTotal) * 100);
		}
		
		// XML Called on upload complete
		private function uploadCompleteHandler(event:Event):void
		{
			var fr:FileReference = event.currentTarget as FileReference;
			importMap(fr.name);
		}
		//Image uplooad complete
		private function imageUploadCompleteHandler(event:Event):void
		{
			var fr:FileReference = event.currentTarget as FileReference;
			var item:ComponentInfo = tobitItemDefinition.createTobitItem(TobitComponentDefinition.TOBIT_IMAGE);
			item.mapId = this.mapId;
			item.width = "0";
			item.height = "0";
			item.updateProperty("ImageName",fr.name);
			mapEditor.collection.addItem(item);
		}
		
		// Called on upload io error
		private function uploadErrorHandler(event:IOErrorEvent):void
		{
			Alert.show("파일업로드중 오류가 발생하였습니다.", "파일전송 오류");
		}
		
		// Called on upload security error
		private function uploadSecurityErrorHandler(event:SecurityErrorEvent):void
		{
			Alert.show("파일업로드중 알수없는 오류가 발생하였습니다.", "파일전송 오류");
		}
		
		protected function itemClickHandler(event:ToolEvent):void
		{
			switch(event.toolItemType)
			{
				case "save":
					saveMap(null);
					break;
				
				case "cancel":
					break;
				
				case "line_s":
					//라인타입 선택 후, 모든 리사이즈 표시 지우기
					this.mapEditor.unSelected();
					facade.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					//라인타입을 선택한 후 라인을 그리는 모드로 전환된다.
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.LINE_DRAW_MODE);
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_STRAIGHT_LINE;
					break;
				
				case "line_as":
					//라인타입 선택 후, 모든 리사이즈 표시 지우기
					this.mapEditor.unSelected();
					facade.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					//라인타입을 선택한 후 라인을 그리는 모드로 전환된다.
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.LINE_DRAW_MODE);
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_STRAIGHT_ARRAY_LINE;
					break;
					
				case "line_p":
					//라인타입 선택 후, 모든 리사이즈 표시 지우기
					this.mapEditor.unSelected();
					facade.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					//라인타입을 선택한 후 라인을 그리는 모드로 전환된다.
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.LINE_DRAW_MODE);
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_CROOKED_LINE;
					break;
				
				
				case "line_ss":
					this.mapEditor.unSelected();
					facade.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					// 
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.LINE_DRAW_MODE);
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_PROGRESS_STRAIGHT_LINE;
					break;
				
				case "line_ps":
					this.mapEditor.unSelected();
					facade.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					// 
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.LINE_DRAW_MODE);
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_PROGRESS_CROOKED_LINE;
					break;
					
				case "line_ap":
					//라인타입 선택 후, 모든 리사이즈 표시 지우기
					this.mapEditor.unSelected();
					facade.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					//라인타입을 선택한 후 라인을 그리는 모드로 전환된다.
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.LINE_DRAW_MODE);
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_CURVE_LINE;
					break;
				    
				case "line_c":
					//라인타입 선택 후, 모든 리사이즈 표시 지우기
					this.mapEditor.unSelected();
					facade.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					//라인타입을 선택한 후 라인을 그리는 모드로 전환된다.
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.LINE_DRAW_MODE);
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_CURVE_ARRAY_LINE;
					break;
					
				case "text":
					//텍스트 박스 선택 후, 모든 리사이즈 표시 지우기
					this.mapEditor.unSelected();
					this.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					//텍스트 박스를 선택한 후 텍스트 박스를 그리는 모드로 전환된다.
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.SHAPE_DRAW_MODE);
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_TEXTAREA;
					break;
				
				case "rectangle":
					//사각형 선택 후, 모든 리사이즈 표시 지우기
					this.mapEditor.unSelected();
					this.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					//사각형을 선택한 후 사각형을 그리는 모드로 전환된다.
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.SHAPE_DRAW_MODE);
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_BOX;
					break;
				
				case "rectangle_c":
					//둥근 모서리 사각형 선택 후, 모든 리사이즈 표시 지우기
					this.mapEditor.unSelected();
					this.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					//둥근 모서리 사각형을 선택한 후 둥근 모서리 사각형을 그리는 모드로 전환된다.
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.SHAPE_DRAW_MODE);
					MapSystem.cornerRadius = 5;
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_BOX;
					break;
				
				case "triangle":
					//삼각형 선택 후, 모든 리사이즈 표시 지우기
					this.mapEditor.unSelected();
					this.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					//삼각형을 선택한 후 삼각형을 그리는 모드로 전환된다.
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.SHAPE_DRAW_MODE);
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_TRIANGLE;
					break;
				
				case "polygon":		//미구현 기능
					//다각형 선택 후, 모든 리사이즈 표시 지우기
					this.mapEditor.unSelected();
					this.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.POLYGON_DRAWING_MODE);
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_POLYGON;
					break;
				
				case "circle":
					//원 선택 후, 모든 리사이즈 표시 지우기
					this.mapEditor.unSelected();
					this.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					//원을 선택한 후 원을 그리는 모드로 전환된다.
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.SHAPE_DRAW_MODE);
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_CIRCLE;
					break;
				
				case "arrow_left":
					//좌방향 화살표 선택 후, 모든 리사이즈 표시 지우기
					this.mapEditor.unSelected();
					this.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					//좌방향 화살표를 선택한 후 좌방향 화살표를 그리는 모드로 전환된다.
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.SHAPE_DRAW_MODE);
					MapSystem.direction = ComponentInfo.DIRECTION_LEFT;
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_ARROW_SHAPE;
					break;
				
				case "arrow_right":
					//우방향 화살표 선택 후, 모든 리사이즈 표시 지우기
					this.mapEditor.unSelected();
					this.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					//우방항 화살표를 선택한 후 우방향 화살표를 그리는 모드로 전환된다.
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.SHAPE_DRAW_MODE);
					MapSystem.direction = ComponentInfo.DIRECTION_RIGHT;
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_ARROW_SHAPE;
					break;
				
				case "arrow_top":
					//상방향 화살표 선택 후, 모든 리사이즈 표시 지우기
					this.mapEditor.unSelected();
					this.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					//상방향 화살표를 선택한 후 상방향 화살표를 그리는 모드로 전환된다.
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.SHAPE_DRAW_MODE);
					MapSystem.direction = ComponentInfo.DIRECTION_TOP;
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_ARROW_SHAPE;
					break;
				
				case "arrow_bottom":
					//하방향 화살표 선택 후, 모든 리사이즈 표시 지우기
					this.mapEditor.unSelected();
					this.sendNotificationToGroupView(this.identificationId, TobitMapNotifications.REMOVE_RESIZERS);
					//하방향 화살표를 선택한 후 하방향 화살표를 그리는 모드로 전환된다.
					this.mapEditor.changeEditingMode(MapEditorModeDefinition.SHAPE_DRAW_MODE);
					MapSystem.direction = ComponentInfo.DIRECTION_BOTTOM;
					MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_ARROW_SHAPE;
					break;
				
				case "align_left":
					//좌로 정렬 선택한 후 좌로 정렬이 적용된다.
					this.mapEditor.alignComponents(MapEditorModeDefinition.ALIGN_LEFT);
					break;
				
				case "align_middle":
					//가운데 정렬 선택한 후 가운데 정렬이 적용된다.
					this.mapEditor.alignComponents(MapEditorModeDefinition.ALIGN_MIDDLE);
					break;
				
				case "align_right":
					//우로 정렬 선택한 후 우로 정렬이 적용된다.
					this.mapEditor.alignComponents(MapEditorModeDefinition.ALIGN_RIGHT);
					break;
				
				case "align_top":
					//상단 정렬 선택한 후 상단 정렬이 적용된다.
					this.mapEditor.alignComponents(MapEditorModeDefinition.ALIGN_TOP);
					break;
				
				case "align_center":
					//중간 정렬 선택한 후 중간 정렬이 적용된다.
					this.mapEditor.alignComponents(MapEditorModeDefinition.ALIGN_CENTER);
					break;
				
				case "align_bottom":
					//하단 정렬 선택한 후 하단 정렬이 적용된다.
					this.mapEditor.alignComponents(MapEditorModeDefinition.ALIGN_BOTTOM);
					break;
				
				case "align_width":
					//가로 간격을 동일하게 선택한 후 가로 간격을 동일하게 적용된다.
					this.mapEditor.alignComponents(MapEditorModeDefinition.ALIGN_WIDTH);
					break;
				
				case "align_height":
					//세로 간격을 동일하게 선택한 후 세로 간격을 동일하게 적용된다.
					this.mapEditor.alignComponents(MapEditorModeDefinition.ALIGN_HEIGHT);
					break;
				case "upload":
				{
					var imageUpload:FileReference = new FileReference();
					imageUpload.addEventListener(Event.SELECT, selectHandler);
					imageUpload.addEventListener(Event.COMPLETE, imageUploadCompleteHandler);
					imageUpload.addEventListener(IOErrorEvent.IO_ERROR, uploadErrorHandler);
					imageUpload.addEventListener(SecurityErrorEvent.SECURITY_ERROR, uploadSecurityErrorHandler);
					imageUpload.addEventListener(ProgressEvent.PROGRESS, uploadProgress);
					imageUpload.browse();
					
					//MapSystem.createTobitComponent = TobitComponentDefinition.TOBIT_IMAGE;
					break;
				}
				case "bizGroup":
				case "assetGroup":
				{
					// 그룹노드 팝업
					if (!groupTreePopup) {
						groupTreePopup = PopUpManager.createPopUp(this, GroupTreePopup, false) as GroupTreePopup;
						groupTreePopup.groupType = event.toolItemType;
						groupTreePopup.addEventListener(CloseEvent.CLOSE, groupTreePopupCloseHandler);
					}
					break;
				}
				case "bizNode":
				case "assetNode":
				{
					if (!nodeTreePopup) {
						nodeTreePopup = PopUpManager.createPopUp(this, NodeTreePopup, false) as NodeTreePopup;
						nodeTreePopup.nodeType = event.toolItemType;
						nodeTreePopup.groupId = this.groupId;
						nodeTreePopup.addEventListener(CloseEvent.CLOSE, nodeTreePopupCloseHandler);
					}
					break;
				}
			}
		}
		
		protected function nodeTreePopupCloseHandler(event:CloseEvent):void
		{
			nodeTreePopup.removeEventListener("close", nodeTreePopupCloseHandler);
			PopUpManager.removePopUp(nodeTreePopup);
			nodeTreePopup = null;
		}
		
		protected function templateListPopupCloseHandler(event:CloseEvent):void
		{
			templateListPopup.removeEventListener("close", templateListPopupCloseHandler);
			PopUpManager.removePopUp(templateListPopup);
			templateListPopup = null;
		}
		
		protected function namePopupCloseHandler(event:CloseEvent):void {
			templatePopup.removeEventListener("close", namePopupCloseHandler);
			PopUpManager.removePopUp(templatePopup);
			templatePopup = null;
		}
		
		private function groupTreePopupCloseHandler(event:Event):void
		{
			groupTreePopup.removeEventListener("close", groupTreePopupCloseHandler);
			PopUpManager.removePopUp(groupTreePopup);
			groupTreePopup = null;
		}

		/*protected function exitHandler(event:ContextMenuEvent):void
		{
			if( updateMapInfo ) {
				Alert.show( "안내", "저장 후 종료하시겠습니까?", 
					Alert.YES|Alert.NO|Alert.CANCEL, null, exitAlertHandler );	
			} else if( ( _ac_insertList == null && _ac_deleteList == null && _ac_updateList == null ) || 
				( _ac_insertList.length == 0 && _ac_deleteList.length == 0 && _ac_updateList.length == 0 ) )
			{
				Alert.show(  "종료하시겠습니까?","안내", Alert.YES|Alert.NO, null, exitAlert );
			} else {
				// 변경된 것이 있다면
				Alert.show( "안내", "저장 후 종료하시겠습니까?", 
					Alert.YES|Alert.NO|Alert.CANCEL, null, exitAlertHandler );	
			}
		}*/
		
		public function updateDataReset():void{
			_ac_deleteList = new ArrayCollection();
			_ac_insertList = new ArrayCollection();
			_ac_updateList = new ArrayCollection();
		}
		
		protected function exitAlert( event:CloseEvent ):void
		{
			if( event.detail == Alert.YES )
			{
				closeBMSMapEditor();
			}
			else if( event.detail == Alert.NO )
			{
				// 종료 시키지 않는다. 
				return;
			}
		}
		
		
		/**
		 * 편집 모드 종료시 변경된 것이 있다면  
		 * 
		 * @param event
		 */
		protected function exitAlertHandler( event:CloseEvent ):void
		{
			
			if(event.detail == Alert.CANCEL)
				return ;
			if( event.detail == Alert.YES )
			{
				updateMapInfo = false;
				
				_isExitSave = true;
				//저장
				saveMap(null);
			}
			else if( event.detail == Alert.NO )
			{
				//종료
				closeBMSMapEditor();
			}
		}
		
		private function closeBMSMapEditor():void {
			// remove groupTreePopup
			if (groupTreePopup) {
				PopUpManager.removePopUp(groupTreePopup);
				groupTreePopup = null;
			}
			// remove assetTreePopup
			if (nodeTreePopup) {
				PopUpManager.removePopUp(nodeTreePopup);
				nodeTreePopup = null;
			}
			// remove templateListPopup
			if (templateListPopup) {
				PopUpManager.removePopUp(templateListPopup);
				templateListPopup = null;
			}
			// remove templatePopup
			if (templatePopup) {
				PopUpManager.removePopUp(templatePopup);
				templatePopup = null;
			}
			// reset component list
			this.dataProvider = null;
			
			removeHandler(null);
			
			//종료
			var e:TobitMapEvent  = new TobitMapEvent(TobitMapEvent.EDIT_MODE_END) ;
			e.data = updateFlag;
			dispatchEvent(e);
		}
		
		
		public function resetMap():void{
		//	this.mapEditor.editMode = this.mapBackground.editMode = this.resizerContainer.editMode = this.linePointContainer.editMode = this.editMode = false;
			for(var i:int = collection.length-1 ; i >= 0 ; i--)
			{
				collection.removeItemAt(0);
			}
		}
		
		public function zoomIn():void{
			var transform:Matrix = zoomContainer.transform.matrix;
			if(zoomContainer.scaleX >= 10 ||
				zoomContainer.scaleY >= 10)
				return;
			
			transform.scale(11/10, 11/10);
			zoomContainer.transform.matrix = transform;
		}
		
		public function zoomOut():void{
			var transform:Matrix = zoomContainer.transform.matrix;
			
			if(zoomContainer.scaleX <= 0.1 ||
				zoomContainer.scaleY <= 0.1)
				return;
			
			transform.scale(10/11, 10/11);
			
			zoomContainer.transform.matrix = transform;
		}
		
		public function showAll( ):void{
			//10: padding 값
			//this.width -(propertiesGroup.width + vGroup.left) - (20);
			var mapEditorWidth:int = mapEditorContainer.width;
			//this.height - (vGroup.top + menuBar.height+ toolBarContainer.height ) - (20);
			var mapEditorHeight:int = mapEditorContainer.height;
			
			var maxWidth:int = 0;
			var maxHeight:int = 0;
			
			for(var i:int = 0;i<_mapEditor.numElements ;i++){
				if(maxWidth <  (_mapEditor.getElementAt(i).x + _mapEditor.getElementAt(i).width)* _mapEditor.scaleX ){
					maxWidth =  (_mapEditor.getElementAt(i).x + _mapEditor.getElementAt(i).width )*_mapEditor.scaleX ;
				}
				if(maxHeight < ( _mapEditor.getElementAt(i).y + _mapEditor.getElementAt(i).height ) * _mapEditor.scaleY){
					maxHeight = ( _mapEditor.getElementAt(i).y +_mapEditor.getElementAt(i).height ) * _mapEditor.scaleY ;
				}
			}
			
			//화면밖으로 나온 component가 있을 경우에만 scale 조절
			if( (maxWidth > mapEditorWidth ) || (maxHeight > mapEditorWidth)){ 
				var scalex:Number = mapEditorWidth / maxWidth; 
				var scaley:Number = mapEditorHeight / maxHeight;
				
				var scale:Number = scalex < scaley ? scalex : scaley ;
				
				
				var transform:Matrix = zoomContainer.transform.matrix;
				
				transform.scale(scale, scale);
				
				zoomContainer.transform.matrix = transform;
				
			}
		}
		
		public function actualSize():void{
			zoomContainer.transform.matrix = new Matrix();
		}
		
		override public function styleChanged(styleProp:String):void{
			super.styleChanged(styleProp);
			updateBackground();
		}
		
		protected function updateBackground():void{
			var backgroundImage:Class = getStyle("backgroundImage");
			
			menubarBgSkin = getStyle("menubarBgSkin");
			menuDownSkin = getStyle("menuDownSkin");
			menuOverSkin = getStyle("menuOverSkin");
			menuUpSKin = getStyle("menuUpSkin");
			
			if (backgroundImage)
			{
				background = new BitmapImage();
				background.left = 0;
				background.right = 0;
				background.top = 0;
				background.bottom = 0;
				background.source = backgroundImage;
				
				addElementAt(IVisualElement(background), 0);
			}
			if(menuBar){
				menuBar.setStyle("backgroundSkin", menubarBgSkin);
				menuBar.setStyle("itemDownSkin", menuDownSkin);
				menuBar.setStyle("itemOverSkin", menuOverSkin);
				menuBar.setStyle("itemUpSkin", menuUpSKin);
			}
		}
	}
}