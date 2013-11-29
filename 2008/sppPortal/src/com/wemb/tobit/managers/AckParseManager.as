package com.wemb.tobit.managers
{
	
	import mx.collections.ArrayCollection;
	
	public class AckParseManager
	{				
		
		private static var _instance:AckParseManager;		
		
		public function AckParseManager()
		{
			if( _instance )
			{
				throw new Error( "AlertSoundManager create Error: " );
			}		
		
		}
		
		public static function getInstance():AckParseManager
		{
			if( !_instance )
			{
				_instance = new AckParseManager();
			}
			
			return _instance;
		}
		
		
		public function ackParse(sms_mgmt_svr:String,msgAC:ArrayCollection):String{
		
			var rtnVal:String = '';
			
			for(var i:Number=0; i<msgAC.length; i++){
				
				 
				if(sms_mgmt_svr == msgAC[i].sms_mgmt_svr_name){
					
					if(0<i){
						rtnVal += ','+msgAC[i].message_number;	
					}else{
						rtnVal += msgAC[i].message_number;
					}
					
				}				
			}
			
			return rtnVal;
		}
		
		

	
	}
}