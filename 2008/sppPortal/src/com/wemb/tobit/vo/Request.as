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
	public class Request
	{
		//-----------------------------------------------
		// public variables
		//-----------------------------------------------
		
		/**
		 * 요청 Command 이름 
		 */		
		public var command:String = "";
		
		
		/**
		 * Parameter... 
		 */		
		public var param:Object = null;
		
		
		/**
		 * 결과값
		 */		
		public var result:Object = "";
		
		
		//-----------------------------------------------
		// private variables
		//-----------------------------------------------
		
		/**
		 * 인증 아이디
		 */		
		private var _authID:String = "";
		
		
		/**
		 * 요청 페이지
		 */
		public var pageName:String;
		
		
		/**
		 * 생성자 
		 */		
		public function Request()
		{
			
		}
		
		
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
		
		
		/**
		 * Result Command 이름 반환 
		 * @param type
		 * @return 
		 * 
		 */		
		public function getResultCommand(type:String = ""):String
		{
			return command + "Result"; 
		}
		
		
		/**
		 * Parameter Setter 
		 * @param name
		 * @param value
		 * 
		 */		
		public function setParameter(name:String, value:Object):void
		{
			if( !param ) param = new Object();
			param[name] = value;
		}
		
		/**
		 * Parameter Getter 
		 * @param name
		 * @return 
		 * 
		 */		
		public function getParameter(name:String):Object
		{
			return param[name];
		}
	}
}