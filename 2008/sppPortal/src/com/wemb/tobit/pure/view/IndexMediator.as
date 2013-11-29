/**
 *	Copyright (C) 2004-2009 WeMB INC. 
 *	All Rights Reserved.
 *	@date			:	2009-04-07
 *	@auther			:	고재학
 *	@ver			:	1.0
 *	@description 	:	
 *	
**/
package com.wemb.tobit.pure.view
{
	import com.wemb.tobit.core.ApplicationConfig;
	import com.wemb.tobit.core.TobitApplication;
	import com.wemb.tobit.pure.Constants;
	import com.wemb.tobit.vo.Request;
	import com.wemb.tobit.vo.UserInfo;
	
	import mx.controls.Alert;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class IndexMediator extends Mediator
	{
		public static const NAME:String	= "IndexMediator";
		
		public function IndexMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				Constants.LOGIN,
				Constants.LOGOUT,
				Constants.ISLOGIN,
				Constants.RTMP_CONNECTION_STATUS
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case Constants.LOGIN:
					var request:Request = notification.getBody() as Request;
					var loginResult:Object = request.result;
					
					//로그인 OFF상태로 초기화 한다.
					TobitApplication.authStatus =  Constants.LOGIN_OFF;
					
					if( loginResult is String )
					{
						//login 실패 처리를 수행합니다.
						if( loginResult == "off" )
						{
							// 계정 정보가 존재하지 않습니다.
							Alert.show("아이디 또는 비밀번호 입력이 잘못 되었습니다.\n다시 한번 시도하여 주십시오.", "알림", Alert.OK);
						}
						else if( loginResult == "error" )
						{
							// 디비에러발생
							Alert.show("DB연결이 정상적으로 처리되지 않았습니다.\n관리자에게 문의 하십시오.", "알림", Alert.OK);
						}
						else if( loginResult == "enable" )
						{
							// 로그인 할 수 없는 계정입니다.
							Alert.show("로그인할 수 없는 계정입니다.\n관리자에게 문의 하십시오.", "알림", Alert.OK);
						}
					}
					else
					{
						//로그인 사용자 정보를 저장한다.
						var userInfo:UserInfo = loginResult as UserInfo;
						
						if( !userInfo.usergradeId || userInfo.usergradeId == "")
						{
							//권한 없음
							Alert.show("권한이 없습니다.\n관리자에게 문의 하십시오.", "알림", Alert.OK);
							
							return;
						} 
						
						ApplicationConfig.getInstance().userInfo = userInfo;

						//[kojh]2009.03.09 로그인 후 설정 내용을 불러오도록 추가
						//설정내용을 로딩한다.
						//facade.sendTobitService(Constants.GET_APP_CONFIG, {userInfo:userInfo});  //여기 없음 메뉴로드 안됨.
						
						//로그인 상태로 변경한다.
						TobitApplication.authStatus =  Constants.LOGIN_ON;
						
						//로그인 처리중 에러
						//Alert.show("로그인 처리중 에러가 발생하였습니다.\n관리자에게 문의 하십시오.", "알림");
						view.viewChange(view.scrnMain);
					}
					
				break;
				
				case Constants.LOGOUT:
					TobitApplication.authStatus =  Constants.LOGIN_OFF;
					view.viewChange(view.scrnLogin);
				break;
				
				case Constants.ISLOGIN:
					if( TobitApplication.authStatus == Constants.LOGIN_OFF )
					{
						//view.viewChange(view.scrnLogin);
					}
					else
					{
						try
						{							
							request = notification.getBody() as Request;
							//로그인 사용자 정보를 저장한다.
							ApplicationConfig.getInstance().userInfo = request.result as UserInfo;
							
							//[kojh]2009.03.09 로그인 후 설정 내용을 불러오도록 추가
							//설정내용을 로딩한다.
							facade.sendTobitService(Constants.GET_APP_CONFIG, null, true);
							
							//view.viewChange(view.scrnMain);
						}
						catch(err:Error)
						{
							//로그인 처리중 에러
							Alert.show("로그인 처리 중 에러가 발생하였습니다.\n관리자에게 문의 하십시오.", "알림");
						}
					}
				break;
			}
		}
		
		private function get view():*
		{
			return viewComponent as Index;
		}
	}
}