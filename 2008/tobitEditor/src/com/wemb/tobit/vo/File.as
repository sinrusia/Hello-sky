////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2011 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.vo
{
	import flash.net.FileReference;

	/**
	 *	@auther			:	kjh
	 */
	[Bindable]
	[RemoteClass(alias="com.wemb.tobit.vo.File")]
	public class File
	{
		public var id:String;
		public var serviceId:String;
		public var originalName:String;
		public var path:String;
		public var savedName:String;
		public var size:Number = 0;
		public var type:String;
		public var uploadTime:Date;
		public var order:int;
		public var status:String;	// uploaded : 파일 업로드만 한 상태, saved : 저장되어 있는 파일
	}
}