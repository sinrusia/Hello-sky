package com.wemb.tobit.vo
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	/**
	 *  서버시간
	 *  
	 */
	public class ServerTime
	{
		private static var instance:ServerTime;
		
		public function ServerTime()
		{
			if(instance != null){
				throw new Error("ServerTime 싱글톤으로 생성할 수 없습니다.");
			}
		}
		
		/**
		 * Singleton ApplicationFacade Factory Method
		 */
		public static function getInstance(): ServerTime
		{
			if (instance == null) instance = new ServerTime();
			return instance;
		}
		
		public var serverTime:String = "";
	}
}