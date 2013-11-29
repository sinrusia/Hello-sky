package com.wemb.tobit.pure.model
{
	import com.wemb.tobit.pure.ApplicationFacade;
	import com.wemb.tobit.vo.Request;
	
	public class TobitRTMPMessageClient
	{
		public function TobitRTMPMessageClient()
		{
		}
		
		public function message( obj:Object ):void
		{
			if(obj is Request){
				ApplicationFacade.getInstance()
					.sendNotification( obj.command, obj );
			}
		}
	}
}
