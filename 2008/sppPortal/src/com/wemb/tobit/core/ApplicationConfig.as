package com.wemb.tobit.core
{
	import com.wemb.tobit.vo.Configuration;
	import com.wemb.tobit.vo.MenuInfo;
	import com.wemb.tobit.vo.UserInfo;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	
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
		
		public var backgroundImage:String = "";	// 배경 이미지
		
		public var userInfo:UserInfo = new UserInfo();	// 사용자 정보
		
		public var menuList:Array;		// 사용자 접근 가능한 메뉴
		
		private var dic:Dictionary;
		
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
			if (instance == null) instance = new ApplicationConfig();
			return instance;
		}
		
		public function setApplicationConfig(value:Array):void
		{
			if(value){
				
				if(!dic)
					dic = new Dictionary();
				
				for each(var configuration:Configuration in value)
				{
					dic[configuration.name] = configuration.value;
					
					/*
					if(this.hasOwnProperty(configuration.name))
					{
						this[configuration.name] = configuration.value;
					}
					else
					{
						trace("[Not Found] - ", configuration.name);
					}
					*/
				}
			}
		}
		
		public function reset():void
		{
		}
		
		public function getDoaminName():String
		{
			var url:String = Application.application.url;
			
			var arr1:Array = url.split("//");
			if(arr1.length > 1 && arr1[1]){
				var arr2:Array = String(arr1[1]).split("/");
				if(arr2.length > 0 && arr2[0]){
					var arr3:Array = String(arr2[0]).split(":");
					if(arr3.length > 0 && arr3[0]){
						var hostname:String = arr3[0];
						return hostname;
					}
				}
			}
			
			return "";			
		}
		
		/**
		 * menuID를 이용하여 메뉴리스트를 조회한다.
		 */
		public function getChildMenu(id:String, list:Array = null):ArrayCollection
		{
			//list가 널이면 menuList를 기본값으로 셋팅하여 조회하도록 한다.
			if(!list)
				list = menuList;
			
			for each(var menuInfo:MenuInfo in list)
			{
				//ID를 비교한다.
				if(menuInfo.id == id)
				{
					return menuInfo.children as ArrayCollection;
				}else{
					if(menuInfo.children){
						// 자식 리스트를 가지고 있을경우 재귀함수 호출
						var result:ArrayCollection = getChildMenu(id, ArrayCollection(menuInfo.children).source);
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
				if(menuInfo.menuUrl == pageID){
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
		
		public function getMainMenuList():ArrayCollection
		{
			if(menuList && menuList.length > 0)
			{
				return MenuInfo(menuList[0]).children as ArrayCollection;
			}
			
			return null;
		}
		
		public function getAttribute(key:String):Object
		{
			try{
				//trace(">>>>", dic[key])
				return dic[key];
			} catch(err:Error){
				trace("xml 경로가 없습니다.");
				trace(err.toString());
			}
			return "";
		}
		
		public function setAttribute(key:String, value:String):void
		{
			trace("old = ", key, ":", dic[key])
			try{
				dic[key] = value;
			} catch(err:Error){
				trace(err.toString());
			}
			trace("new = ", key, ":", dic[key])
		}
	}
}