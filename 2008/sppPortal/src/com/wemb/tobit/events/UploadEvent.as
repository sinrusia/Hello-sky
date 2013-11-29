package com.wemb.tobit.events
{
	import flash.events.Event;
	import mx.collections.ArrayCollection;

	public class UploadEvent extends Event
	{
		private var _dataAC:ArrayCollection;
		
		public function UploadEvent(bubble:Boolean=false){
			super("UploadCompleteEvent", bubble);
		}
		
		public function set dataAC(_dataAC:ArrayCollection):void{
			this._dataAC = _dataAC;
		}
		
		public function get dataAC():ArrayCollection{
			return _dataAC;
		}
	}
}