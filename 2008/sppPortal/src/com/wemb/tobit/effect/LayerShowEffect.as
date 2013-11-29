package com.wemb.tobit.effect
{
	import mx.effects.Fade;
	import mx.effects.IEffectInstance;
	import mx.effects.Sequence;
	import mx.events.EffectEvent;

	public class LayerShowEffect extends Sequence
	{
		
		private var showEff:Fade;
		private var hideEff:Fade;
		
		
		public function LayerShowEffect(target:Object=null)
		{
			super(target);
			
			initEffect();
		}
		
		
		private function initEffect():void
		{
			showEff = new Fade();
			showEff.duration = 1000;
			showEff.alphaFrom = 0;
			showEff.alphaTo = 1;
			
			hideEff = new Fade();
			hideEff.duration = 1000;
			hideEff.alphaFrom = 1;
			hideEff.alphaTo = 0;
			
			
			addChild(hideEff);
			addChild(showEff);
		}
		
		
		
		public function setTargets(target1:Object, target2:Object):void
		{
			hideEff.target = target1;
			showEff.target = target2;			
		}
			
		
		override public function end(effectInstance:IEffectInstance=null):void
		{
			if(effectInstance)
				super.end(effectInstance);
			
		}
		
	}
}