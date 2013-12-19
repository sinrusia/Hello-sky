////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2011 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.Configuration")]
	[Bindable]
	public class Configuration
	{
		public var id:String;			// 고유 아이디
		public var code:String;			// 환경설정 값을 구분하는 코드
		public var name:String;			// 환경설정 아이디
		public var value:String;		// 환경설정 값
		public var description:String;	// 환경설정 설명
		public var type:String;		    // 환경설정 구분 아이디
		public var enable:String;		// 환경설정 값 사용여부
		public var deletable:String		// 환경설정 값 삭제여부
		
		public var isNew:String;
	}
}