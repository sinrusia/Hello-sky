package com.wemb.tobit.event
{
	import com.wemb.tobit.vo.AssetInfo;
	
	import flash.events.Event;
	public class AssetEditEvent extends Event
	{
		public static const ASSET_CHANGE_EVENT:String = "assetChange";
		
		
		
		public var assetInfo:AssetInfo;
				
		public function AssetEditEvent(_type:String, __result:AssetInfo)
		{
			super(_type);
			this.assetInfo = __result;			
		}

	    override public function clone():Event{   
	        return new DataDispatcher(type, assetInfo);
	    }	
	    
	}
}