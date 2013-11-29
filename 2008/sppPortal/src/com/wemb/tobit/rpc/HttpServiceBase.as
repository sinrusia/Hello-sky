package com.wemb.tobit.rpc
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.containers.Canvas;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	/**
	 * 데이터 폴링 컴포넌트의 껍데기.
	 * 현재는 하나의 컴포넌트에 데이터 폴링 컴포넌트 하나임. 
	 * 
	 * 
	 * 
	 * */
	public class HttpServiceBase extends Canvas
	{
		private var httpSvc:GSHttpService;
		private var faultCnt:Number = 0;
		private var pollingTimer:Timer;
		private var __url:String = "";
		public function HttpServiceBase()
		{
		}

		/**
		 * http 서비스  객체를 생성한다.
		 * 
		 * @param _url : url 값.
		 * */
		public function createHttpSvc(_url:String):void{
							
			httpSvc = new GSHttpService();
			__url = _url;
			httpSvc.url=_url;
			httpSvc.resultFormat = "e4x";
//			httpSvc.requestTimeout = ContainsVar.HTTP_REQUEST_TIMEOUT;						
			httpSvc.addEventListener(FaultEvent.FAULT, onFaultHttpService);
			httpSvc.addEventListener(ResultEvent.RESULT, onResultHttpServiceSuccess);
			httpSvc.send();
		}
		
		/**
		 * http 서비스  객체를 삭제한다.
		 * 
		 * @param _url : url 값.
		 * */
		public function removeHttpSvc():void{
			
			if(httpSvc == null) return;
			
			httpSvc.disconnect()
			httpSvc.removeEventListener(FaultEvent.FAULT, onFaultHttpService);
			httpSvc.removeEventListener(FaultEvent.FAULT, onResultHttpServiceSuccess);
			httpSvc = null;
			
		}
				
		private function onFaultHttpService(e:FaultEvent):void{
			/*
			var faultCode:String = e.fault.faultCode;
			trace(e.message);
			if(faultCode == "Client.Error.RequestTimeout" || faultCode == "Server.Error.Request"){
				faultCnt = faultCnt + 1;
				if(faultCnt > 3 || pollingTimer == null){
					Alert.show("네트웍 연결 상태를 확인 하시기 바랍니다.");	
					removeHttpSvc();
					removeTimer();				
				}
			} else if(faultCode == "Server.Processing"){	
				Alert.show("네트웍 연결 상태를 확인 하시기 바랍니다.");			 
			}
			*/
		}
			

		
		/**
		 * 타이머   객체를 생성한다.
		 * 
		 * @param msgPollingTime : 폴링 타임 주기
		 * */
		public function createTimer(msgPollingTime:uint):void{
						
			removeTimer();						
			pollingTimer = new Timer(msgPollingTime);
			pollingTimer.addEventListener(TimerEvent.TIMER,timerEventHandler);
			pollingTimer.start();
		}
		
		/**
		 * 타이머   객체를 삭제한다.
		 *
		 * */
		public function removeTimer():void{
			if(pollingTimer != null){
				pollingTimer.stop();
				pollingTimer.removeEventListener(TimerEvent.TIMER,timerEventHandler);
				pollingTimer = null;
			}
		}			
		
		private function timerEventHandler(e:TimerEvent):void{			
			if(httpSvc != null)	
				sendHttp();
		}		
		
		private function sendHttp():void{
			httpSvc.url=__url;
			httpSvc.send();
		}		
		
		private function onResultHttpServiceSuccess(e:ResultEvent):void{
			faultCnt = 0;
			onResultHttpService(e);
		}
				
		protected function onResultHttpService(e:ResultEvent):void	{}		
	}
}