////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2011 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.vo
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="com.wemb.tobit.vo.Department")]
	[Bindable]
	public class Department
	{
		public var index:int;				// rowIndex
		public var level:int;					// level
		public var id:String;					// 부서 아이디
		public var name:String;			// 부서 이름
		public var parent:String;			// 상위 부서 아이디
		public var parentName:String;	// 상위 부서 이름
		public var description:String;
		public var order:String;
		public var enable:String;
				
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