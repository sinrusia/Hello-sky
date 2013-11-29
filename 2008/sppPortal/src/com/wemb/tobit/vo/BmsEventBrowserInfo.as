package com.wemb.tobit.vo
{	
	/**
	 *  BMS 이벤트 브라우져   VO
	 *  
	 *	<p>메시지 브라우져 VO</p>
	 * 
	 *	@auther 현우성( nuno@wemb.co.kr )
	 */
	public class BmsEventBrowserInfo
	{
		
		public var application:String;
		public var dupl_count:String;
		public var evt_coll_stime:String;
		public var host_level:String;
		public var host_name:String;
		public var lev2_gid:String;
		public var message_group:String;
		public var message_number:String;		
		public var object:String;
		public var severity:String;
		public var sms_mgmt_svr:String;
		public var sms_mgmt_svr_name:String;		
		public var text_part:String;
		
		
		public function toString():String
		{
			return 	"application: " + application +"\n"+
					"dupl_count: " + dupl_count +"\n"+
					"evt_coll_stime: " + evt_coll_stime +"\n"+
					"host_level: " + host_level +"\n"+
					"host_name: " + host_name +"\n"+
					"lev2_gid: " + lev2_gid +"\n"+
					"message_group: " + message_group +"\n"+
					"message_number: " + message_number +"\n"+
					"object: " + object +"\n"+
					"severity: " + severity +"\n"+
					"sms_mgmt_svr: " + sms_mgmt_svr +"\n"+
					"sms_mgmt_svr_name: " + sms_mgmt_svr_name +"\n"+
					"text_part: " + text_part +"\n";
		}
		
		
	}
}