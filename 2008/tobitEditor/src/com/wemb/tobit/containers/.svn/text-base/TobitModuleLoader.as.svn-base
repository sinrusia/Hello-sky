package com.wemb.tobit.containers
{
	import com.wemb.puremvc.view.XModule;
	import com.wemb.tobit.pure.ApplicationFacade;
	import com.wemb.tobit.pure.Constants;
	
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	import mx.controls.Alert;
	import mx.events.ResizeEvent;
	import mx.rpc.events.ResultEvent;
	
	import spark.modules.ModuleLoader;
	
	public class TobitModuleLoader extends ModuleLoader
	{
		[Bindable]
		public var initInfo:Object;
		
		private var isResize:Boolean = false;
		
		public function TobitModuleLoader()
		{
			//statusLoading(false);
	        addEventListener("urlChanged", onUrlChanged);
	        addEventListener("loading", onLoading);
	        addEventListener("progress", onProgress);
	        addEventListener("setup", onSetup);
	        addEventListener("ready", onReady);
	        addEventListener("error", onError);
	        addEventListener("unload", onUnload);
			addEventListener(ResizeEvent.RESIZE, onResize);
			
		}
		
		public function remove():void
		{
			isResize = false;
			//statusLoading(false);
			this.unloadModule();
			this.url = null;
			//statusLoading(false);
		}
		
		private function onResize(event:ResizeEvent):void
		{
			if ( isResize )
			{
				isResize = false;
				var _hh:Number = this.height;
				//Alert.show(_hh.toString());
				ExternalInterface.call("setHeight", _hh);
				
				callLater(resizeEnd);
				//Alert.show(_hh.toString());
			}
		}
		
		private function resizeEnd():void
		{
			isResize = true;
		}
		
	    public function onUrlChanged(event:Event):void 
		{
	       // if (url == null) {
	        	//statusLoading(false);
	        	/*
	            if (contains(loading))
	                removeChild(loading);
	                */
	       // } else {
	        	//statusLoading(true);
	        	/*
	            if (!contains(loading))
	                addChild(loading);
	                */
	       // }	    	
//	    	trace("onUrlChanged");
	    }
	
	    public function onLoading(event:Event):void 
		{
//	    	trace("onLoading");
	    	/*
	    	statusLoading(true);
	    	
	        if (!contains(loading))
	            addChild(loading);	    	
	            */
	    }
	    
	    public function onProgress(event:Event):void 
		{
	    	//trace("onProgress");
//	    	trace("onProgress..............");
	    }
	    
	    
	    public function onSetup(event:Event):void 
		{
//	    	trace("onSetup");
	    }
	    
	    public function onReady(event:Event):void 
		{
			isResize = true;
			//ApplicationFacade.getInstance().sendNotification(Constants.LOADING_STOP);
//	    	trace("onReady..............");
	    	//statusLoading(false);
	    	/*
	        if (contains(loading))
	            removeChild(loading);	    	
	            */
	    	if(event.currentTarget.child){
		    	try{
			    	(event.currentTarget.child as XModule).initInfo = initInfo;
			    } catch(err:Error){}
		    }
	    }
	    
	    public function onError(event:Event):void 
		{
	    	trace("onError", url);
			ApplicationFacade.getInstance().sendNotification(Constants.LOADING_STOP);
	    }
	    
	    public function onUnload(event:Event):void 
		{
	    	//statusLoading(false);
	        if (url == null) {
	        	//statusLoading(false);
	        	/*
	            if (contains(loading))
	                removeChild(loading);
	                */
	                
	        } else {
	        	//statusLoading(true);
	        	/*
	            if (!contains(loading))
	                addChild(loading);
	                */
	        }	    
	    }
	    
	    private function statusLoading(status:Boolean):void{
//	    	trace("statusLoading...........", status);
 	    	/*if(status){
	    		loading.visible = true;
	    		loading.includeInLayout = true;
	    		loading.mcPlay();
	    	} else {
	    		loading.visible = false;
	    		loading.includeInLayout = false;
	    		loading.mcStop();
	    	} */
	    }		
 		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
 			//loading.x = (unscaledWidth - loading.width) / 2;
			//loading.y = (unscaledHeight - loading.height) / 2; 
 			//loading.x = (unscaledWidth - 29) / 2;
			//loading.y = (unscaledHeight - 29) / 2;
		} 
	}
}