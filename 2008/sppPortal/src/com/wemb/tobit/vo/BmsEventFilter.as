package com.wemb.tobit.vo
{	
	/**
	 *  BmsEventFilter 이벤트 브라우져   VO
	 *  
	 *	<p>이벤트 호출, ACK시 사용하는 이벤트처리시 사용되는 기본 객체,  쿼리시에도 파라미터 값으로 사용됨</p>
	 * 
	 *	@auther 현우성( nuno@wemb.co.kr )
	 */	 
	public class BmsEventFilter
	{
		public function BmsEventFilter()
		{
		}
		
		private var _sms_mgmt_svr:String = "All";
		public var sms_mgmt_svr_ac:Array;
		private var _host_name:String = "All";				//select 쿼리 필터를 위한 호스트 이름
		public var host_name_ac:Array;
		public var severity:String = "All";
		private var _message_group:String = "All";
		public var message_group_ac:Array;
		public var obj_evt:String = "All";
		public var application:String = "All";
		public var text_part:String = "All";
		public var eventtype:String = "All";
		public var mapid:String = "";
		
		//Ack를 호스트 이름으로 하는 경우 사용하는 호스트 이름
		public var ackHostName:String = "";					// Ack처리를 위한 호스트 이름
		
		
		public function set sms_mgmt_svr(val:String):void{
			_sms_mgmt_svr = val;
			sms_mgmt_svr_ac = _sms_mgmt_svr.split(",");
		}
		
		public function get sms_mgmt_svr():String{
			return _sms_mgmt_svr
		}
		
		
		
		public function set host_name(val:String):void{
			_host_name = val;
			host_name_ac = _host_name.split(",");
		}
		
		public function get host_name():String{
			return _host_name
		}
		
		
		public function set message_group(val:String):void{
			_message_group = val;
			message_group_ac = _message_group.split(",");
		}
		
		public function get message_group():String{
			return _message_group
		}
		
		
		
		
		/**
		 * DB 시스템의 이벤트 select, ACK 시 값 셋팅
		 *  */			
		public var dbOper:String = "";
		
		/**
		 * 데이터 서비스시 정의 하는 데이터 key
		 *  */		
		public var key:String;
		
		
		public function toString():String
		{
			return 	"sms_mgmt_svr: " + sms_mgmt_svr +"\n"+
					"sms_mgmt_svr_ac: " + sms_mgmt_svr_ac +"\n"+
					"host_name: " + host_name +"\n"+				
					"host_name_ac: " + host_name_ac +"\n"+
					"severity: " + severity +"\n"+
					"message_group: " + message_group +"\n"+
					"message_group_ac: " + message_group_ac +"\n"+
					"obj_evt: " + obj_evt +"\n"+
					"application: " + application +"\n"+
					"text_part: " + text_part +"\n"+
					"eventtype: " + eventtype +"\n"+
					"mapid: " + mapid +"\n"+
					"dbOper: " + dbOper +"\n"+
					"ackHostName: " + ackHostName +"\n"+
					"key: " + key +"\n";
					
				
		}
		
		
	}
}