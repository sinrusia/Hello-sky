package com.wemb.tobit.vo
{
	import mx.collections.ArrayCollection;
	
	public class CommonVars
	{
		public static const CDY_POLLING:Number = 10000;
		
		public static const BROWSER_CLOSE_TIME:Number = 10000;
		
		public static const PERFORMANCE_POLLING:Number = 30000;		// 인프라현황 -> 시스템 운영현황 cpu
		public static const NETWORK_POLLING:Number = 30000;	// 인프라현황 -> 네트워크 운영현황 top5

		public static const PIM_POLLING:Number = 30000;    // 시스템 성능현황  - PIM챠트 폴링 주기 ( 시스템별 CPU 현황 ,팝업)
		
		public static const DB_POLLING:Number = 30000;    // DB운영 현황
		
		public static const BACKUP_POLLING:Number = 180000;    // 백업현황 3분
		
		//public static const BACKUP_POLLING:Number = 10000;    // 백업현황 5분
		
		public static const TMAX_POLLING:Number = 10000;
		public static const CHART_DURATION:Number = 180; // 30분 : 60/(CHART_POLLING/1000) * 10
		
		public static const COLOR_NORMAL:Number = 0x00ff00;
		public static const COLOR_MINOR:Number = 0xFFFF00;
		public static const COLOR_MAJOR:Number = 0xff00cc;
		public static const COLOR_WARNING:Number = 0x0000ff;
		public static const COLOR_CRITICAL:Number = 0xFF0000;
		public static const COLOR_OWN:Number = 0x666666;
		
		public static const SOCKET_TIMEOUT:Number = 10000;
		
		public static const COLORS:Array = [0x197aff, 0xf2a832, 0x6c20b, 0x8541ea, 0x139a9c, 
		0xd566aa, 0x9a5b00,0x48578b, 0xBEBEBE , 0x5DB9DF];
		public static const COLORS2:Array = [0x197aff, 0xf2a832, 0x6c20b, 0x8541ea, 0x139a9c, 0xd566aa,   
											 0x9a5b00, 0x48578b, 0xa3727f, 0xcf476b, 0x176e5d, 0x7a3870];
		public static const COLORS3_AC:ArrayCollection = new ArrayCollection([
																{color:0x1eea14}, {color:0xffd925}, {color:0x35a5ff}, {color:0xff0000}
														]);
		public static const CHART_COLOR:Array = [0x85BE50, 0x83C4DE, 0xf19a4d, 
						0x51A996, 0xE2C742, 0x6775D1, 0xBF97CB, 
						0x9D5D4C, 
						0x809539, 0xFA8CB8, 0x4E4E7E, 0xb4b4b4, 0xff0000];
						
		
		public static const AREA_CHART_COLOR:Array = [	0x6a719c, 0x5894bd, 0xcb8d4e, 0x557870, 0xbda63a, 
								0x67844b, 0x959595, 0x91665b, 0x873b66,
								0x99b477, 0xbd586a, 0x4ecbc1, 0xa2589f
							 ]; 


		/*<인프라현황-작업자동화현황>
		-금일작업현황 - 파이챠트컬러
		정상작업수: #89f867(#76c060) / 실행중작업수: #94c1f8(#5d98c2) / 에러작업수: #ffae43(#ca9146)  / 미수행작업수: #e0dee6(#a8a6ab)
		-노드현황
		최대동시가동가능배치수: (범례)#e6d300 / (스틱챠트) #ddc312, #efe49a,  #ddc312
		현재가동배치수: (범례) #1dc2ad / (스틱챠트) #16a799 - #a1dfdb - #16a799
		★★스틱챠트: 2가지 색 그라데이션 - colorA (30%) colorB(20%) colorA(50%) ★★ */
		public static const JOB_COLOR:Array = [ 0x89f867, 0x94c1f8, 0xffae43, 0xe0dee6, 
												0xe6d300, 0x1dc2ad, 
												0xe4c412, 0xfceb8f, 0x16999e, 0x91d8dc];
		
		public static const JOB_TEXT_COLOR:Array = [ 0x76c060, 0x5d98c2, 0xca9146, 0xa8a6ab];
	
		public static const PROFRAME_POLLING:Number = 10000;													
		public static const EAI_POLLING:Number = 10000;													
		public static const MCA_POLLING:Number = 10000;
		
		public static const CG_POLLING:Number = 10000;
		public static const WAS_POLLING:Number = 15000;
		
		public static const NETWORK_POPUP_POLLING:Number = 60000;
		
		
		
		public static const CPU_PREF_POLLING:Number = 30000;	// 시스템별 성능 현황 
		public static const MAIN_POLLING:Number = 15000;	// 종합상황   서비스처리율  Area챠트, 어플리케이션 현황 폴링주기 
		
		
		public static const GLB_POLLING:Number = 10000;
		
		
		// 메인 로테이션		
		public static const MAIN_ROTATION:Number = 5000;
		
															
	}


}