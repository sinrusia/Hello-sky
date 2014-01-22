package popup
{
	import flash.events.MouseEvent;
	
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.Button;
	import spark.components.TitleWindow;
	
	public class MyPopup extends TitleWindow
	{
		public function MyPopup()
		{
			super();
			this.addEventListener(CloseEvent.CLOSE, popup_closeHandler);
		}
		
		
		//----------------------------------
		//  minimumButton
		//----------------------------------
		
		[SkinPart(required="false")]
		public var minimumButton:Button;
		
		protected function popup_closeHandler(event:CloseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			
			if (instance == minimumButton) {
				minimumButton.focusEnabled = false;
				minimumButton.addEventListener(MouseEvent.CLICK, minimumButton_clickHandler);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void {
			super.partRemoved(partName, instance);
			
			if (instance == minimumButton) {
				minimumButton.removeEventListener(MouseEvent.CLICK, minimumButton_clickHandler);
			}
		}
		
		protected function minimumButton_clickHandler(event:MouseEvent):void
		{
			MyPopupManager.minimumPopup(this);
		}
	}
}