package com.wemb.tobit.error
{
	public class TobitError
	{
		//////////////////////////////////////////////
		// private variables
		private var _errTime:Date;
		private var _processID:String;
		private var _errCode:String;
		private var _errMessage:String;
		
		
		////////////////////////////////////////////////
		// Setter / Getter
		public function set errTime( value:Date ):void
		{
			this._errTime = value;
		} 
		public function get errTime():Date
		{
			return this._errTime;
		}
		
		
		public function set processID( value:String ):void
		{
			this._processID = value;
		}
		public function get processID():String
		{
			return this._processID;
		}
		
		
		public function set errCode( value:String ):void
		{
			this._errCode = value;
		}
		public function get errCode():String
		{
			return this._errCode;
		}
		
		
		public function set errMessage( value:String ):void
		{
			this._errMessage = value;
		}
		public function get errMessage():String
		{
			return this._errMessage;
		}
	}
}