////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2011 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.vo
{
	import com.wemb.tobit.core.TobitApplication;
	import com.wemb.tobit.pure.Constants;
	
	
	[RemoteClass(alias="com.wemb.tobit.vo.Request")]
	/**
	 *  Request VO 객체
	 *  
	 *	<p>서버와 통신하는 VO 객체</p>
	 * 
	 *	@auther 고재학( sinrusia@wemb.co.kr)
	 */
	public class Request extends TobitRequest
	{
		
		/**
		 * 로그인 상태에 따라 접근 상태 저장
		 * @param id
		 * 
		 */		
		private function authIDCheck(id:String):void
		{
			if( id != null && id != "" )
			{
				TobitApplication.authStatus = Constants.LOGIN_ON;
			}
			else
			{
				TobitApplication.authStatus = Constants.LOGIN_OFF;
			}
		}
		
		
		//-----------------------------------------------
		// Setter / Getter
		//-----------------------------------------------
		
		/**
		 * 인증 아이디
		 */		
		private var _authID:String = "";

		/**
		 * authID Setter 
		 * @param _authID
		 * 
		 */		
		public function set authID(_authID:String):void
		{
			this._authID = _authID;
			authIDCheck(_authID);
		}
		
		/**
		 * authID Getter 
		 * @return 
		 * 
		 */		
		public function get authID():String
		{
			return _authID;
		}
		
		private var _authName:String = "";

		/**
		 * 인증자 성명
		 */
		public function get authName():String
		{
			return _authName;
		}

		/**
		 * @private
		 */
		public function set authName(value:String):void
		{
			_authName = value;
		}
		
		
		private var _deptId:String = "";
		
	}
}