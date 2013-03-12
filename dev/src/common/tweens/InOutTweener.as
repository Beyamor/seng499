package common.tweens 
{
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author beyamor
	 */
	public class InOutTweener 
	{
		private var world:World;
		private var thing:*;
		private var property:String;
		private var inVal:Number;
		private var outVal:Number;
		private var time:Number;
		private var tween:VarTween;
		
		public function InOutTweener(world:World, thing:*, property:String, inVal:Number, outVal:Number, delay:Number=0.35)
		{
			this.world		= world;
			this.thing		= thing;
			this.property	= property;
			this.inVal		= inVal;
			this.outVal		= outVal;
			this.time		= delay;
		}
		
		public function moveIn(callback:Function = null):void {
			
			if (tween) world.removeTween(tween);
			thing[property] = outVal;
			
			tween = new VarTween(callback);
			tween.tween(thing, property, inVal, time, Ease.cubeOut);
			world.addTween(tween, true);
		}
		
		public function moveOut(callback:Function = null):void {
			
			if (tween) world.removeTween(tween);
			
			tween = new VarTween(callback);
			tween.tween(thing, property, outVal, time, Ease.cubeIn);
			world.addTween(tween, true);
		}
		
		public function clear():void {
			
			if (tween) world.removeTween(tween);
		}
		
		public static function forX(
			world:World,
			thing:*,
			inVal:Number,
			outVal:Number,
			delay:Number = 0.35):InOutTweener {
			
			return new InOutTweener(world, thing, "x", inVal, outVal, delay);
		}
		
		public static function forY(
			world:World,
			thing:*,
			inVal:Number,
			outVal:Number,
			delay:Number = 0.35):InOutTweener {
			
			return new InOutTweener(world, thing, "y", inVal, outVal, delay);
		}
	}

}