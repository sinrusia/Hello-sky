package com.wemb.tobit.vo
{
	/**
	 *  BMSEventAckInfo 이벤트 브라우져   VO
	 *  
	 *	<p>이벤트 ACK처리시 사용되는 객체  VO</p>
	 * 
	 *	@auther 현우성( nuno@wemb.co.kr )
	 */	 
	public class BMSEventAckInfo
	{
		public function BMSEventAckInfo()
		{
		}
		
		/**
		 * 데이터 서비스시 정의 하는 Constants 의 메시지 전송 키
		 *  */
		public var ackConstantsType:String = "";
		
		/**
		 *  Ack 처리할 호스트이름의 스트링값
		 *  */
		public var ackHostName:String="";
		
		/**
		 * ACK시 호출할 URL값
		 *  */
		public var ackURL:String="";
		
		/**
		 * ACK 그룹 타입  : (SMS/AMS/BACKUP)
		 *  */
		public var param_sms_mgmt_svr:String="";
		
		/**
		 * user id
		 *  */
		public var param_user_id:String="";
		
		/**
		 * 메시지 넘버
		 *  */
		public var param_message_number:String = "";
				
		
		/**
		 * Map ID
		 *  */
		public var param_map_id:String = "";
		
		
		/**
		 * DB Oper
		 * */
		public var param_db_oper:String = "";
		
		
		
		
		public function callURLString():String
		{
			
			return 	ackURL+"?sms_mgmt_svr="+param_sms_mgmt_svr+"&map_id="+param_map_id+"&param_db_oper="+param_db_oper+"&user_id="+param_user_id+"&message_number="+param_message_number+"&host_name="+ackHostName;
		}
		
		
		public function toString():String
		{
			return 	"ackConstantsType: " + ackConstantsType +"\n"+
					"ackHostName: " + ackHostName +"\n"+
					"ackURL: " + ackURL +"\n"+				
					"param_sms_mgmt_svr: " + param_sms_mgmt_svr +"\n"+
					"param_user_id: " + param_user_id +"\n"+
					"param_map_id: " + param_map_id +"\n"+
					"param_db_oper: " + param_db_oper +"\n"+
					"param_message_number: " + param_message_number +"\n";
			
		}		

	}
}