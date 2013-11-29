package com.wemb.tobit.pure.model
{
	import com.wemb.tobit.core.ApplicationConfig;
	import com.wemb.tobit.vo.Request;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class TobitRTMPProxy extends Proxy
	{
		public static const NAME:String = "TobitRTMPProxy";
		
		private var nc:NetConnection;
		
		private var url:String = "";
		
		private var scope:String = "tobit";
		
		private var port:String = "3277";
		
		private var reConnCount:int = 0;
		
		private var reConnectionTimer:Timer;
		
		//요청한 요청 command 목록
		private var requestCommends:ArrayCollection;
		
		public function TobitRTMPProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
			nc  = new NetConnection();
			nc.addEventListener( NetStatusEvent.NET_STATUS,			netStatusHandler);
			nc.addEventListener( AsyncErrorEvent.ASYNC_ERROR,		netASyncError);
			nc.addEventListener( SecurityErrorEvent.SECURITY_ERROR,	netSecurityError);
			nc.addEventListener( IOErrorEvent.IO_ERROR,				netIOError);
			nc.objectEncoding	= ObjectEncoding.AMF3;
			
			if(port && port != ""){
				url = "rtmp://" + ApplicationConfig.getInstance().getDoaminName() +  ":" + port + "/" + scope;
			}else{
				url = "rtmp://" + ApplicationConfig.getInstance().getDoaminName() +  "/" + scope;
			}
			
			trace("RTMP Connecting trye to : ", url);
			
			nc.connect(url);
			
			//command list 생성
			requestCommends = new ArrayCollection();
			
			// Timer 생성
			reConnectionTimer = new Timer(500);
			reConnectionTimer.addEventListener(TimerEvent.TIMER, reConnectionHandler);
		}
		
		
		private function netStatusHandler( event:NetStatusEvent ):void 
		{
			var infoCode:String = event.info.code;
			
			switch (infoCode) 
			{
				case "NetConnection.Connect.Success":
					trace("NetConnection.Connect.Success");
					reConnCount = 0;
					nc.client = new TobitRTMPMessageClient();
					break;
					
				case "NetConnection.Connect.Rejected":
					trace("NetConnection.Connect.Rejected");
					break;
					
				case "NetConnection.Connect.Failed":
				case "NetConnection.Connect.Closed":
					trace("NetConnection.Connect.Failed");
					if(!nc.connected && reConnCount < 4){
						reConnectionTimer.start();
					}
					break;
			}
		}
		
		public function process(request:Request):void
		{
			if(nc.connected){
				requestCommends.addItem(request.command);
				
				var rs:Responder = new Responder(onRemotingResult, onRemotingError);
				nc.call("process", rs, request);
			}else{
				trace("연결되지 않은 상태입니다.");
				if(!reConnectionTimer.running){
					reConnectionTimer.start();
				}
			}
		}
		
		private function netSecurityError(event:SecurityErrorEvent):void 
		{
			trace("<b>Security error</font></b>: " + event.text)
		}
				
		private function netIOError(event:IOErrorEvent):void 
		{
			trace("<b>I/O error</font></b>: " +    event.text);
		}
				
		private function netASyncError(event:AsyncErrorEvent):void 
		{
			trace("<b>Async error</font></b>: " + event.error.getStackTrace());
		}
		
		private function onRemotingResult( result : Object ) : void 
		{
			if(result is Request){
				trace(result.command);
				
				if( requestCommends.contains(result.command) )
				{
					requestCommends.removeItemAt(requestCommends.getItemIndex(result.command));
					//trace("삭제!!!!!", request.command);
				}
				else
				{
					trace("응답한 요청 목록이 없습니다.", result.command);
				}
	
				//trace("=================================================");
				var receiveTime:Date = new Date();
				var formatter:DateFormatter = new DateFormatter();
				formatter.formatString = "YYYY.MM.DD JJ:NN:SS";
				trace(formatter.format(receiveTime), result.command);
				
				if(result)
				{
					sendNotification(result.command, result);
				}
				else
				{
					trace("정상적인 Request결과를 얻지 못하였습니다.");
				}
			}else{
				throw new Error("정상적인 Request 결과를 얻지 못하였습니다.");
			}
		}
		
		private function onRemotingError( result : * ) : void 
		{
			var msg : String;
			if ( result is FaultEvent ) 
			{
				// AMF error
				msg = "AMF error received";
				var fault:Fault = result.fault;
				msg += "<br>   <b>description</b>: " + fault.faultString;
				msg += "<br>   <b>code</b>: " + fault.faultCode;
				if ( fault.faultDetail.length > 0 ) 
				{
					msg += "<br>   <b>details</b>: " + fault.faultDetail;
					for ( var s:int=0;s<fault.faultDetail.length;s++ ) {
						try {
							var stackTrace:Object = fault.faultDetail[ s ];
							msg += "<br>             at " 
												 + stackTrace.className 
												 + "(" + stackTrace.fileName 
												 + ":" + stackTrace.lineNumber + ")";
						} catch ( e:ReferenceError ) {
							break;
						}
					}
					msg += "<br>";
				}
			} 
			else 
			{
				// RTMP error
				msg = "RTMP error received";
				msg += "<br>   <b>level</b>: " + result.level;
				msg += "<br>   <b>code</b>: " + result.code;
				msg += "<br>   <b>description</b>: " + result.description;
				msg += "<br>   <b>application</b>: " + result.application;
			}
			
			trace(msg);
		}
		
		public function setBusyCursor(command:String):void
		{
			//CursorManager.setBusyCursor();
			//CursorManager.showCursor();
			//_cursorCommand = command;
		}
		
		private function reConnectionHandler(event:TimerEvent):void
		{
			reConnectionTimer.stop();
			if(nc){
				nc.connect(url);
				reConnCount++;
			}
		}
	}
}