package com.wemb.tobit.managers
{
	import com.wemb.tobit.utils.TobitTimer;
	
	public class TimerVO
	{
		/////////////////////////////////////////
		// private variables
		private var _processID:String;
		private var _timer:TobitTimer;
		
		
		////////////////////////////////////////////////
		// Setter / Getter
		public function set processID( value:String ):void
		{
			this._processID = value;
		}
		public function get processID():String
		{
			return _processID;
		}
		
		
		public function set timer( value:TobitTimer ):void
		{
			this._timer = value;
		}
		public function get timer():TobitTimer
		{
			return _timer;
		}
	}
}