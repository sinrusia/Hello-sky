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
	
	import mx.containers.Canvas;
	import mx.core.Container;
	import mx.effects.Fade;
	import mx.effects.Parallel;
	import mx.effects.Sequence;
	import mx.effects.Zoom;
	import mx.effects.easing.Exponential;
	import mx.events.CloseEvent;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.INotifier;
	import org.puremvc.as3.vo.NotificationBody;
	
	[Event(name="close", type="mx.events.CloseEvent")]
	public class XPopup extends Canvas implements IMediator, INotifier
	{
		private var start_sequence:Sequence;
		private var end_sequence:Sequence;
		public static const NAME:String = 'Mediator';
		
		public function XPopup()
		{
			//mediator name setting
			mediatorName = name;
			viewComponent = this;
			this.horizontalScrollPolicy = "false";
			this.verticalScrollPolicy = "false";
			
			var zoom:Zoom = new Zoom();
			var e_zoom:Zoom = new Zoom();
			
			var fade:Fade = new Fade();
			start_sequence = new Sequence(); 
			var parallel:Parallel = new Parallel();
			var e_parallel:Parallel = new Parallel();
			
			zoom.easingFunction = Exponential.easeOut;
			zoom.duration = 600;	
			parallel.addChild(zoom);	
			parallel.addChild(fade);	
			start_sequence.addChild(parallel);
			
			end_sequence = new Sequence();
			e_zoom.zoomHeightTo = 0;
			e_zoom.zoomWidthTo = 0;
			e_zoom.easingFunction = Exponential.easeOut;
			e_zoom.duration = 400;				
			e_parallel.addChild(fade);	
			e_parallel.addChild(e_zoom);	
			end_sequence.addChild(e_parallel); 
			
			start_sequence.addEventListener(EffectEvent.EFFECT_END, effEndEvnet);
			this.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			this.addEventListener(FlexEvent.REMOVE , removeHandler);
		}

		public function closeBtnEvent():void{
			PopUpManager.removePopUp(this);
			var closeEvt:CloseEvent = new CloseEvent(CloseEvent.CLOSE);
 			dispatchEvent(closeEvt); 
		}
    		
		private function removeHandler(event:FlexEvent):void
		{
			removeXCanvas(this);
			facade.removeMediator(mediatorName);
			end_sequence.target = this;
			end_sequence.play();
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
				
		private function creationCompleteHandler(event:FlexEvent):void
		{
			start_sequence.target = this;
			start_sequence.play();
		}
		
		 private function effEndEvnet(event:EffectEvent):void{
			//하우 컴포넌트에서 XCanvas가 있는지 체크한다.
			registerXCanvas(this);
			
			facade.registerMediator(this);
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
		 * tobitServic
		 * <p>
		 * @param command the name of the BeanName and MethodName
		 * @param body the body of the notification (optional)
		 * @param busyCursor busyCursor을 보이졀주에 대한 설정, 기본값은 false이다.
		 */
		public function sendTobitRTMP( command:String, body:Object = null, busyCursor:Boolean = false):void{
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