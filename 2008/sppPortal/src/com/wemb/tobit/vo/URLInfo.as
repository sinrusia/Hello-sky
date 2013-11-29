package com.wemb.tobit.vo
{
	public class URLInfo
	{
		private static const webserver_ip:String = "http://130.1.75.57:8080";
		private static const pimserver_ip:String = "http://130.1.73.20:9099";
		
		// 업무 현황 (관련테이블 : tbt_biz_tmp)
		public static const biz_url:String = pimserver_ip + "/index.html?type=mcm_biz";
		
		// 업무 현황 (관련테이블 : tbt_biz_tmp)
		//public static const gtu_url:String = pimserver_ip + "/index.html?type=mcm_biz_gtu";
		
		// 핵심업무 (관련테이블 : 저장하지 않음)
		public static const key_url:String = pimserver_ip + "/index.html?type=mcm_main_biz";
		
		// 전체 거래 현황
		public static const tr_url:String = pimserver_ip + "/index.html?type=mcm_biz_tr";
		
		// 구간별 전체 응답시간
		public static const rtime_url:String = pimserver_ip + "/index.html?type=mcm_biz_tot";
		
		// SMS(CPU,MEM) (관련테이블 : tbt_sms_tmp)
		public static const sms_url:String = pimserver_ip + "/index.html?type=mcm_sms";
				
		// Ack
		public static const ack_url:String = webserver_ip + "/tobit/RemoteAck.jsp?code=";
				
		// 총거래 변동량(선+현+옵)
		// 총사용자접속수
		// 주문 누적현황
		// SK 총 체결 변동량
		public static const sycros_url:String = pimserver_ip + "/index.html?type=sycros";
	}
}