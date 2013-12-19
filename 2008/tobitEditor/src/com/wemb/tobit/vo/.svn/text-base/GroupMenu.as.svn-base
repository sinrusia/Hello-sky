////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2011 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.vo
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="com.wemb.tobit.vo.GroupMenu")]
	[Bindable]
	public class GroupMenu
	{
		public var index:int;					// rowIndex
		public var lev:int;						// level
		public var id:String;					// 그룹 아이디
		public var name:String;					// 그룹 이름
		public var parent:String;				// 상위 그룹 아이디
		public var description:String;          // 그룹 설명
		public var satGroupType:String;  		// 그룹 타입
		public var symbolId:String;				//심볼 아이디
		public var symbolName:String;			//심볼명
		public var mapId:String;				// 맵 아이디
		public var isShare:String;				// 공유 여부
		public var sortOrder:String;			//정렬 순서
		public var componentName:String;        //컴포넌트 이름
		public var componentId:String;          //컴포넌트 ID
		private var _children:ArrayCollection;
		
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