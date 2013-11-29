package com.wemb.tobit.components.common
{
    import mx.preloaders.DownloadProgressBar;
    import flash.display.Sprite;
    import flash.events.ProgressEvent;
    import flash.events.Event;
    import mx.events.FlexEvent;
    import flash.display.MovieClip;
 
    public class TobitPreloader extends DownloadProgressBar
    {
 
        [Embed(source="/assets/preloader/hanapreloader.swf", symbol="Preloader")]
        public var WelcomeScreenGraphic:Class;
 
        public var wcs:MovieClip;
 
        public function TobitPreloader():void
        {
            super();
            wcs = new WelcomeScreenGraphic();
            addChild(wcs);
            wcs.gotoAndStop(0);
        }
 
        public override function set preloader(preloader:Sprite):void
        {
            preloader.addEventListener(ProgressEvent.PROGRESS, onSWFDownloadProgress);
            preloader.addEventListener(Event.COMPLETE, onSWFDownloadComplete);
            preloader.addEventListener(FlexEvent.INIT_PROGRESS, onFlexInitProgress);
            preloader.addEventListener(FlexEvent.INIT_COMPLETE, onFlexInitComplete);
 
            centerPreloader();
        }	
 
        private function centerPreloader():void
        {
            x = (stageWidth / 2) - (wcs.width / 2);
            y = (stageHeight / 2) - (wcs.height / 2);
        }
 
        private function onSWFDownloadProgress(event:ProgressEvent):void
        {
            var t:Number = event.bytesTotal;
            var l:Number = event.bytesLoaded;
            var p:Number = Math.round((l/t) * 19);
            var pForAmount:int = Math.floor(p * 5);
            wcs.gotoAndStop(p);
            wcs.amount_txt.text = String(pForAmount) + "%";
            wcs.status_txt.text = "LOADING";
        }
 
        private function onSWFDownloadComplete(event:Event):void
        {
            wcs.gotoAndStop(100);
            wcs.amount_txt.text = "100%";
            wcs.status_txt.text = "COMPELTE";
        }
 
        private function onFlexInitProgress(event:FlexEvent):void
        {
            wcs.gotoAndStop(100);
            wcs.amount_txt.text = " ";
        }
 
        private function onFlexInitComplete(event:FlexEvent):void
        {
            wcs.gotoAndStop(100);
            dispatchEvent( new Event(Event.COMPLETE));
        }
    }
}