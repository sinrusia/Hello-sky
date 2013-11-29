package com.wemb.tobit.rpc
{
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;	
	
	public class GSHttpService  extends HTTPService
	{
		public function GSHttpService(rootURL:String=null, destination:String=null)
		{
			super(rootURL, destination);
			this.addEventListener(ResultEvent.RESULT,eventFunc);		
		}
		
		private function eventFunc(e:ResultEvent):void{		
		} 

	}
}