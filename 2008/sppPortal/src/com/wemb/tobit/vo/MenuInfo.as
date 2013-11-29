package com.wemb.tobit.vo
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="com.wemb.tobit.vo.MenuInfo")]
	[Bindable]
	public class MenuInfo
	{
		public var level:int;
		public var id:String;
		public var parent:String;
		public var menuCategory:String;
		public var menuName:String;
		public var menuOrder:String;
		public var menuUrl:String;
		public var menuUse:String;
		public var menuType:String;
		public var userId:String;
		
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