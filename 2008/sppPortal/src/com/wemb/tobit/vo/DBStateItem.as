package com.wemb.tobit.vo
{
	[RemoteClass(alias="com.wemb.tobit.vo.DBStateItem")]
	public class DBStateItem
	{
		public function DBStateItem()
		{
			private var _dbEventState:int;			
			
			
			
			private var _dbSysTbl:int;
			
			public function set dbSysTbl(val:int):void{

			}
			
			public function get dbSysTbl():int{
				
				return _dbSysTbl;
				
			}
			
			
						
			private var _dbAppTbl:String;			
			private var _dbConn:String;
			
			private var _dbProc:String;
			private var _dbFs:String;
			private var _dbLog:String;			
			
		}

	}
}