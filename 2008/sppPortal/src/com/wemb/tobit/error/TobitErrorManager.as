package com.wemb.tobit.error
{
	import com.wemb.tobit.components.common.ErrorMessage;
	import com.wemb.tobit.events.TobitDataEvent;
	import com.wemb.tobit.utils.Logger;
	import com.wemb.tobit.vo.TobitError;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.managers.PopUpManager;
	
	/**
	 * TOBIT Error Manager
	 * 
	 * 2008. 8. 6
	 * THLIFE
	 * 
	 * ServiceManger 에서 나오는 FaultEvent, Exception 을 관리한다.
	 * 동일 processID 에 대해 3번의 메세지가 나오면 사용자에게 알린다.
	 */
	public class TobitErrorManager
	{
		private static var _instance:TobitErrorManager;
		
		//모든 에러를 담는 AC
		private var errorAC:ArrayCollection;
		
		//팝업창에 보여질 AC
		private var _showErrorAC:ArrayCollection;
		
		//동일 메세지 체크 변수
		private const MAXERRORCOUNT:Number = 3;
		
		private var popup:ErrorMessage;
		
		public function TobitErrorManager()
		{
			if( _instance != null )
			{
				Logger.debug( "Tobit Error Manager Create Error" );
			}
			_instance = this;
			
			initData();
		}
		
		public static function getInstance():TobitErrorManager
		{
			if( _instance == null )
			{
				_instance = new TobitErrorManager();
			}
			
			return _instance;
		}
		
		//데이터 초기화
		private function initData():void
		{
			errorAC = new ArrayCollection();
			showErrorAC = new ArrayCollection();
		}
		
		//에러 추가
		public function addError( error:TobitError ):void
		{
			if( errorAC == null )
				errorAC = new ArrayCollection();
			
			errorAC.addItem( error );
			checkError( error );
		}
		
		// ServiceManager ResultEvent의 Catch에서 잡은 익셉션
		public function addExceptionError( processID:String, error:Error ):void
		{
			var errorObj:TobitError = new TobitError();
			
			errorObj.processID = processID;
			errorObj.errTime = new Date();
			errorObj.errCode = error.message;
			errorObj.errMessage = error.message;
			
			addError( errorObj );
		}
		
		//에러 확인후 맥스 에러값 이상일경우 팝업
		private function checkError( error:TobitError ):void
		{
			var processID:String = error.processID;
			var errCode:String = error.errCode;
			
			var cnt:Number = 0;
			var errorVO:TobitError;
			
			for( var i:Number=0; i< errorAC.length; i++ )
			{
				var tempVO:TobitError = errorAC[i];
				
				if( processID == tempVO.processID && errCode == tempVO.errCode )
				{
					errorVO = tempVO;
					cnt++;
				}
			}
			
			if( cnt >= MAXERRORCOUNT )
			{
				showError( errorVO );
			} 
		}
		
		//팝업창 보이기
		private function showError( error:TobitError ):void
		{
			if( showErrorAC.length > 13 ) showErrorAC.removeItemAt(0);
			showErrorAC.addItem( error );
			
			if( popup == null )
			{
				//popup = ErrorMessage( PopUpManager.createPopUp( Application.application.tobitMapMain, ErrorMessage, false ) );
				//popup.addEventListener( TobitDataEvent.ERROR_POPUP_CLOSE, popupCloseHandler );
				//PopUpManager.centerPopUp( popup );
			}
			else
			{
				PopUpManager.bringToFront( popup );
			}
		}
		
		private function popupCloseHandler( event:TobitDataEvent ):void
		{
			removeAllError();

			popup.removeEventListener( TobitDataEvent.ERROR_POPUP_CLOSE, popupCloseHandler );
			PopUpManager.removePopUp( popup );

			popup = null;
		}
		
		//해당 에러 삭제
		private function removeError( error:TobitError ):Boolean
		{
			return true;
		}
		
		//모든 에러 삭제
		private function removeAllError():void
		{
			errorAC = null;
			showErrorAC = null;
			
			errorAC = new ArrayCollection();
			showErrorAC = new ArrayCollection();
		}
		
		public function set showErrorAC( value:ArrayCollection ):void
		{
			this._showErrorAC = value;
		}
		
		[Bindable]
		public function get showErrorAC():ArrayCollection
		{
			return this._showErrorAC;
		} 
	}
}