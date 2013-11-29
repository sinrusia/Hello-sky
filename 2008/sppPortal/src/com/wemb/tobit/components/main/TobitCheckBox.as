package com.wemb.tobit.components.main
{
	import mx.controls.CheckBox;
	public class TobitCheckBox extends CheckBox 
	{
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
        {
        	super.updateDisplayList(unscaledWidth, unscaledHeight);  
            //textField.styleName = 'InputCheckBoxLabel';  
            textField.y = 4.5;
            textField.x = 15;
       	}
	}
}