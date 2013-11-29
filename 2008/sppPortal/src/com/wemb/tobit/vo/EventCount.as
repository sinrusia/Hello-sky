package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.EventCount")]
	[Bindable]
	/**
	 * 이벤트 수 VO
	 * 
	 * @auther 정태훈( thlife@wemb.co.kr )
	 */	
	public class EventCount
	{
		public var total:int;
		public var critical:int;
		public var major:int;
		public var minor:int;
		public var warning:int;
		public var normal:int;
			
		public function comparison(eventCount:EventCount):Boolean{
			if(this.total != eventCount.total)
				return false;
			
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
			
			return true;
		}
	}
}