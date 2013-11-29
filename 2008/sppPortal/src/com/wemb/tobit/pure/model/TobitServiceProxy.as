/**
 *	Copyright (C) 2004-2009 WeMB INC. 
 *	All Rights Reserved.
 *	@date			:	2009-04-07
 *	@auther			:	고재학
 *	@ver			:	1.0
 *	@description 	:	RemoteObject를 이용해서 서비스 처리한다.
 *	
**/
package com.wemb.tobit.pure.model
{
	import com.wemb.tobit.vo.Request;
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.managers.CursorManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.mxml.RemoteObject;
	import mx.utils.ObjectUtil;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class TobitServiceProxy extends Proxy implements IProxy, IResponder
	{
		private var logger:ILogger;
		
		private var traceBol:Boolean = true;
		
		public static const NAME:String = "TobitServiceProxy";
		
		private var _service:RemoteObject;
		
		private var _cursorCommand:String = "";
		
		//요청한 요청 command 목록
		private var requestCommends:ArrayCollection;
		
		public function TobitServiceProxy(data:Object=null)
		{
			super(NAME, data);
			logger = Log.getLogger(this.getProxyName());			
			_service = new RemoteObject();
			_service.destination	= "tobitService";
			_service.source			= "EchoService";
			_service.endpoint		= "gateway";
			
			_service.showBusyCursor = false;
			//command list 생성
			requestCommends = new ArrayCollection();

		}
		
		/**
		 * tobitService의 process메소드를 콜하는 서버의 인터페이스를 정의하고 있고
		 * 실제 통신 요청이 이르어지는 부분이다.
		 * 
		 * @param request the request is instance of Request
		 * 
		 */
		public function process(request:Request):void
		{
			if(traceBol)
				trace(getLogTime(),">>> [PROC] Request : ", request.command , " request.param :",getDebugParseData(request.param))
				trace("");		
				
			requestCommends.addItem(request.command);
			
			var token:AsyncToken = _service.process(request);
			token.addResponder(this);
		}
		
		public function httpProcess(request:Request):void
		{
			if(traceBol)
				trace(getLogTime(),">>> [HTTP] Http Request : ", request.command," request.param :",getDebugParseData(request.param))
				trace("");
				
			requestCommends.addItem(request.command);
			
			var token:AsyncToken = _service.httpProcess(request);
			token.addResponder(this);
		}
		
		
		
		public function getDebugParseData(requestParam:Object):String{
			
			return ObjectUtil.toString(requestParam);
		}
		
		
		public function getLogTime():String{
			
			var receiveTime:Date = new Date();
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = "YYYY.MM.DD JJ:NN:SS";
			
			return "["+formatter.format(receiveTime)+"]";
		}
		
		
		
		/**
		 * 서비스요청에 대한 결과를 핸들링 하는 메소드이다.
		 * result 타입이 Object로 되어 있지만 실제로는 ResultEvent의 인스턴스이다.
		 * 
		 * @param result the result is instance of ResultEvent
		 * 
		 */
		public function result(result:Object):void
		{
			var request:Request = result.result as Request;
			
			if(traceBol)
				trace(getLogTime(),"<<< Response : ", request.command," request.result :");//getDebugParseData(request.result))
				trace("");
			
			
			if( requestCommends.contains(request.command) )
			{
				requestCommends.removeItemAt(requestCommends.getItemIndex(request.command));
				//trace("삭제!!!!!", request.command);
			}
			else
			{
				trace("응답한 요청 목록이 없습니다.", request.command);
			}

			//trace("=================================================");
			/* var receiveTime:Date = new Date();
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = "YYYY.MM.DD JJ:NN:SS";
			trace(formatter.format(receiveTime), request.command); */
			
			if(request)
			{
				if(_cursorCommand == request.command)
				{
					_cursorCommand = "";
					CursorManager.removeBusyCursor();
				}
				if(request.result.toString().substr(0, 61) == "<html><head><title>Apache Tomcat/6.0.0 - Error report</title>"){
					trace("xml이 없습니다. ", request.param.url);
					return;
				}
				sendNotification(request.command, request);
			}
			else
			{
				CursorManager.removeBusyCursor();
				
				trace("정상적인 Request결과를 얻지 못하였습니다.");
				//Alert.show("정상적인 Request결과를 얻지 못하였습니다. ", "에러");
			}
		}
		
		/**
		 * 서버요청이 실패할때 처리하는 메소드이다.
		 * 
		 */
		public function fault(result:Object):void
		{
			if( requestCommends.contains(result.token.message.body[0].command))
			{
				//trace("삭제!!!!!", result.token.message.body[0].command);
				requestCommends.removeItemAt(requestCommends.getItemIndex(result.token.message.body[0].command));
			}
			else
			{
				trace("응답한 요청 목록이 없습니다. - ", result.token.message.body[0].command);
			}
			
			if( _cursorCommand != "" )
			{
				_cursorCommand = "";
				CursorManager.removeBusyCursor();
			}
			
			//Alert.show("처리도중 에러가 발생하였습니다. 관리자에게 문의 하십시오.", "에러");
			trace(result.message);
		}
		
		public function setBusyCursor(command:String):void
		{
			CursorManager.setBusyCursor();
			//CursorManager.showCursor();
			_cursorCommand = command;
		}
		
		public function disconnect():void
		{
			if( _service )
			{
				//_service.disconnect();
			}
			
			requestCommends.removeAll();
		}
	}
}