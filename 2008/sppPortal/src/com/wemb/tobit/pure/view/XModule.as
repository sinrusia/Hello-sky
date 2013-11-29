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
	import com.wemb.tobit.pure.ApplicationFacade;
	import com.wemb.tobit.pure.Constants;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.core.Container;
	import mx.events.FlexEvent;
	import mx.modules.Module;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.INotifier;
	import org.puremvc.as3.vo.NotificationBody;

	public class XModule extends Module implements IMediator, INotifier
	{
		/**
		 * The name of the <code>Mediator</code>. 
		 * 
		 * <P>
		 * Typically, a <code>Mediator</code> will be written to serve
		 * one specific control or group controls and so,
		 * will not have a need to be dynamically named.</P>
		 */
		public static const NAME:String = 'Mediator';
		
		private var enableRegister:Boolean = true;
		
		private var isCreate:Boolean = false;
		
		[Bindable]
		public var initInfo:Object = null;
		
		
		/**
		 * Constructor.
		 */
		public function XModule()
		{
			this.mediatorName = name; 
			this.viewComponent = this;
			this.layout = "absolute"
			this.addEventListener(FlexEvent.REMOVE , removeHandler);
			this.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			
			facade.registerMediator(this);
			
		}
		
		protected function render(event:Event):void
		{
			trace("activate....", this);
		}
		
		protected function onShow(event:FlexEvent):void
		{
			trace("onShow...", this);
		}
		
		protected function onHide(event:FlexEvent):void
		{
			trace("onHide...", this);
		}
		
		protected function createHandler(event:FlexEvent):void
		{
			trace("create...", visible, initialized);
		}
		
		override public function set visible(value:Boolean):void
		{
			trace(visible, " -visible...", this);
			super.visible = value;
		}
		
		public function registerMediator(initInfo:Object = null):void
		{
			this.initInfo = initInfo;
			
			if(isCreate)
			{
				trace("register Xcanvas - ", isCreate, " - " , this);
				//하우 컴포넌트에서 XCanvas가 있는지 체크한다.
				registerXCanvas(this);
				// register mediator
				facade.registerMediator(this);
			}
			else
				enableRegister = false;
		}
		
		/**
		 * XCanvas 하위 자식 컨테이너를 모두 체크하여 XCanvas가 존재한다면 mediator에 추가한다.
		 * 
		 */
		private function registerXCanvas(container:Container):void
		{
			for each(var dispObj:DisplayObject in container.getChildren())
			{
				if(dispObj is Container)
				{
					if(dispObj is XCanvas)
					{
						XCanvas(dispObj).registerMediator(null);
					}
					else
					{
						registerXCanvas(dispObj as Container);
					}
				}
			}
		}
		
		public function removeMediator():void
		{
			trace("remove XCanvas - ", this);
			removeXCanvas(this);
			
			facade.removeMediator(mediatorName);
		}
		
		/**
		 * XCanvas 하위 자식 컨테이너를 모두 체크하여 XCanvas가 존재한다면 등록된 mediator에서 삭제한다.
		 * 
		 */
		private function removeXCanvas(container:Container):void
		{
			for each(var dispObj:DisplayObject in container.getChildren())
			{
				if(dispObj is Container)
				{
					if(dispObj is XCanvas)
					{
						XCanvas(dispObj).removeMediator();
					}
					else
					{
						removeXCanvas(dispObj as Container);
					}
				}
			}
		}
		
		private function removeHandler(event:FlexEvent):void
		{
			trace("remove XCanvas - ", this);
			removeXCanvas(this);
			facade.removeMediator(mediatorName);
		}
		
		private function creationCompleteHandler(event:FlexEvent):void
		{
			isCreate = true;
			if(!enableRegister){
				enableRegister = true;
				registerMediator(initInfo);
			}
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			return super.addChildAt(child, index);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
		}
		
		/**
		 * Get the name of the <code>Mediator</code>.
		 * @return the Mediator name
		 */		
		public function getMediatorName():String 
		{	
			return mediatorName;
		}

		/**
		 * Set the <code>IMediator</code>'s view component.
		 * 
		 * @param Object the view component
		 */
		public function setViewComponent( viewComponent:Object ):void 
		{
			this.viewComponent = viewComponent;
		}

		/**
		 * Get the <code>Mediator</code>'s view component.
		 * 
		 * <P>
		 * Additionally, an implicit getter will usually
		 * be defined in the subclass that casts the view 
		 * object to a type, like this:</P>
		 * 
		 * <listing>
		 *		private function get comboBox : mx.controls.ComboBox 
		 *		{
		 *			return viewComponent as mx.controls.ComboBox;
		 *		}
		 * </listing>
		 * 
		 * @return the view component
		 */		
		public function getViewComponent():Object
		{	
			return viewComponent;
		}

		/**
		 * List the <code>INotification</code> names this
		 * <code>Mediator</code> is interested in being notified of.
		 * 
		 * @return Array the list of <code>INotification</code> names 
		 */
		public function listNotificationInterests():Array 
		{
			return [ ];
		}

		/**
		 * Handle <code>INotification</code>s.
		 * 
		 * <P>
		 * Typically this will be handled in a switch statement,
		 * with one 'case' entry per <code>INotification</code>
		 * the <code>Mediator</code> is interested in.
		 */ 
		public function handleNotification( notification:INotification ):void {}
		
		/**
		 * Called by the View when the Mediator is registered
		 */ 
		public function onRegister( ):void {}

		/**
		 * Called by the View when the Mediator is removed
		 */ 
		public function onRemove( ):void {}

		// the mediator name
		protected var mediatorName:String;

		// The view component
		protected var viewComponent:Object;

		
		/**
		 * Create and send an <code>INotification</code>.
		 * 
		 * <P>
		 * Keeps us from having to construct new INotification 
		 * instances in our implementation code.
		 * @param notificationName the name of the notiification to send
		 * @param body the body of the notification (optional)
		 * @param type the type of the notification (optional)
		 */ 
		public function sendNotification( notificationName:String, body:Object=null, type:String=null, busyCursor:Boolean=false ):void 
		{
			facade.sendNotification( notificationName, body, type, busyCursor );
		}
		
		/**
		 * Tobit 서비스의 일괄적인 요청을 위해서 추가된 메소드입니다.
		 * <p>
		 * tobitServic
		 * <p>
		 * @param command the name of the BeanName and MethodName
		 * @param body the body of the notification (optional)
		 */
		public function sendTobitService( command:String, body:Object = null, busyCursor:Boolean=false):void
		{
			var notificationBody:NotificationBody = new NotificationBody();
			notificationBody.requestBody = body;
			notificationBody.requestPage = this.name;
			sendNotification( Constants.TOBIT_SERVICE, notificationBody, command, busyCursor );
		}
		
		/**
		 * 한꺼번에 중복해서 Tobit 서비스의 일괄적인 요청을 위해서 추가된 메소드입니다.
		 * <p>
		 * tobitService
		 * <p>
		 * @param command the name of the BeanName and MethodName
		 * @param body the body of the notification (optional)
		 * @param busyCursor busyCursor을 보이졀주에 대한 설정, 기본값은 false이다.
		 */
		public function sendTobitRTMP( command:String, body:Object = null, busyCursor:Boolean = false):void
		{
			sendNotification( Constants.TOBIT_RTMP, body, command, busyCursor );
		}
		
		public function sendTobitHttpService( command:String, body:Object = null, busyCursor:Boolean = false):void
		{
			sendNotification(Constants.TOBIT_HTTP_SERVICE, body, command, busyCursor);
		}	
						
		// Local reference to the Facade Singleton
		protected var facade:IFacade = ApplicationFacade.getInstance();
		
	}
}