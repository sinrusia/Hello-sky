////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.pure.model
{
	import com.wemb.puremvc.Commands;
	import com.wemb.puremvc.interfaces.IProxy;
	import com.wemb.puremvc.patterns.observer.Notification;
	import com.wemb.puremvc.patterns.proxy.Proxy;
	import com.wemb.tobit.utils.HashMap;
	import com.wemb.tobit.vo.Request;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	
	/**
	 * @author jaehag
	 */
	public class HttpServiceProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String = "HttpServiceProxy";
		
		public function HttpServiceProxy(data:Object=null)
		{
			super(NAME, data);
			
			logger = Log.getLogger(this.getProxyName());
		}
		
		
		private var logger:ILogger;
		
		private var _service:HTTPService
		
		private var _cursorCommand:String = "";
		
		private var requestMap:HashMap = new HashMap();
		
		private var httpServiceMap:HashMap = new HashMap();
		
		/**
		 * tobitService의 process메소드를 콜하는 서버의 인터페이스를 정의하고 있고
		 * 실제 통신 요청이 이르어지는 부분이다.
		 * 
		 * @param request the request is instance of Request
		 * 
		 */
		public function process(command:String, param:Object):void{
			
			/** 이중화체크 - Tim 일경우와 Pim 일경우만 if문을 태운다.
			 if( IpChangeModelLocator.getInstance().duplexingUrlCheck( request.param['param'] ) == false ){
			 request.param['param'] = IpChangeModelLocator.getInstance().urlChange( request.param["param"] );
			 }
			 이중화체크 **/
			
			trace("[param == " + param +"]");
			
			requestMap.put(command , param);
			var _service:HTTPService = new HTTPService();
			_service.resultFormat = "e4x";
			_service.url = command;
			_service.concurrency= "multiple";
			_service.method = "POST";
			_service.request = param;
			_service.addEventListener(ResultEvent.RESULT, result);
			_service.addEventListener(FaultEvent.FAULT, fault);
			_service.send();
			httpServiceMap.put(_service, _service);
		}
		
		public function remove():void{
			var map:Array = httpServiceMap.getKeys();
			var cnt:int = map.length;
			for(var i:int=0; i<cnt; i++){
				HTTPService(map[i]).disconnect();
				HTTPService(map[i]).removeEventListener(ResultEvent.RESULT, result);
				HTTPService(map[i]).removeEventListener(FaultEvent.FAULT, result);
			}
		}
		
		public function result(result:ResultEvent):void {
			if (result != null) {
				// 요청 url을 command로 사용한다.
				var command:String			= result.currentTarget.url;
				// 요청 url
				var url:String				= result.currentTarget.url;
				// 요청 파라미터
				var params:Object			= result.currentTarget.request;
				// request page name
				var requestPage:String		= params.requestPage;
				
				var request:Request = new Request();
				request.command = command;
				request.param = params;
				request.pageName = requestPage;
				
				var xmlNew:XML = new XML(result.result.toString());
				request.result = xmlNew;
				sendNotification( command, request, Commands.HTTP_SERVICE);	
			}
		}
		
		/**
		 * 서버요청이 실패할때 처리하는 메소드이다.
		 * 
		 */
		public function fault(result:Object):void{
			var t_fault:FaultEvent = result as FaultEvent;
			/*var funcName:String = HTTPService(t_fault.currentTarget).request["funcName"];
			var url:String = HTTPService(t_fault.currentTarget).request["url"];
			var request:Request = requestMap.getValue(funcName+"_"+url) as Request;*/
			
			var command:String = t_fault.currentTarget.request["command"];
			var url:String = t_fault.currentTarget.request["url"];
			
			var request:Request = new Request();
			request.command = command;
			
			if(request != null){
				//request.param["result"] = "fail";	
				try{
					//var xmlNew:XML = new XML(t_fault.fault.toString());
					//request.result = xmlNew;
					//sendNotification( funcName, request );
				} catch(err:Error){
					//Alert.show("XML에 문제가 있습니다."+url);
				}
				
				/** 이중화체크
				 if( IpChangeModelLocator.getInstance().duplexingUrlCheck( url ) ){
				 IpChangeModelLocator.getInstance().duplexingCheck( 'false' , url );
				 } 
				 이중화체크 **/
			}
			
			t_fault = null;
			command = null;
			url = null;
			request = null;
			result = null;
		}
	}
}