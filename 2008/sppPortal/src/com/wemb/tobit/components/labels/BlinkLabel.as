package com.wemb.tobit.components.labels
{
	import com.wemb.tobit.effect.BlankSequence;
	
	import mx.controls.Label;

	public class BlinkLabel extends Label
	{
		public function BlinkLabel()
		{
			super();
		}
		
		private var sequence:BlankSequence;
		
		private var _textChanged:Boolean = false;
		
		private var _startBlank:Boolean = false;
		
		override protected function createChildren():void{
			super.createChildren();
			sequence = new BlankSequence(this);
		}
		
		override public function set text(value:String):void{
			//텍스트 변경됬을때 다음을 수행하도록 한다.
			if(super.text != value){
				_textChanged = true;
			}
			super.text = value;
			
			invalidateDisplayList();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			//텍스트가 변경되었을 경우 글자를 깜빡이도록 한다.
			if(_textChanged){
				_textChanged = false;
				if(_startBlank){
					if(sequence.isPlaying){
						sequence.end();
					}
					sequence.play();
				}else{
					_startBlank = true;
				}
			}
		}
		
	}
}