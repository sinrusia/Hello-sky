package com.wemb.tobit.pure.controller
{
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class CriticalAlarmCommand extends SimpleCommand
	{
		public function CriticalAlarmCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var sound:Sound = new Sound(new URLRequest("/assets/sound/error.mp3"));
			sound.play(0, 5);
		}
	}
}