

package com.wemb.tobit.managers
{
	import valuation.screens.ValuationPage0000;
	import valuation.screens.ValuationPage0001;
	import valuation.screens.ValuationPage0002;
	import valuation.screens.ValuationPage0003;
	import valuation.screens.ValuationPage0004;
	import valuation.screens.ValuationPage9999;
	
	/**
	 * Copyright (C) 2004-2009 WeMB INC. 
	 * All Rights Reserved.
	 **	@date			:	2009-04062
	 *	@auther			:	고재학
	 *	@ver			:	1.0
	 *	@description 	:	어플리케이션에서 관리하는 페이지 목록을 관리합니다.
	 */
	
	public class ValuationPageManager
	{
		//---------------------------------------------------------
		//	instance
		//---------------------------------------------------------
		private static var instance:ValuationPageManager;
		
		
		//---------------------------------------------------------
		//	private 
		//---------------------------------------------------------
		private var rootMenu:Object;
		
		
		//---------------------------------------------------------
		//	Sonstruct
		//---------------------------------------------------------
		public function ValuationPageManager()
		{
			if(!instance){
				initialize();
			}else{
				throw new Error("PageManager Error");
			}
		}
		
		
		//---------------------------------------------------------
		//
		//	static function
		//
		//---------------------------------------------------------
		public static function getInstance():ValuationPageManager
		{
			if (instance == null) instance = new ValuationPageManager();
			return instance;
		}
		
		/**
		 * PageManager 초기화 함수
		 */
		public static function init():void
		{
			ValuationPageManager.getInstance();
		}
		
		
		/**
		 * 요청 페이지 Class정의를 리턴한다.
		 */
		public static function getPage(pageId:String):Class
		{
			return ValuationPageManager.getInstance().page(pageId);
		}
		
		/**
		 * 요청한 그룹의 기본 페이지 명을 리턴한다.
		 */
		public static function getDefaultPageName(groupId:String):String
		{
			return ValuationPageManager.getInstance().defaultPage(groupId);
		}
		
		
		//---------------------------------------------------------
		//
		//	private function
		//
		//---------------------------------------------------------
		
		private function page(pageId:String):Class
		{
			return rootMenu[pageId] as Class;
			//return rootMenu[groupId][pageId] as Class;
		}
		
		private function defaultPage(groupId:String):String
		{
			return rootMenu[groupId];
		}
		
		
		/**
		 * Korail 종합 상황 시스템 페이지 구성 
		 * 
		 */
		private function initialize():void
		{
			rootMenu = new Object();
			
			rootMenu["ValuationPage0000"] = ValuationPage0000;
			rootMenu["ValuationPage0001"] = ValuationPage0001;
			rootMenu["ValuationPage0002"] = ValuationPage0002;
			rootMenu["ValuationPage0003"] = ValuationPage0003;
			rootMenu["ValuationPage0004"] = ValuationPage0004;
			rootMenu["ValuationPage9999"] = ValuationPage9999;
			
			
		}
	}
}