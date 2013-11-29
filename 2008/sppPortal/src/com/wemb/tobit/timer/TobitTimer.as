package com.wemb.tobit.utils
{
	import flash.utils.Timer;

	public class TobitTimer extends Timer
	{
		///////////////////////////////////////////////////////
		//private variables
		private var _processID:String;
		
		public function TobitTimer(delay:Number, repeatCount:int=0)
		{
			super(delay, repeatCount);
		}
		
		public function set processID( value:String ):void
		{
			this._processID = value;
		}
		public function get processID():String
		{
			return this._processID;
		}
		
	}
}