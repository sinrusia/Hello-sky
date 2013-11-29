package com.wemb.tobit.pure.controller
{
	import com.wemb.tobit.core.ApplicationConfig;
	import com.wemb.tobit.pure.Constants;
	import com.wemb.tobit.vo.Request;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class ApplicationConfigCommand extends SimpleCommand
	{
		public function ApplicationConfigCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			//어플리케이션 초기화 정보
			var request:Request = notification.getBody() as Request;
			
			if(request.result.config is Array)
				ApplicationConfig.getInstance().setApplicationConfig(request.result.config);
			else
				ApplicationConfig.getInstance().setApplicationConfig(ArrayCollection(request.result.config).source);
			
			if(null != request.result.menuList){
				//ApplicationConfig.getInstance().menuList = request.result.menuList;
				//sendNotification(Constants.CONFIG_CHANGE);
				// 환경설정 내용을 로딩한 후 무엇을 할것인가?
				// 메뉴를 로딩할 것인가??
				//sendNotification(Constants.MAIN_STARTUP);
			}
		}
	}	
}