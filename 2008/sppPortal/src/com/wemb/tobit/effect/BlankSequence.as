package com.wemb.tobit.effect
{
	import mx.effects.Fade;
	import mx.effects.Sequence;

	public class BlankSequence extends Sequence
	{
		public function BlankSequence(target:Object=null)
		{
			super(target);
			
			initEffect();
		}
		
		
		private function initEffect():void
		{
			var showEff:Fade;
			var hideEff:Fade;
			
			showEff = new Fade();
			showEff.duration = 500;
			showEff.alphaFrom = 0;
			showEff.alphaTo = 1;
			
			hideEff = new Fade();
			hideEff.startDelay = 500;
			hideEff.duration = 500;
			hideEff.alphaFrom = 1;
			hideEff.alphaTo = 0;
			
			
			addChild(hideEff);
			addChild(showEff);
			addChild(hideEff);
			addChild(showEff);
			addChild(hideEff);
			addChild(showEff);
			addChild(hideEff);
			addChild(showEff);
		}
		
	}
}