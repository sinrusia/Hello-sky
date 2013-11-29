package com.wemb.tobit.managers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class AlertSoundManager extends EventDispatcher
	{
		private static var _instance:AlertSoundManager;
		
		/**
		 * Sound Toggle
		 * 
		 * @default true
		 */
		/* [Bindable]
		public static var soundToggle:Boolean = true; */
		

		public  var soundOnOffFlag:Boolean = true;
		
		private var sound:Sound;
		
		private var soundChannel:SoundChannel;
		
		private var readyStatus:Boolean;
		
		private var laterPlay:Boolean;
		
		public var isSound:Boolean = false;
		
		/* public var soundOnOffFlag:Boolean = true; */
		
		
		
		public function AlertSoundManager()
		{
			if( _instance )
			{
				throw new Error( "AlertSoundManager create Error: " );
			}
			
			soundLoad();
		}
		
		public static function getInstance():AlertSoundManager
		{
			if( !_instance )
			{
				_instance = new AlertSoundManager();
			}
			
			return _instance;
		}
		
		private function soundLoad():void
		{
			sound = new Sound();
			//load complete
			sound.addEventListener(Event.COMPLETE, function(event:Event):void{
				readyStatus = true;
				
				if( laterPlay ) playSound();
			});
			
			sound.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void{
				trace( "IOErrorEvent.IO_ERROR: ", event.text );
			});
			var req:URLRequest = new URLRequest("./assets/sounds/error.mp3");
			sound.load(req);
		}
		
		public function playSound():void
		{
			
			//trace(" AlertSoundManager :: " + soundOnOffFlag);
			
			if(soundOnOffFlag){
				
				if( soundChannel ) return;
				
				if( readyStatus ) {
					
					if(!isSound){
						laterPlay = false;
						
						stopSound();
						soundChannel = sound.play(0, int.MAX_VALUE);
						isSound = true;
					}
					
				} else {
					laterPlay = true;
				}
				
			}
		}
		
		public function stopSound():void
		{
			if( soundChannel )
			{
				soundChannel.stop();
				isSound = false;
				soundChannel = null;
			}
		}
	}
}