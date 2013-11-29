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
		public var userId:String = "";				// 사용자 아이디
		public var userName:String = "";			// 사용자 이름
		public var companyCode:String = "";			// 사용자 전화 번호
		public var companyName:String = "";		// 핸드폰 번호 1
		public var deptName:String = "";			// 사용자 부서 아이디
		public var position:String = "";		// 사용자 부서 명
		public var email:String = "";		// 사용자 직급
		public var telephone:String = "";			// 사용자 직책
		public var mobile:String = "";			// 사용자 등급
		public var status:String = "";			// 사용자 등급
		public var adminflag:String;
					
		public function reset():void
		{
			userId = "";
			userName = "";
			companyCode = "";
			companyName = "";
			deptName = "";
			position = "";
			email = "";
			telephone = "";
			mobile = "";
			status = "";
			adminflag = "";
		}
	}
}