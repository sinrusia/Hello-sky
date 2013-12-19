package com.wemb.tobit.vo
{
	[Bindable]
	[RemoteClass(alias="com.wemb.tobit.vo.TickerInfo")]
	/**
	 *  티커 메시지 VO
	 *  
	 *	<p>티커 메시지</p>
	 * 
	 *	@auther 정태훈( thlife@wemb.co.kr )
	 */
	public class TickerInfo
	{
		/**
		 * 
		 */		
		public var no:String = "";
		
		/**
		 * 
		 */		
		public var seq:String = "";
		
		/**
		 * 
		 */		
		public var textpart:String = "";
		
		/**
		 * 
		 */		
		public var ticker_yn:String = "";
		
		
		public var selected:Boolean = false;
		
		public function TickerInfo( _seq:String="", _textpart:String="" )
		{
			if( _seq != "" ) 		seq = _seq;
			if( _textpart != "" )	textpart = _textpart;
		}
		
		public function toString():String
		{
			return 	"no: " + no +"\n"+
					"seq: " + seq +"\n"+
					"textpart: " + textpart +"\n"+
					"ticker_yn: " + ticker_yn +"\n";
		}
	}
}