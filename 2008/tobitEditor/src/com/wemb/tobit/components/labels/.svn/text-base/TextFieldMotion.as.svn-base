package com.wemb.tobit.components.labels
{
	import flash.display.DisplayObject;
	
	import gs.*;
	import gs.easing.*;
	
	import mx.formatters.NumberFormatter;
	
	import spark.components.Label;
		
	public class TextFieldMotion
	{
		private var label_mc:Label;
		private var arr:Array;
		private var nFmt:NumberFormatter;
		private var sType:String = "default";
		private var target_mc:DisplayObject;
		
		public function TextFieldMotion(label:Label, sType:String = "default")
		{
			this.label_mc = label;
			this.sType = sType;
			nFmt = new NumberFormatter();
			nFmt.useThousandsSeparator = true;
			nFmt.precision = 0;
			remove();
		}
			
		private var _value:Number = 0;
		
		public function remove():void{
			arr = [0];
			try{
				//label_mc.text = "0";
			} catch(err:Error){}
		}		
		
		public function valueFunc(val:Number):void{
			_value = val;
			var t_arr:Array = String(_value).split(".");
			nFmt.precision = 0
			if(String(t_arr[1]) != "undefined")
				nFmt.precision = String(t_arr[1]).length;
			start();
		}
		
		private function start():void{
			TweenLite.to(arr, 1, {endArray:[0], onUpdate:onUpdateFunc, onComplete:function():void{
													TweenLite.to(arr, 1, {endArray:[_value], onUpdate:onUpdateFunc});
																				}
						});
		}
		
		private function onUpdateFunc():void{
			try{
				if(thousandNF == null){ 
					label_mc.text = nFmt.format(arr[0]);
				} else {
					label_mc.text = thousandNF.format(arr[0]);
				} 
			} catch(err:Error){
			}
		}
		
		private var _thousandNF:NumberFormatter;
		public function set thousandNF(nf:NumberFormatter):void{
			this._thousandNF = nf;
		}
		
		public function get thousandNF():NumberFormatter{
			return this._thousandNF;
		}				

	}
}