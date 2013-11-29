package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.BmsEventCount")]
	[Bindable]
	/**
	 * 이벤트 수 VO
	 * 
	 * @auther 
	 */	
	public class BmsEventCount
	{
		public var critical:int;
		public var major:int;
		public var minor:int;
		public var warning:int;
		public var normal:int;
		public var own:int;
		public var outage:int;
					
		public function comparison(eventCount:BmsEventCount):Boolean{
			if(this.critical != eventCount.critical)
				return false;
			
			if(this.major != eventCount.major)
				return false;
			
			if(this.minor != eventCount.minor)
				return false;
			
			if(this.warning != eventCount.warning)
				return false;
			
			if(this.normal != eventCount.normal)
				return false;
				
			if(this.own != eventCount.own)
				return false;
			
			if(this.outage != eventCount.outage)
				return false;
			
			return true;
		}
	}
}