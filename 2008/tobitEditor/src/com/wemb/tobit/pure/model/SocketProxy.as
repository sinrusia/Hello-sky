package com.wemb.tobit.pure.model
{
	import com.wemb.puremvc.patterns.proxy.Proxy;
	import com.wemb.tobit.pure.Constants;
	import com.wemb.tobit.utils.HashMap;
	import com.wemb.tobit.utils.TobitSocket;
	import com.wemb.tobit.vo.Request;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.system.Security;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	

	public class SocketProxy extends Proxy
	{
		/**
		 * 메세징 서비스 실패 횟수
		 * 
		 * <p>3회이상 실패시 Alert띄움</p> 
		 */		
		private var failCount:Number = 0;
		
		public static const NAME:String = "SocketProxy";
		
		public var lastMessageName:String = "";
		
		private var tSocket:TobitSocket;
		private var state:int = 0;
		
  		private const CR:int = 13; // Carriage Return (CR)
        private const WILL:int = 0xFB; // 251 - WILL (option code)
        private const WONT:int = 0xFC; // 252 - WON'T (option code)
        private const DO:int   = 0xFD; // 253 - DO (option code)
        private const DONT:int = 0xFE; // 254 - DON'T (option code)
        private const IAC:int  = 0xFF; // 255 - Interpret as Command (IAC)
        
        private var requestMap:HashMap = new HashMap();
        
        //private var timer:Timer;

		public function SocketProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		private function sockEventProgress(e:ProgressEvent):void{
			trace("*************** PROGRESS ****************************  ");
			trace(e.type, e.currentTarget);
		}
		
		public function connect():void
		{
			if ( tSocket == null )
			{
				tSocket = new TobitSocket();
				//tSocket.timeout = 5000;
				tSocket.addEventListener(Event.CONNECT, connectHandler);
	            tSocket.addEventListener(Event.CLOSE, closeHandler);
	           	tSocket.addEventListener(ErrorEvent.ERROR, errorHandler);
	            tSocket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				tSocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
	            tSocket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
				tSocket.addEventListener(ProgressEvent.PROGRESS, sockEventProgress);
			}
			
			try
			{
				Security.loadPolicyFile("xmlsocket://" + Constants.SYSMON_URL + ":" + Constants.SYSMON_PORT + "/crossdomain.xml");
				tSocket.connect( Constants.SYSMON_URL, Constants.SYSMON_PORT );
				
			}
			catch(error:Error)
			{
				close();
			}
			
			
			/* timer = new Timer(CommonVars.SOCKET_TIMEOUT);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.reset();
			timer.start(); */
		}
		
		/* private function timerHandler(e:TimerEvent):void
		{
			timer.reset();
			timer.stop();
			if( tSocket != null && tSocket.connected == false)
			{
				connect();
			}
		} */
		public function close():void 
		{
			if ( tSocket != null )
			{
				tSocket.close();
				tSocket.removeEventListener(Event.CONNECT, connectHandler);
	            tSocket.removeEventListener(Event.CLOSE, closeHandler);
	           	tSocket.removeEventListener(ErrorEvent.ERROR, errorHandler);
	            tSocket.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				tSocket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
	            tSocket.removeEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
				tSocket.removeEventListener(ProgressEvent.PROGRESS, sockEventProgress);
				tSocket = null;
				
				trace("*************** SOCKET CLOSE() ****************************  ");
			}
		}
		
		public function commandHandler(val:String, request:Request):void 
		{
			trace("소켓 호출 = ", val);
			if ( tSocket != null && tSocket.connected )
			{
				if(val.substr(0, 1) == "W" || val.substr(0, 1) == "C"){
					trace("맵에 저장", val.substr(0, 7));
					requestMap.put(val.substr(0, 7), request);
				} else {
					requestMap.put(val.substr(0, 4), request);
				}
				
				var sendCommand:String = getHeader(val) + String(val);

				if ( sendCommand == null ) return;
				var ba:ByteArray = new ByteArray();
				trace("sendCommand====", sendCommand);
				ba.writeMultiByte(sendCommand, "EUC-KR");
				tSocket.writeBytes(ba);
				
            	tSocket.flush();
            	
            	trace("\nsend command..\n");
			}
			else
			{
				trace("Socket이 연결되있지 않습니다.\n");
			}
		}
		
		private function getHeader(value:String):String
		{			
			var header:String = "LENG";
			var ba:ByteArray = new ByteArray();
			ba.writeMultiByte(value, "EUC-KR");
			
			var _length:String = String(ba.length);
			for( var i:int=0; i<(10-Number(_length.length)); i++)
			{
				header += "0";
			}
			
			header += ba.length;
			return header;
		}

        public function ioErrorHandler(event:IOErrorEvent):void 
        {
        	trace("*************** ioErrorHandler SOCKET CLOSE ****************************  ");
        	facade.sendNotification( Constants.SOCKET_STOP);
        	
        	close();
        	//connect();
            trace("Unable to connect: socket error.\n");
        }
        
        private function connectHandler(event:Event):void 
        {
            if (tSocket.connected) {
            	trace("*************** SOCKET START ****************************  ");
                facade.sendNotification( Constants.SOCKET_START);
            } else {
            	trace("*************** SOCKET STOP ****************************  ");
                facade.sendNotification( Constants.SOCKET_STOP);
                close();
        		//connect();
            }
        }
        
        private function closeHandler(event:Event):void
        {
        	trace("*************** closeHandler SOCKET CLOSE ****************************  ");
        	facade.sendNotification( Constants.SOCKET_STOP);
        	//connect();
        }	    

        private function errorHandler(event:ErrorEvent):void 
        {
        	trace("*************** errorHandler SOCKET CLOSE ****************************  ");
        	facade.sendNotification( Constants.SOCKET_STOP);
        	close();
        	//connect();
        	trace("Unable to connect: socket error.\n");
            trace("errorHandler: " + event.text + "\n");
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void 
        {
        	trace("*************** securityErrorHandler SOCKET CLOSE ****************************  ");
        	facade.sendNotification( Constants.SOCKET_STOP);
        	close();
        	//connect();
        	trace("Unable to connect: socket error.\n");
	        trace("securityErrorHandler: " + event.text + "\n");
	    }
	    
	    private var totalCount:Number = 0;
	 	private  var message:String = "";
        private function socketDataHandler(event:ProgressEvent):void 
        {
            var n:int = tSocket.bytesAvailable;
			message += tSocket.readMultiByte(n, "EUC-KR");
		
			if(message.substr(0, 4) == "LENG" && message.length == 14){
				totalCount = Number(message.substr(4));
				return;
			}
			
			var t_arr:Array = String(message).split("</DATA>");
			if(t_arr.length == 1){
				return;
			} else if(t_arr.length >= 2){
				message = t_arr.pop();
				var count:int = t_arr.length;
				for(var i:int=0; i<count; i++){
					
					dataSend(t_arr[i].toString()+"</DATA>");
				}
			}
        }
	
        private function dataSend(msg:String):void{
        	trace("msg", msg);
			// 키 값 W일 경우 체크하기 위해
			var keyString:String = msg.substr(14, 1);
			// 코드영역
			var coedPart:String = msg.substr(14, 7);
			// 코드 값		
            var code:String = coedPart.substr(0, 1) + "0" + coedPart.substr(2, 2);
            
            var value:String = msg.substr(21);
            
            var request:Request;
            
            var code1:String = "";
			if(keyString == "W" || keyString == "C"){
				value = msg.substr(21);
				code1 = coedPart.substr(0, 1) + "0" + coedPart.substr(2, 5);
				request = requestMap.getValue(code1.toString()) as Request;
			} else {
				request = requestMap.getValue(code.toString()) as Request;
			}
			
			trace("맵 저장 데이터 뽑아오기", code1);
			if(request != null){
				try{
					var xml:XML = new XML(value);
					request.result = new XML(value);
					var _code:String = String(code).substr(0, 4);
					sendNotification( _code, request );
//					sendNotification( code, request );		
				} catch(e:Error){
					trace("socket xml 에러");
					trace(e.message);
				}
			} else {
				trace("socket 해당 키값이 존재하지 않습니다.", code1);
			}
        }
	}
}