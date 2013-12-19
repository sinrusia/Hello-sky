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
	import com.wemb.tobit.core.ApplicationConfig;
	import com.wemb.tobit.pure.Constants;
	import com.wemb.tobit.vo.Request;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.managers.CursorManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.mxml.RemoteObject;
	

	public class TobitServiceProxy extends Proxy implements IProxy, IResponder
	{
		private var logger:ILogger;
		
		public static const NAME:String = "TobitServiceProxy";
		
		private var _service:RemoteObject;
		
		private var _cursorCommand:String = "";
		
		private var _loaderCommandList:ArrayCollection;
		
		//요청한 요청 command 목록
		private var requestCommends:ArrayCollection;
		
		private var sequenceTimer:Timer;
		
		private var requestQueue:Array;
		
		public function TobitServiceProxy(data:Object=null)
		{
			super(NAME, data);
			logger = Log.getLogger(this.getProxyName());
			
			_service = new RemoteObject();
			_service.destination	= "tobitService";
			_service.source			= "EchoService";
			_service.endpoint		= "gateway";
			// command list 생성
			requestCommends = new ArrayCollection();
			// preloader을 로딩하는 명령 리스트
			_loaderCommandList = new ArrayCollection();
			
			// generate queue
			requestQueue = new Array();
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
			trace("Request : ", request.command);
			var token:AsyncToken;
			
			if(ApplicationConfig.getInstance().SEQUENTIAL_CALL == true){
				// 요청방식이 순차적요청일 경우 타이머를 생성하도록 한다.
				if(sequenceTimer == null){
					// generate timer
					sequenceTimer = new Timer(ApplicationConfig.getInstance().REQUEST_INTERVAL);
					sequenceTimer.addEventListener(TimerEvent.TIMER, timerProcess);
				}
				// if requestQueue is null then generate requestQueue
				if(requestQueue == null)
					requestQueue = new Array();
				
				if(sequenceTimer.running){
					// 타이머가 작동중이라면 요청 목록을 추가한다.
					requestQueue.push(request);
				}else{
					// send request object to server
					requestCommends.addItem(request.command);
					token = _service.process(request);
					token.addResponder(this);
					// start timer
					sequenceTimer.delay = ApplicationConfig.getInstance().REQUEST_INTERVAL;
					sequenceTimer.start();
				}
			}else{
				// send request object to server
				requestCommends.addItem(request.command);
				token = _service.process(request);
				token.addResponder(this);
			}
		}
		
		/**
		 * 순차타이머 이벤트 핸들러
		 */
		public function timerProcess(event:TimerEvent):void{
			// if requestQueue is null then generate requestQueue
			if(requestQueue == null)
				requestQueue = new Array();
			// process queue
			if(requestQueue.length > 0){
				// get request object
				var request:Request = requestQueue.shift();
				if(request){
					// send request object to server
					requestCommends.addItem(request.command);
					var token:AsyncToken = _service.process(request);
					token.addResponder(this);
				}
			}else{
				// stop timer
				sequenceTimer.stop();
			}
		}
		
		public function httpProcess(request:Request):void
		{
			trace("Http Request : ", request.command);
			requestCommends.addItem(request.command);
			
			var token:AsyncToken = _service.httpProcess(request);
			token.addResponder(this);
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
			trace("Response : ", request.command);
			if (requestCommends.contains(request.command)) {
				requestCommends.removeItemAt(requestCommends.getItemIndex(request.command));
			} else {
				trace("응답한 요청 목록이 없습니다.", request.command);
			}

			if(request)
			{
				if(_cursorCommand == request.command)
				{
					_cursorCommand = "";
					CursorManager.removeBusyCursor();
				}
				/*
				if(request.result.toString().substr(0, 61) == "<html><head><title>Apache Tomcat/6.0.0 - Error report</title>"){
					trace("xml이 없습니다. ", request.param.url);
					return;
				}
				*/
				
				//요청한 값을 적용후에 로딩한 preloader을 사라지게 한다.
				var index:int = 0;
				for each(var command:String in _loaderCommandList.source)
				{
					if(request.command == command)
					{
						trace("Remove Command", command);
						_loaderCommandList.removeItemAt(index);
						if(_loaderCommandList.length == 0)
						{
							sendNotification(Constants.LOAD_PRELOADER, {type:"close"});
						}
						break;
					}
					index++;
				}
				
				sendNotification(request.command, request, Commands.TOBIT_SERVICE);
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
			
			sendNotification(Constants.REQUEST_ERROR, result.message);
		}
		
		public function setBusyCursor(command:String):void
		{
			if(!_loaderCommandList)
				_loaderCommandList = new ArrayCollection();
			
			if(_loaderCommandList.length == 0)
			{
				sendNotification(Constants.LOAD_PRELOADER, {type:"load"});
			}
			trace("Add Loader Command", command);
			_loaderCommandList.addItem(command);
			_cursorCommand = command;
		}
		
		public function disconnect():void
		{
			if( _service )
			{
				_service.disconnect();
			}
			
			requestCommends.removeAll();
		}
	}
}