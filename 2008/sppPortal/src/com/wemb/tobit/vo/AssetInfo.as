package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.AssetInfo")]
	[Bindable]
	public class AssetInfo
	{
		
		public var index:String;
		public var level:String;
		public var id:String;
		public var groupName:String;			// group name
		public var hostName:String;				// asset HostName
		public var assetName:String				// assetName
		public var label:String;				// asset label
		public var systemType:String;			// asset System Type
		public var ip:String;					// asset IP Address
		public var icon:String;					// asset Tree Icon
		public var symbolId:String;				// asset Symbol Specific ID
		public var symbolName:String;			// asset Flash Symbol Name
		public var componentName:String;		// asset Map Component Name
		public var osName:String;				// OS Name
		public var osRelease:String;			// CPU TPMC
		public var osVersion:String;			// OS Version
		public var cpuSpecifications:String;	// CPU Specifications
		public var cpuTpmc:String;				// 
		public var cpuCount:String				// count CPU
		public var memorySize:String;			// Memory Size
		public var memory:String				//
		public var swap:String					// SWAP
		public var diskTpmc:String;				// Disk TPMC
		public var model:String;				// model name
		public var chargeName:String;			// 담당자 이름
		public var chargePhone:String;			// 담당자 연락처
		public var location:String;				// 설치 위치
		public var dbVersion:String;			// Database Version
		public var useyn:String;				// 장비 사용 유무
		public var clusteryn:String;			// 클러스터 사용 유무
		public var purchaseDate:String;			// 장비 구입일
		public var maintenanceCompany:String;	// 유지보수 업체명
		public var maintenanceCharge:String;	// 유지보수 담당자
		public var maintenancePhone:String;		// 유지보수 담당자 핸드폰 번호
		
		public var yongdo:String;		// 업무용도
		public var madeIn:String;	// 기종유형
		public var cpuSpeed:String;		// cpu 속도
		public var cpuCnt:String;	// cpu 갯수
		public var osPatchVer:String;		// os 패치버전
		public var osFirmVer:String;	// firm버전
		public var osKernel:String;	// 커널 bit
		
		public var parent:String;
		public var children:Array;
		
		public var swap_size:String;	// 스왑총량
		public var lev2_group:String;	// 그룹명
		public var default_gateway:String;	// 디폴트 게이트웨이
		public var cpu_type:String;	// cpu type
			
			
	}
}