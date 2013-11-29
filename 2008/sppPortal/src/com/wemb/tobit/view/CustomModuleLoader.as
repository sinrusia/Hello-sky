package com.wemb.tobit.view
{
	import com.wemb.tobit.pure.ApplicationFacade;
	import com.wemb.tobit.pure.Constants;
	import com.wemb.tobit.pure.view.XModule;
	
	import flash.events.Event;
	
	import mx.core.Application;
	import mx.modules.ModuleLoader;
	
	public class CustomModuleLoader extends ModuleLoader
	{
		[Bindable]
		public var initInfo:Object;
		private var loading:Loading = new Loading();
		
		public function CustomModuleLoader()
		{
			loading = new Loading();
			this.addChild(loading);
			statusLoading(false);
	        addEventListener("urlChanged", onUrlChanged);
	        addEventListener("loading", onLoading);
	        addEventListener("progress", onProgress);
	        addEventListener("setup", onSetup);
	        addEventListener("ready", onReady);
	        addEventListener("error", onError);
	        addEventListener("unload", onUnload);
		}
			
	    public function onUrlChanged(event:Event):void {
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
//	    	trace("onUrlChanged");
	    }
	
	    public function onLoading(event:Event):void {
//	    	trace("onLoading");
	    	/*
	    	statusLoading(true);
	    	
	        if (!contains(loading))
	            addChild(loading);	    	
	            */
	    }
	    
	    public function onProgress(event:Event):void {
	    	//trace("onProgress");
//	    	trace("onProgress..............");
	    }
	    
	    
	    public function onSetup(event:Event):void {
	    	ApplicationFacade.getInstance().sendNotification(Constants.LOADING_START);
//	    	trace("onSetup");
	    }
	    
	    public function onReady(event:Event):void {
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
	    
	    public function onError(event:Event):void {
	    	trace("onError", url);
	    }
	    
	    public function onUnload(event:Event):void {
//	    	trace("onUnload..............");
			ApplicationFacade.getInstance().sendNotification(Constants.LOADING_STOP);
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
 	    	if(status){
	    		loading.visible = true;
	    		loading.includeInLayout = true;
	    		loading.mcPlay();
	    	} else {
	    		loading.visible = false;
	    		loading.includeInLayout = false;
	    		loading.mcStop();
	    	} 
	    }		
 		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
 			//loading.x = (unscaledWidth - loading.width) / 2;
			//loading.y = (unscaledHeight - loading.height) / 2; 
 			loading.x = (unscaledWidth - 29) / 2;
			loading.y = (unscaledHeight - 29) / 2; 

		} 
		
		public function remove():void{
			//statusLoading(false);
			this.unloadModule();
			this.url = null;
			//statusLoading(false);
		}
	}
}