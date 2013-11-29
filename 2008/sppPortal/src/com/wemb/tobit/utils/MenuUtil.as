package com.wemb.tobit.utils
{
	import com.wemb.tobit.vo.MenuInfo;
	
	import mx.collections.ArrayCollection;
	
	public class MenuUtil
	{
		public function MenuUtil()
		{
		}

		
		public static function createMenuTree(value:ArrayCollection):ArrayCollection{
			
			//트리 맵 리스트 생성
			var treeMap:Object = new Object();
			
			//root 생성
			var root:Object = new Object();
			
			root.children = new ArrayCollection();
			
			var stack:Array = new Array();
			
			var currentItem:Object = root;
			
			var currentGroup:String = "new";
			
			for each( var menuInfo:MenuInfo in value.source){
				
				var level:int = menuInfo.level;
				
				var parent:String = menuInfo.menuParent;
				
				if(parent){
					//트리맵에 부모 리스트가 있는지 조회
					var parentMenu:MenuInfo = treeMap[parent];
					if(parentMenu){
						if(!parentMenu.children)
							parentMenu.children = new Array();
						
						parentMenu.children.addItem(menuInfo);
						
						// 트리맵에 추가한다.
						treeMap[menuInfo.id] = menuInfo;
					}else{
						// 부모 아이디가 없으면 
						root.children.addItem(menuInfo);
						
						// 트리맵에 추가한다.
						treeMap[menuInfo.id] = menuInfo;
					}
					
				}else{
					// 부모 아이디가 없으면 
					root.children.addItem(menuInfo);
					
					// 트리맵에 추가한다.
					treeMap[menuInfo.id] = menuInfo;
				}
					
				
				/*
				while(stack.length >= level){
					currentItem = stack.pop();
				}
				
				if(!currentItem.children)
					currentItem.children = new ArrayCollection();
				
				ArrayCollection(currentItem.children).addItem(menuInfo);
				
				stack.push(currentItem);
				
				currentItem = menuInfo;
				*/
			}
			
			return root.children as ArrayCollection;
		}
		
		public static function createMenuTree_Auth(value:ArrayCollection):ArrayCollection{
			
			//root 생성
			var root:Object = new Object();
			root.children = new ArrayCollection();
			
			var stack:Array = new Array();
			
			var currentItem:Object = root;
			
			var currentGroup:String = "new";
			
			for each( var menuInfo:MenuInfo in value.source){
				
				var level:int = menuInfo.level;
				
				while(stack.length >= level){
					currentItem = stack.pop();
				}
				
				if(!currentItem.children)
					currentItem.children = new ArrayCollection();
				
				ArrayCollection(currentItem.children).addItem(menuInfo);
				
				stack.push(currentItem);
				
				currentItem = menuInfo;
			}
			
			return root.children as ArrayCollection;
		}
		
	}
}