////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.utils
{
	/**
	 * Project 정보 
	 * 
	 * <p>Version 정보</p>
	 * 
	 *	@auther 정태훈( thlife@wemb.co.kr )
	 */	
	public class VersionInfo
	{
		public static var version:String = "TOBIT Ver 5.6";
		
		public function VersionInfo()
		{
			traceDeployInfo();
			
			getUserBrowserInfo();
		}
		
		/**
		 * Project 정보 
		 * 
		 */		
		public function traceDeployInfo():void
		{
			trace( "--------------------------------------------------------------------------" );
			trace( "                       	TOBIT Demo Application" );
			trace( "" );
			trace( "								" + VersionInfo.version );
			trace( "" );
			trace( "" );
			trace( "								개발		- 고재학 과장" );
			trace( "" );
			trace( "	(c)WeMB 2004-2010 WeMB Incorporated. All rights reserved." );
			trace( "--------------------------------------------------------------------------" );
			trace( "" );
		}
		
		
		/**
		 * 사용자 브라우져 정보 
		 * 
		 */		
		public function getUserBrowserInfo():void
		{
			trace( "--------------------------------------------------------------------------" );
			trace( "									Browser: " + BrowserDetectUtil.browser );
			trace( "									Version: " + BrowserDetectUtil.browserVersion );
			trace( "									OS: " + BrowserDetectUtil.OS );
			trace( "--------------------------------------------------------------------------" );
		}
	}
}