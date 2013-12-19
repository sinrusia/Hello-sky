////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2011 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.vo
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="com.wemb.tobit.vo.User")]
	[Bindable]
	/**
	 *  UserInfo VO 객체
	 *  
	 *	<p>USER 로그인 정보</p>
	 * 
	 *	@auther 고재학( sinrusia@wemb.co.kr)
	 */
	public class User
	{
		public static const SUPER_USER:String = "out|dnsdudadm";
		
		public var userId:String = ""; 			//id			
		public var userCpn:String = ""; 			//사번
		public var userName:String = ""; 		//이름
		public var userPassword:String = ""; 	//패스워드
		public var userInitPage:String = ""; 	//초기화면
		public var userDept:String = ""; 		//부서/팀
		public var userDeptName:String = ""; 		//부서/팀
		public var userPosition:String = ""; 	//직책
		public var userPositionName:String = ""; 
		public var userOffice:String = ""; 		//직위
		public var userRank:String = ""; 		//직급
		public var userPhone:String = ""; 		//전화번호
		public var userMobile:String = ""; 		//휴대폰
		public var userEmail:String = ""; 		//이메일
		public var homeAddress:String = ""; 	//집주소
		public var homePhone:String = ""; 	//집전화번호
		public var userSsn:String = ""; 			//주민등록번호
		public var userBirthday:String = ""; 	//생년월일
		public var userCalender:String = ""; 	//양력/음력
		public var userSex:String = ""; 			//성별
		public var entranceDate:String = ""; 	//입사일
		public var resignDate:String = ""; 		//퇴사일
		public var userStatus:String = ""; 		//상태
		public var userEnable:String = ""; 		//사용유무
		public var userDesc:String = ""; 		//비고
		public var userEditable:String = "";	//맵 편집 권한
		
		private var _selected:Boolean = false;
		/////////////////////////////////////////////////////////
		public var userRole:String;
		public var userGradeId:String;
		public var userGradeName:String;
		
		
		//UserInfo
		public var user_id:String = "";				// 사용자 아이디
		public var user_name:String = "";			// 사용자 이름
		public var userphone:String = "";			// 사용자 전화 번호
		public var userDeptId:String = "";			// 사용자 부서 아이디
		public var usergradeId:String = "";			// 사용자 등급
		public var usergradeName:String = "";		// 사용자 등급
		public var pageType:String = "";
		
		public var userDuty:String = "";			// 사용자 직책
		public var user_mobile:String = "";		// 핸드폰 번호
		
		public var menuName:String = "";		// 초기페이지 명
		public var menuPageClass:String = "";		// 초기페이지 파일명
		
		// 추가
		public var user_ums_yn:String = "";
		public var user_popup_yn:String = "";
		public var modify_type:String = "";
		public var modify_user:String = "";
		public var modify_page:String = "";
		
		
		// 통보에 필요
		public var asset_name:String = "";
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
		
		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
		}

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
		
		/**
		 * 사용자 작업 권한 체크하여 맵편집 여부를 판단한다.
		 * 
		 * R1100 : 사용자
		 * R1200 : 관리자
		 * R1300 : 요청자
		 * R1400 : 접수자
		 * R1500 : 처리자
		 */
		public function get mapEditAuthority():String
		{
			if(userRole == "R1100"){
				return "Y";
			}else{
				return "N";
			}
		}
	}
}