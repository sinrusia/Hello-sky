package com.jh.controls
{
    
    import flash.display.BitmapData;   
    import mx.core.UIComponent;
    
    public class VDottedLine extends UIComponent{
        
        public function VDottedLine():void {
            super();    
        }
        
        override protected function measure():void{
            super.measure();
            measuredMinHeight = 100;
            measuredMinWidth = 3;
        }
        
        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
            super.updateDisplayList(unscaledWidth, unscaledHeight);
            createLine();
        }
        
        private var bd:BitmapData;
        private function createLine():void{
            if(bd){
                bd.dispose();
            }
            bd = new BitmapData(3, 3, true, 0x00FFFFFF);
            bd.setPixel32(1, 2, _color);
            this.graphics.beginBitmapFill(bd, null, true, false);
            this.graphics.drawRect(0, 0, 3, height);
        }
        
        private var _color:uint = 0xFF000000;
        public function set color(value:uint):void {
            _color = value;
            invalidateDisplayList();
        }
        
        public function get color():uint {
            return _color;
        }
        
    }
}
