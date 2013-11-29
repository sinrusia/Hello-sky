package com.wemb.tobit.managers
{
	/**
	 * Copyright (C) 2004-2009 WeMB INC. 
	 * All Rights Reserved.
	 **	@date			:	2009-04062
	 *	@auther			:	고재학
	 *	@ver			:	1.0
	 *	@description 	:	어플리케이션에서 관리하는 페이지 목록을 관리합니다.
	 */
	
	public class PageManager
	{
		//---------------------------------------------------------
		//	instance
		//---------------------------------------------------------
		private static var instance:PageManager;
		
		
		//---------------------------------------------------------
		//	private 
		//---------------------------------------------------------
		private var rootMenu:Object;
		
		
		//---------------------------------------------------------
		//	Sonstruct
		//---------------------------------------------------------
		public function PageManager()
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
		public static function getInstance():PageManager
		{
			if (instance == null) instance = new PageManager();
			return instance;
		}
		
		/**
		 * PageManager 초기화 함수
		 */
		public static function init():void
		{
			PageManager.getInstance();
		}
		
		
		/**
		 * 요청 페이지 Class정의를 리턴한다.
		 */
		public static function getPage(pageId:String):Class
		{
			return PageManager.getInstance().page(pageId);
		}
		
		/**
		 * 요청한 그룹의 기본 페이지 명을 리턴한다.
		 */
		public static function getDefaultPageName(groupId:String):String
		{
			return PageManager.getInstance().defaultPage(groupId);
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
		}
	}
}