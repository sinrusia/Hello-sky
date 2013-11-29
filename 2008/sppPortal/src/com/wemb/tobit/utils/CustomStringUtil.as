package com.wemb.tobit.utils
{
	public class CustomStringUtil
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
		 * 10보다 작으면 0붙여서 리턴
		 * str   원문자열
		 */
		public static function getTenSpace(str:String):String 
		{
		 	if ( Number(str) < 10 ) return "0" + str;
		 	return str;
		}
	}
}