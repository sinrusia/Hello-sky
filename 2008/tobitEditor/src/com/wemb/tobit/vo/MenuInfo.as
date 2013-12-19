////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2011 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.vo
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="com.wemb.tobit.vo.MenuInfo")]
	[Bindable]
	public class MenuInfo
	{
		public var index:int;				// rowIndex
		public var level:int;				// level
		public var id:String;				// 메뉴 아이디
		public var name:String;				// 메뉴 이름
		public var parent:String;			// 부모 메뉴 아이디
		public var parentName:String;		// 부모 메뉴 이름
		public var url:String;				// 접근경로
		public var mapId:String;			// Dashboard 맵 아이디
		public var type:String;				// 페이지 타입
		public var order:String;			// 메뉴 순서
		public var enable:String;
		
		public var gradeId:String;
		public var gradeEnable:String;
		public var readYn:String;
		public var writeYn:String;
		public var updateYn:String;
		public var deleteYn:String;
		public var state:String;
		
		
		public var topMenu:Boolean = true;		// topMenu가 없을 경우 false 
		
		private var _children:ArrayCollection;
		public var selected:Boolean = false;
		
		public var params:Object;
		
		public function set children(value:Object):void
		{
			if(value is Array){
				_children = new ArrayCollection(value as Array);
			}else{
				_children = value as ArrayCollection;
			}
		}
		
		public function get children():Object
		{
			return _children;
		}
	}
}