/**
 *	Copyright (C) 2004-2009 WeMB INC. 
 *	All Rights Reserved.
 *	@date			:	2009-04-07
 *	@auther			:	고재학
 *	@ver			:	1.0
 *	@description 	:	LCDS 메시징 서비스를 처리한다.
 *	
**/
package com.wemb.tobit.pure.model
{
	import com.wemb.tobit.pure.Constants;
	import com.wemb.tobit.vo.RTMPStatus;
	import com.wemb.tobit.vo.Request;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.managers.CursorManager;
	import mx.messaging.ChannelSet;
	import mx.messaging.Consumer;
	import mx.messaging.Producer;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.MessageAckEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class MessageProxy extends Proxy
	{
		/**
		 * Producer 
		 */		
		private var _producer:Producer;
		
		/**
		 * Consumer 
		 */		
		private var _consumer:Consumer;
		
		/**
		 * 메세징 서비스 실패 횟수
		 * 
		 * <p>5회이상 실패시 Alert띄움</p> 
		 */		
		private var failCount:Number = 0;
		
		public static const NAME:String = "MessageProxy";
		
		public var lastMessageName:String = "";
		
		/**
		 * 재접속 Flag
		 * 
		 * <p>Client 사용자 입력에 의해 UI가 수정될 경우를 대비해 Flag값으로 재접속 여부를 제어</p> 
		 */           
		private var reConnectFlag:Boolean = true;
		
		private var delayTimer:Timer;
		
		public function MessageProxy(data:Object=null)
		{
			super(NAME, data);
			
			//Producer 등록
			_producer = new Producer();
			_producer.channelSet = new ChannelSet(["my-rtmp"]);
			_producer.destination = "tobitMessage";
			_producer.addEventListener( MessageAckEvent.ACKNOWLEDGE, function(event:MessageAckEvent):void{
																		trace( "AckEvent", event.message.body );
																	} );
			 
			_producer.addEventListener( MessageFaultEvent.FAULT, onMessageFault );
			
			//Consumer 등록
			_consumer = new Consumer();
			_consumer.channelSet = new ChannelSet(["my-rtmp"]);
			_consumer.destination = "tobitMessage";
			_consumer.resubscribeAttempts = 3;
			_consumer.addEventListener( ChannelEvent.CONNECT, 
														function(event:ChannelEvent):void{
														 	trace( "Consumer Connect", event.toString() );
														 	facade.sendNotification( Constants.RTMP_CONNECTION_STATUS, 
														 							 new RTMPStatus(RTMPStatus.NORMAL, "정상 작동중입니다.") );
														 	failCount = 0;
														 	
														 	//var params:Object = new Object();
														 	//params.messageName = lastMessageName;
														 	//facade.sendTobitService( Constants.REGISTER_MESSAGENAME, params); 
														} );
														
			_consumer.addEventListener( ChannelEvent.DISCONNECT, 
														function(event:ChannelEvent):void{
															trace( "Consumer DisConnect", event.toString());
															reConnect();
														});
			_consumer.addEventListener( MessageEvent.MESSAGE, onMessage );
			_consumer.addEventListener( MessageFaultEvent.FAULT, onMessageFault );
			_consumer.subscribe();
			
			delayTimer =  new Timer(10000, 1);
			delayTimer.addEventListener(TimerEvent.TIMER, delayTimerHandler );
		}

		/**
		 * Consumer Connect
		 *  
		 * @return 
		 * 
		 */                 
		public function connect():Boolean
		{
			//비접속중이면, 접속
			if( !_consumer.connected )
			{
				reConnectFlag = true;
				_consumer.subscribe();
				
				trace( "KCC MessageProxy Consumer - Connect!");
				
				return true;
			}
			else
			{
				trace( "KCC MessageProxy Consumer - Connected already!");
			}
			
			return false;
		}
		
		
		/**
		 * Consumer DisConnect
		 * 
		 * @return 
		 * 
		 */           
		public function disConnect():Boolean
		{
			//접속중이면, Disconnect
			if( _consumer.connected )
			{
				reConnectFlag = false;
				_consumer.disconnect();
				trace( "KCC MessageProxy Consumer - Disconnect!");
				return true;
			}
			else
			{
				trace( "KCC MessageProxy Consumer - Disconnected already!");
			}
			
			return false;
		}

		/**
		 * Mesaaging Service 재접속 시도 
		 * 
		 */           
		private function reConnect():void
		{
			if( !reConnectFlag ) return;
			
			if( failCount >= 5 )
			{
				delayTimer.start();
				facade.sendNotification( Constants.RTMP_CONNECTION_STATUS, 
						 new RTMPStatus(RTMPStatus.ERROR, "메세징 채널이 끊겼습니다.\n관리자에게 문의 하시기 바랍니다.") );
				//facade.sendNotification( Constants.RTMP_CONNECTION_STATUS, 
				//		 new RTMPStatus(RTMPStatus.ERROR, "We've lost access real-time channel. Please contact your administrator.") );
				//Alert.show( "메세징 채널이 끊겼습니다.\n관리자에게 문의 하시기 바랍니다.", "알림", Alert.OK | Alert.NONMODAL,null, alertCloseHandler);
			}
			else
			{
				failCount++;
				_consumer.subscribe();
				trace( "\n - KCC Messaging Service에 재접속합니다.\n - Fail Count: " + failCount );
				facade.sendNotification( Constants.RTMP_CONNECTION_STATUS, 
										 new RTMPStatus(RTMPStatus.RECONNECT, "KCC Messaging Service에 재접속합니다.\n - Fail Count: "+failCount ) );				
				//facade.sendNotification( Constants.RTMP_CONNECTION_STATUS, 
				//						 new RTMPStatus(RTMPStatus.RECONNECT, "We've lost access real-time channel. Retry Count : "+failCount ) );
			}
		}
		
		/**
		 * Messaging Service Result Event Handler
		 *  
		 * @param event
		 * 
		 */		
		private function onMessage( event:MessageEvent ):void
		{
			/*
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(event);
			bytes.position = 0;
			*/
 			CursorManager.removeBusyCursor();
			
			var request:Request = event.message.body as Request;
			
			//마지막으로받은 메시지 명이 무엇인지 저장한다.
			lastMessageName = request.command;
			
			sendNotification( request.command, request );
		}
		
		
		/**
		 * Messaging Service Fault Event Handler 
		 * 
		 * @param event
		 * 
		 */		
		private function onMessageFault( event:MessageFaultEvent ):void
		{
			CursorManager.removeBusyCursor();
			
			trace( "Tobit Message Proxy Fault: " + event.message.toString() );
			
			reConnect();
		}
		
		private function alertCloseHandler(event:Event):void
		{
			connect();
		}
		
		private function delayTimerHandler(event:TimerEvent):void
		{
			delayTimer.stop();
			
			if( !_consumer.connected )
			{
				connect();
			}
		}
	}
}