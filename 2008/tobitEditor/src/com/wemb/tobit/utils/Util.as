////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.utils
{
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	
	public class Util
	{
		public function Util()
		{
			
		}
		
		static public function getData(str:String):String{
			if( str == null)
				return "";
			var arr:Array = str.split("-");
			return arr.join("");
		} 	
        		
		
		/**
		 * object copy a라는 배열에 b라는 배열을 복사할 경우 a와 b가 동시에 바뀌는걸 방지하기 위한 함수
		 * 
		 * @param source
		 * @return 
		 * 
		 */		
		public static function objectCopy( source:Object ):*
		{
			var myBA:ByteArray = new ByteArray();
			
			myBA.writeObject(source);
			myBA.position = 0;
			
			return(myBA.readObject()); 
		}		
		
		 
		/**
		 * commaDel 123,456,676, 맨 뒤 콤마를 지워준다.
		 * 
		 * @param str
		 * @return 
		 * 
		 */		
		public static function commaDel( str:String ):String
		{
			var t_arr:Array = str.split(",");
			var cnt:int = t_arr.length;
			var rStr:String = "";
			
			for(var i:int=0; i<cnt; i++)
			{
				if( t_arr[i] == "" )
					break;
					
				if( i==0 )
					rStr += t_arr[i];
				else 
					rStr += ","+t_arr[i];
			}			
			return rStr;			
		}
		
		
		/**
 		 * 원하는 정수로 리턴
 		 * 
 		 * @param value
 		 */
 		public static function makeRandomNumber( value:int ):Number
 		{
 			return Math.floor(Math.random()*value);
 		}
 		
 		/**
 		 * 원하는 정수로 리턴
 		 * 
 		 * @param value
 		 */
 		public static function makeRandomNumber2( value:int ):Number
 		{
 			return Math.random()*value;
 		}
 		
 		
 		/**
 		 * 2자리수로 만들어 준다. 
 		 * 
 		 * <p> 예) 0 -> 00, 1 -> 01</p>
 		 *  
 		 * @param value
 		 * @return 
 		 * 
 		 */ 		
 		public static function makeDoubleChar( value:int ):String
 		{
 			if( value < 0 ) return value.toString();
 			
 			if( value < 10 )
 				return "0" +  value.toString();
 			else
 				return value.toString();
 		}
 		
 		/**
		 * 한 자리수 문자를 두자리수 문자로 변환해준다.
		 * @param str
		 * @return 
		 * 
		 */				
		public static function getNumberFormat(str:String):String{
			switch(str.length){
				case 0 :
					return "00";
				case 1:
					return "0"+str;
				default:
					return str;		
			}			
		}		
		
		
		
		static public function GetCSSResource(parentName:String, childName:String):*{
			var str:*;
			try{
				var cssClass:CSSStyleDeclaration = StyleManager.getStyleDeclaration(parentName);
				str = (cssClass.getStyle(childName));
			} catch(err:Error){}
			return str;
		}
		
		
		
		public static function calculatorAngle( startP:Point, endP:Point ):Number
		{
			var ww:Number = endP.x - startP.x;	//밑변
			var hh:Number = endP.y - startP.y;	//높이
			
			var topAngle:Number = Math.atan2(hh, ww)*180/Math.PI;		//윗각
			
			return topAngle;
		}
				
		static public function timeCalcStime(time:String):String{
			var date:Date = new Date(time.substr(0, 4)
									, time.substr(4, 2)
									, time.substr(6, 2)
									, time.substr(8, 2)
									, time.substr(10, 2)
									, time.substr(12, 2));
			
			var __d:String = String(Number(date.getMonth()));
			if(__d.length == 1) __d = "0"+__d;
			
			var __h:String = String(date.getHours());
			if(__h.length == 1) __h = "0"+__h;
			
			var __m:String = String(date.getMinutes());
			if(__m.length == 1) __m = "0"+__m;
			
			var __s:String = String(date.getSeconds());
			if(__s.length == 1) __s = "0"+__s;
			
			var __da:String = String(date.getDate());
			if(__da.length == 1) __da = "0"+__da;
			
			var d:String = 	date.getFullYear() + __d + __da;
			var t:String = __h + __m + __s;
			
			var _time:String = d + t;
			return _time;
		}		
		
		static public function timeCalc(time:String, type:String, gep:Number = 2):String{
			var date:Date = new Date(time.substr(0, 4)
									, time.substr(4, 2)
									, time.substr(6, 2)
									, time.substr(8, 2)
									, time.substr(10, 2)
									, time.substr(12, 2));
			
			if(type == "p")
				date.minutes += gep;
			else
				date.minutes -= gep;
			
			var __d:String = String(Number(date.getMonth()));
			if(__d.length == 1) __d = "0"+__d;
			
			var __h:String = String(date.getHours());
			if(__h.length == 1) __h = "0"+__h;
			
			var __m:String = String(date.getMinutes());
			if(__m.length == 1) __m = "0"+__m;
			
			var __s:String = String(date.getSeconds());
			if(__s.length == 1) __s = "0"+__s;
			
			var __da:String = String(date.getDate());
			if(__da.length == 1) __da = "0"+__da;
			
			var d:String = 	date.getFullYear() + __d + __da;
			var t:String = __h + __m + __s;
			
			var _time:String = d + t;
			return _time;
		}	
				
		static public function getRandomCntUint(max:uint):uint {
			return Math.round(Math.random() * max);
		}	
		
		
		static public function getDate(seconds:Number):String{
			var now:Date= new Date();
			var date:Date = new Date(now.getFullYear(), now.getMonth(), now.getDate(), now.getHours(), now.getMinutes(), now.getSeconds()-seconds);
					
			var y:String = date.getFullYear().toString();
			var m:String = (date.getMonth() + 1).toString() ;
			var d:String = date.getDate().toString();
			var hh:String = date.getHours().toString();
			var mm:String = Number(date.getMinutes() ).toString();
			var ss:String = date.getSeconds().toString();
			
			m = Util.getNumberFormat(m);
			d = Util.getNumberFormat(d);
			hh = Util.getNumberFormat(hh);
			mm = Util.getNumberFormat(mm);
			ss = Util.getNumberFormat(ss);
			
			return y.toString() + m.toString() + d.toString() + hh.toString() + mm.toString() + ss.toString();
			
		}
		
		/**
		 * 날짜에서 날짜를 빼서 일자를 리턴
		 *  
		 * @param start
		 * @param end
		 * @return 
		 */		
		public static function getDate2(start:String, end:String):int
		{
			var start_date:Date = new Date(start.substr(0,4), String(Number(start.substr(4,2))-1),start.substr(6,2));
			var end_date:Date = new Date(end.substr(0,4), String(Number(end.substr(4,2))-1),end.substr(6,2));
		
			return (Number(end_date)-Number(start_date))/(3600*1000*24);
		}
							
		/**
		 * 시작과 끝시간으로 소요시간을 초로 리턴 
		 * 
		 * <p> 20090101000000 </p>
		 *  
		 * @param startTime
		 * @param endTime
		 * @return 
		 * 
		 */		
		public static function calculateTotalTime( startTime:String, endTime:String ):Number
		{
			var start_date:Date;
			var end_date:Date;
			
			var total_second:Number;
			
			var startDate:String = startTime.substr(0, 8);
			var endDate:String = endTime.substr(0, 8);
			
			var startH:int = parseInt(startTime.substr( 8, 2 ));
			var endH:int = parseInt(endTime.substr( 8, 2 ));
			
			var startM:int = parseInt(startTime.substr( 10, 2 ));
			var endM:int = parseInt(endTime.substr( 10, 2 ));
			
			var startS:int = parseInt(startTime.substr( 12, 2 ));
			var endS:int = parseInt(endTime.substr( 12, 2 ));
			
			
			total_second = getDate2(startDate,endDate)*86400 + ((endH-startH)*3600) + ((endM-startM)*60) + (endS-startS);
		 
			return total_second;
		}
	}
}