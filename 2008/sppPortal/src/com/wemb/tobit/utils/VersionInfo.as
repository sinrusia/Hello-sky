package com.wemb.tobit.utils
{
	/**
	 * Project Information 
	 * 
	 * <p>Version 정보</p>
	 * 
	 *	@auther 정금옥( jade@wemb.co.kr )
	 */	
	public class VersionInfo
	{
		public static var version:String = "TOBIT Ver 5.6_0008";
		
		public static var buildVersion:String = "20110713.0001";
		public static var worker:String = "정금옥";
		
		public function VersionInfo()
		{
			traceDeployInfo();
			
			getUserBrowserInfo();
			
			getBuildVersion();
		}
		
		/**
		 * Project Information 
		 * 
		 */		
		public function traceDeployInfo():void
		{
			trace( "--------------------------------------------------------------------------" );
			trace( "                       	TOBIT Application" );
			trace( "" );
			trace( "								" + VersionInfo.version );
			trace( "" );
			trace( "" );
			trace( "								개발		- 정금옥 팀장" );
			trace( "										- 박정우 대리" );
			trace( "										- 신인수 사원" );
			trace( "										- 이상철 사원" );
			trace( "" );
			trace( "	(c)WeMB 2004-2011 WeMB Incorporated. All rights reserved." );
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
		
		
		/**
		 * 
		 * 빌드 버전
		 * 
		 * */
		 public function getBuildVersion():void{
			trace( "--------------------------------------------------------------------------" );
			trace( "									Build Version: " + VersionInfo.buildVersion );			
			trace( "									담당자             : " + VersionInfo.worker);
			trace( "--------------------------------------------------------------------------" );
		}
	}
}