package com.wemb.tobit.utils
{
	import flash.system.System;
	import mx.utils.ObjectUtil;

	/**
	 * debug시 로그 출력하는 클래스
	 * 
	 * <p>디버그 플레이어를 이용 로그를 표시하는 클래스.</p>
	 * 
	 *	@auther 현우성( nuno@wemb.co.kr )
	 */
	public class Logger
	{
		public static var _moduleName:String = "";
		
		/**
		 * 날짜 Flag
		 * <p>false 일시 안나옴.</p>
		 * 
		 * @dafault true 
		 */		
		public static var _dateMode:Boolean = true;
		
		
		/**
		 * Degug Data Flag
		 * <p>false 디버그 데이터 안나옴</p>
		 * 
		 * @default true
		 */				
		public static var _dataMode:Boolean = true;
		
		
		/**
		 * Debug Mode Flag
		 * 
		 * @default false 
		 */		
		public static var _debugMode:Boolean = false;
		
		
		/**
		 * 현재 Memory량 
		 */		
		private  static var nowMem:Number = 0; 
		
		
		
		//--------------------------------------------------
		// Constructor
		//--------------------------------------------------
		public function Logger()
		{
		
		}
		
		
		/**
		 * 현재 Debug 모드 상태 
		 * @return 
		 * 
		 */		
		public static function isDebug():Boolean
		{			
			return _debugMode;			
		}
		
		
		/**
		 * _debugMode true 일때 데이터 출력 
		 * @param args
		 * 
		 */		
		public static function debug( ...args ):void
		{
	        if( _debugMode )
	            log( args );
	    }
	    
	    
	    /**
	     * _debugMode && _dataMode true 일때 데이터 출력
	     * @param msg
	     * 
	     */	    
	    public static function debugData( msg:Object ):void
	    {
	    	if( _debugMode && _dataMode )
	            data( msg );
	    }
	    
	    /**
	     * 메모리 사용량 출력
	     */	    
	    public static function debugMem():void
	    {
	    	if( _debugMode )
	    		memoryCheck();
	    }
	    
	    
	    /**
	     * Object -> toString() 출력
	     * <p>"[Logger:Data][" + getDate() + ": " + _moduleName + " ]:" + ObjectUtil.toString( msg )</p> 
	     * @param msg
	     * 
	     */	    
	    public static function data( msg:Object ):void
	    {
	        try
	        {   
	            trace( "[Logger:Data][" + getDate() + ": " + _moduleName + " ]:" + ObjectUtil.toString( msg ) );
	        }
	        catch( error:Error )
	        {
	        	trace( "Logger Error" );	
	        }
	    
	    }
	    
	    
		/**
		 * 로그 Print
		 * <p>[Logger:debug][ " + getDate() + " " + _moduleName + " ]: " + msg</p>
		 *  
		 * @param args
		 * 
		 */		
		public static function log( ...args ):void
		{
	        try
	        {
	        	var msg:String = "";
					
				for(var i:int = 0; i < args.length; i++)
				{
					msg += args[i];
				}
				
	            trace( "[Logger:debug][ " + getDate() + " " + _moduleName + " ]: " + msg );
	        }
	        catch( error:Error )
	        {
	        	trace( "Logger Error" );	
	        }
	    }
		
		
		/**
		 * Memory Check 
		 * <p>[Logger:Memory][ + 
			 *				getDate() + "	" +  nowMem / 1024 + 
			 *				"Kbyte , 증감 값 :  " + varMem / 1024 + "Kbyte  ] </p>
		 */		
		public static function memoryCheck():void
		{
			var varMem:Number = System.totalMemory - nowMem;
			nowMem = System.totalMemory;
			
			trace( "[Logger:Memory][" + 
						getDate() + "	" +  nowMem / 1024 + 
						"Kbyte , 증감 값 :  " + varMem / 1024 + "Kbyte  ] ");		
		}
		
		
		/**
		 * 현재 날짜 만들기
		 * <p>ex> 2008/11/4/20:23:00</p>
		 *  
		 * @return String
		 * 
		 */		
		public static function getDate():String
		{
			if( _dateMode )
				return new Date().getFullYear() + "/" 
							+ (new Date().getMonth()+1) + "/" 
							+ new Date().getDate() + " " 
							+ new Date().getHours() + ":" 
							+ new Date().getMinutes() + ":" 
							+ new Date().getSeconds();
			
			return "";
		}
		
		
	}
}