/**
 *	Copyright (C) 2004-2009 WeMB INC. 
 *	All Rights Reserved.
 *	@date			:	2009-04-07
 *	@auther			:	고재학
 *	@ver			:	1.0
 *	@description 	:	
 *	
**/
package com.wemb.tobit.pure.view
{
	import com.wemb.tobit.core.ApplicationConfig;
	import com.wemb.tobit.pure.Constants;
	import com.wemb.tobit.vo.MenuInfo;
	import com.wemb.tobit.vo.MenuInfoChild;
	import com.wemb.tobit.vo.Request;
	import com.wemb.tobit.vo.UserInfo;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class PortalMediator extends Mediator
	{
		public static const NAME:String	= "PortalMediator";
		
		public function PortalMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				Constants.GET_USER_INFO,
				Constants.GET_MENU_LIST
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case Constants.GET_USER_INFO:
					rs_getUserInfo( notification.getBody() as Request );
					break;				
				case Constants.GET_MENU_LIST:
					rs_getMenuList( notification.getBody() as Request );
					break;
			}
		}
		
		private function rs_getUserInfo( request:Request ):void
		{
			ApplicationConfig.getInstance().userInfo = request.result as UserInfo;
	 	}
	 			
		private function rs_getMenuList( request:Request ):void
		{
			var menuArr:Array = new Array();
			var temp:ArrayCollection;
			
			if(request.result is Array) temp = new ArrayCollection(request.result as Array);
			else temp = request.result as ArrayCollection;

			for(var i:int=0; i<temp.length; i++)
			{
				var tempMenu:MenuInfo = temp[i];
				var menu:MenuInfoChild = makeMenu(tempMenu);
				menuArr.push(menu);
			}
			
			ApplicationConfig.getInstance().menuList = menuArr;
			view.menuArr = menuArr;
	 	}
	 	
		private function makeMenu(tempMenu:MenuInfo):MenuInfoChild
		{
			var menu:MenuInfoChild = new MenuInfoChild();
			menu.level = tempMenu.level;
			menu.id = tempMenu.id;
			menu.parent = tempMenu.parent;
			menu.menuCategory = tempMenu.menuCategory;
			menu.menuName = tempMenu.menuName;
			menu.menuOrder = tempMenu.menuOrder;
			menu.menuUrl = tempMenu.menuUrl;
			menu.menuUse = tempMenu.menuUse;
			menu.menuType = tempMenu.menuType;
			menu.children = makeArray(tempMenu.children as ArrayCollection);
			return menu;
		}
		
		private function makeArray(arr:ArrayCollection):Array
		{
			var temp:Array = new Array();
			if(arr == null) return temp;

			for(var i:int=0; i<arr.length; i++)
			{
				temp.push(makeMenu(arr[i]));					
			}
			return temp;
		}
		
		private function get view():*
		{
			return viewComponent as portal;
		}
	}
}