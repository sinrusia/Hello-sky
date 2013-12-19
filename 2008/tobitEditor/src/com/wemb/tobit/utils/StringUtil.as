////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.utils
{
	public class StringUtil
	{
		/**
		 * 공백 제거
		 */
		public static function deleteSpace(str:String):String
		{
		    var delPattern:RegExp = / /g;  
		    var tempstr:String = str.replace(delPattern,"");
		    return tempstr;
		}
		
		/**
		 * 해당 문자 전체 변경
		 * str   원문자열
		 * re    찾을 문자열
		 * after_re  바꿀 문자열
		 */
		public static function replaceAll(str:String, re:String, after_re:String):String 
		{
		 	var rel:RegExp = new RegExp(re, "g");
		 	return str.replace(rel, after_re);
		}
		
		/**
		 * 게시물 (게시판, 설문) ID 만들기
		 * @return 
		 * 
		 */		
		public static function makeID():String{
			var date:Date = new Date();
			var result:String;
			
			result = date.getUTCFullYear().toString();
			
			if(new Number(date.getUTCMonth()+1) < 10){
				result += '0' + (date.getUTCMonth()+1).toString();
			}else{
				result += (date.getUTCMonth()+1).toString();
			}
			
			if(new Number(date.getUTCDate()) < 10){
				result += '0' + (date.getUTCDate()).toString();
			}else{
				result += (date.getUTCDate()).toString();
			}
			
			if(new Number(date.getUTCHours()) < 10){
				result += '0' + (date.getUTCHours()).toString();
			}else{
				result += (date.getUTCHours()).toString();
			}
			
			if(new Number(date.getUTCMinutes()) < 10){
				result += '0' + (date.getUTCMinutes()).toString();
			}else{
				result += (date.getUTCMinutes()).toString();
			}
			
			if(new Number(date.getUTCSeconds()) < 10){
				result += '0' + (date.getUTCSeconds()).toString();
			}else{
				result += (date.getUTCSeconds()).toString();
			}
			return result;
		}
		
		/**
		 * 파일 확장자 찾기
		 * @param 화일명
		 * @return 예) .txt, .hwp ...
		 * 
		 */	
		public static function makeFileID(str:String):String{
			var tempArr:Array = str.split(".");
			return "."+tempArr[tempArr.length-1];
		}
		
		/**
		 * ' 삭제
		 * @param String
		 */	
		public static function removeSingleQuote(str:String):String{
			var delPattern:RegExp = /'/g;  
			return  str.replace(delPattern,"");
		}		
	}
}