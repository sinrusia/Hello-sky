package com.wemb.tobit.vo
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="com.wemb.tobit.vo.UserInfo")]
	[Bindable]
	/**
	 *  UserInfo VO 객체
	 *  
	 *	<p>USER 로그인 정보</p>
	 * 
	 *	@auther 고재학( sinrusia@wemb.co.kr)
	 */
	public class UserInfo
	{
		public var user_id:String = "";				// 사용자 아이디
		public var user_name:String = "";			// 사용자 이름
		public var userphone:String = "";			// 사용자 전화 번호
		public var userDeptId:String = "";			// 사용자 부서 아이디
		public var userDeptName:String = "";		// 사용자 부서 명
		public var usergradeId:String = "";			// 사용자 등급
		public var usergradeName:String = "";		// 사용자 등급
		public var userInitPage:String = "";		// 사용자 초기화 페이지
		public var pageType:String = "";
		public var userRole:String = ""; 				// 사용자 권한
		public var userEnable:String = "";
		
		public var userPosition:String = "";		// 사용자 직급
		public var userDuty:String = "";			// 사용자 직책
		public var user_mobile:String = "";		// 핸드폰 번호
		
		public var menuName:String = "";		// 초기페이지 명
		public var menuPageClass:String = "";		// 초기페이지 파일명

		
		// 통보에 필요
		public var dept_name:String = "";		
		public var user_jname:String = "";
		public var user_pc1:String = "";
		public var ums_yn:String = "";
		public var popup_yn:String = "";
		public var select_yn:String = "";
		public var seq:String = "";
		public var target_id:String = "";
		
		
		private var _children:ArrayCollection;
		
		public var check_visible:String;
		
		//사용자권한 설정
		public var index:Number;
		public var level:Number;
		public var type:String;		// 00 : USER , 01 : DEPARTMENT
		
		public var user_map_edit:String = ""; 
		public var upmu_map_edit:String = ""; 
		public var bak_map_edit:String = ""; 
		public var disk_map_edit:String = ""; 
		public var pdp_map_edit:String = ""; 
		public var evt_fp_edit:String = "";
					
		public function reset():void
		{
			user_id			= "";
			user_name		= "";
			userphone		= "";
			userDeptName	= "";
			usergradeId		= "";
			usergradeName	= "";
			userInitPage 	= "";
			userRole 		= "";
			dept_name = "";		
			user_jname = "";
			user_pc1 = "";
			ums_yn = "";
			popup_yn = "";
			select_yn = "";
			seq = "";
			target_id = "";			
			user_mobile = "";
			menuName = "";
			menuPageClass = "";
			
			user_map_edit = "";
			upmu_map_edit = ""; 
			bak_map_edit = ""; 
			disk_map_edit = ""; 
			pdp_map_edit = ""; 
			evt_fp_edit = "";
		}

		
		public function set children(value:Object):void
		{
			if(value is Array){
				_children = new ArrayCollection(value as Array);
			}else{
				_children = value as ArrayCollection;
			}
		}
		
		public function get children():Object
		{
			return _children;
		}		
	}
}