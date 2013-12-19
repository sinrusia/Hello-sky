////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.core
{
	import com.wemb.tobit.pure.Constants;
	import com.wemb.tobit.vo.Configuration;
	import com.wemb.tobit.vo.EventNotiInfo;
	import com.wemb.tobit.vo.MenuInfo;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Menu;
	import mx.core.Application;
	import mx.core.FlexGlobals;
	
	[Bindable]
	/**
	 *  ApplicationConfig VO 객체
	 *  
	 *	<p>Application 설정 정보</p>
	 * 
	 *	@auther 고재학( sinrusia@wemb.co.kr)
	 */
	public class ApplicationConfig
	{
		private static var instance:ApplicationConfig;
		
		// 순차적 요청을 사용할지 여뷰
		public var SEQUENTIAL_CALL:Boolean = false;
		// 순차적 요청처리 시간간격
		public var REQUEST_INTERVAL:Number = 500;
		
		public var authStatus:String;
		
		public var backgroundImage:String = "";	// 배경 이미지
		
		public var menuList:Array;		// 사용자 접근 가능한 메뉴
		
		public var menu:MenuInfo;
		
		private var dic:Dictionary;
		
		private var codes:Dictionary;
		
		public var currentPageDepts:Array = new Array();
		
		public var valuationPersonId:String = "";
		
		public var selectedValuIndex:int = -1;
		
		public var locale:String = "";
		
		public var rotateInfo:ArrayCollection;
		
		/**
		 * S1100 : TOBIT
		 * S1200 : Xeniview
		 * S1300 : Asset
		 * S1400 : Operation
		 */
		public var solution:String;
		
		public function ApplicationConfig()
		{
			if(instance != null)
			{
				throw new Error("ApplicationConfig 싱글톤으로 생성 되어 있습니다.");
			}
		}
		
		/**
		 * Singleton ApplicationFacade Factory Method
		 */
		public static function getInstance(): ApplicationConfig
		{
			if (instance == null)
			{
				instance = new ApplicationConfig();
				instance.authStatus = Constants.LOGIN_OFF;
			}
			
			return instance;
		}
		
		public function setApplicationConfig(value:Array):void
		{
			if(value){
				
				if(!dic)
					dic = new Dictionary();
				
				for each(var configuration:Configuration in value)
				{
					dic[configuration.code] = configuration.value;
					
					procApplicationConfig(configuration);
				}
			}
		}
		
		private function procApplicationConfig(configuration:Configuration):void{
			switch(configuration.code)
			{
				// 순차적 요청을 사용할지 여부
				case "SEQUENTIAL_CALL":
					if(configuration.value == "Y")
						SEQUENTIAL_CALL = true;
					else
						SEQUENTIAL_CALL = false;
					break;
				
				case "REQUEST_INTERVAL":
					REQUEST_INTERVAL = Number(configuration.value);
					if(isNaN(REQUEST_INTERVAL))
						REQUEST_INTERVAL = 500;
					break;
					
				default:
				{
					break;
				}
			}
		}
		
		public function reset():void
		{
		}
		
		public function get location():String{
			var url:String = FlexGlobals.topLevelApplication.url;
			var location:String = url.substring(0, url.lastIndexOf("/"));
			return location;
		}		
		
		/**
		 * menuID를 이용하여 메뉴리스트를 조회한다.
		 */
		public function getChildMenu(menuID:String, list:Array = null):ArrayCollection
		{
			//list가 널이면 menuList를 기본값으로 셋팅하여 조회하도록 한다.
			if(!list)
				list = menuList;
			
			for each(var menuInfo:MenuInfo in list)
			{
				//ID를 비교한다.
				if(menuInfo.id == menuID)
				{
					return menuInfo.children as ArrayCollection;
				}else{
					if(menuInfo.children){
						// 자식 리스트를 가지고 있을경우 재귀함수 호출
						var result:ArrayCollection = getChildMenu(menuID, ArrayCollection(menuInfo.children).source);
						// null이 아니면 리턴한다.
						if(result)
							return result;
					}
				}
			}
			
			return null;
		}
		
		/**
		 * PageID를 이용하여 메뉴 정보를 가져온다.
		 * 
		 * 
		 */
		public function getMenuInfo(pageID:String, list:Array = null):MenuInfo
		{
			//list가 널이면 menuList를 기본값으로 셋팅하여 조회하도록 한다.
			if(!list)
				list = menuList;
			
			for each(var menuInfo:MenuInfo in list)
			{
				//PageID를 비교한다.
				if(menuInfo.id == pageID){
					return menuInfo;
				}else{
					if(menuInfo.children){
						// 자식 리스트를 가지고 있을경우 자식함수를 호출
						var info:MenuInfo = getMenuInfo(pageID, ArrayCollection(menuInfo.children).source);
						// null이 아니면 리턴한다.
						if(info)
							return info;
					}
				}
			}
			return null;
		}
		
		
		
		/**
		 * PageID를 이용하여 메뉴 정보를 가져온다.
		 * 
		 * 
		 */
		public function updateMenuDepts(pageID:String, list:Array = null):Boolean
		{
			//list가 널이면 menuList를 기본값으로 셋팅하여 조회하도록 한다.
			if(!list)
				list = menuList;
			
			for each(var menuInfo:MenuInfo in list)
			{
				//PageID를 비교한다.
				if(menuInfo.id == pageID){
					currentPageDepts = new Array();
					currentPageDepts.push(menuInfo);
					// 메뉴정보를 저장한다.
					return true;
				}else{
					if(menuInfo.children){
						// 자식 리스트를 가지고 있을경우 자식함수를 호출
						var status:Boolean = updateMenuDepts(pageID, ArrayCollection(menuInfo.children).source);
						// null이 아니면 리턴한다.
						if(status == true){
							// 현재 메뉴정보를 저장한다.
							currentPageDepts.push(menuInfo);
							return true;
						}
					}
				}
			}
			return false;
		}
		
		public function getMainMenuList():ArrayCollection
		{
			return new ArrayCollection(menuList);
			/*
			if(menuList && menuList.length > 0)
			{
				var root:MenuInfo = menuList[0];
				return root.children as ArrayCollection;
			}
			
			return null;
			*/
		}
		
		public function getAttribute(key:String):Object
		{
			try{
				return dic[key];
			} catch(err:Error){
				trace("xml 경로가 없습니다.");
				trace(err.toString());
			}
			return "";
		}
		
		public function setAttribute(key:String, value:Object):void {
			dic[key] = value;
		}
		
		public function getCodeList(code:String):Array
		{
			if(!codes)
				codes = new Dictionary();
			
			return codes[code];
		}
		
		public function setCodeList(code:String, list:Array):void
		{
			if(!codes)
				codes = new Dictionary();
			
			codes[code] = list;
		}
		
	}
}