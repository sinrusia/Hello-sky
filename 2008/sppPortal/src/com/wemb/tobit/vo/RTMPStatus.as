package com.wemb.tobit.vo
{
	/**
	 * 
	 * 
	 * @author 정태훈 (thlife@wemb.co.kr)
	 * 
	 */	
	public class RTMPStatus
	{
		//-----------------------------------------------
		//
		// Variables
		//
		//-----------------------------------------------
		/**
		 * 상태
		 * 
		 * @category normal, edit, error
		 */
		private var _status:String = "";
		
		/**
		 * 메시지
		 */
		private var _message:String = "";
		
		/**
		 * 정상 
		 */		
		public static var NORMAL:String = "normal";
		
		/**
		 * 재접속 
		 */		
		public static var RECONNECT:String = "reconnect";
		
		/**
		 * 에러 
		 */		
		public static var ERROR:String = "error";
		
		/**
		 * 수정 
		 */		
		public static var EDIT:String = "edit";
		
		//-----------------------------------------------
		//
		// Functions
		//
		//-----------------------------------------------
		public function RTMPStatus( _status:String="", _message:String="" )
		{
			if( _status != "" )		status = _status;
			if( _message != "" )	message = _message;
		}
		
		
		
		//-----------------------------------------------
		//
		// Setter / Getter
		//
		//-----------------------------------------------
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set status( value:String ):void
		{
			this._status = value;
		}
		
		[Bindable]
		public function get status():String
		{
			return this._status;
		}
		
		public function set message( value:String ):void
		{
			this._message = value;
		}
		
		[Bindable]
		public function get message():String
		{
			return this._message;
		}
	}
}