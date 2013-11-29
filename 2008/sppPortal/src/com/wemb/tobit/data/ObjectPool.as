package com.wemb.tobit.data
{
	import flash.utils.Dictionary;
	
	/**
	 * 심볼을 재사용하기위한 Object Pool
	 * 
	 * @author 정태훈(thlife@wemb.co.kr)
	 * 
	 */	
	public class ObjectPool
	{
		//-----------------------------------------------
		//
		// Variables
		//
		//-----------------------------------------------
				
		
		/**
		 * Object Map 
		 */
		public static var objectMap:Dictionary = new Dictionary(false);
		
		
		//-----------------------------------------------
		//
		// Functions
		//
		//-----------------------------------------------
		
		public function ObjectPool()
		{
			
		}
		
		
		
		/**
		 * 아이템 추가
		 * 
		 * @param key
		 * @param value
		 * @return 
		 * 
		 */		
		public static function addItem( key:String, value:Object ):Boolean
		{
			try
			{
				var arr:Array = checkItem( key );
				
				if( !arr )
					arr = createArray( key );
				
				arr.push( value );
			}
			catch( errer:Error )
			{
				trace( "ObjectPool Error", errer.message );
				return false;
			}
			return true;
		}
		
		
		/**
		 * 아이템 리턴
		 * 
		 * @param key
		 * @return 
		 * 
		 */		
		public static function getItem( key:String ):Object
		{
			var tempArr:Array = checkItem( key );
			
			if( tempArr )	return tempArr.pop();
			else			return null;
		}
		
		
		
		/**
		 * 존재하는 아이템인지 체크
		 * 
		 * @param key
		 * @return 
		 * 
		 */		
		private static function checkItem( key:String ):Array
		{
			var tempObj:Object = objectMap[ key ];
			
			if( tempObj ) 	return tempObj as Array;
			else 			return null;
		}
		
		
		
		/**
		 * 해당 오브젝트를 키로하는 배열 생성
		 *  
		 * @param key
		 * @return 
		 * 
		 */		
		private static function createArray( key:String ):Array
		{
			objectMap[key] = new Array();
			
			return objectMap[key] as Array;
		}
	}
}