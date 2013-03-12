package common.displays 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import time.Calendar;
	/**
	 * ...
	 * @author beyamor
	 */
	public class InstructionDisplay extends Display 
	{
		public static const WIDTH:Number		= 300;
		public static const HEIGHT:Number		= 50;
		public static const DISPLAY_TIME:Number	= 2;
		
		private var isShown:Boolean = false;
		
		private var text:Text;
		private var textEntity:Entity;
		private var autoclearAlarm:Alarm;
		
		public function InstructionDisplay(parent:World)
		{
			super(parent, FP.halfWidth - WIDTH / 2, -HEIGHT, WIDTH, HEIGHT);
			clearColor = 0x88FFFFFF;
		}
		
		public function show(instruction:String, autoclear:Boolean=true):void {
			
			if (textEntity) remove(textEntity);
			
			text = new Text(instruction, halfWidth, halfHeight);
			text.centerOO();
			textEntity = addGraphic(text);
			
			if (!isShown) {
				
				slideOn();
				isShown = true;
			}
			
			if (autoclearAlarm) {
				
				parent.removeTween(autoclearAlarm);
				autoclearAlarm = null;
			}
			
			if (autoclear) {
				
				autoclearAlarm = new Alarm(DISPLAY_TIME, function():void { hide(); } );
				parent.addTween(autoclearAlarm, true);
			}
		}
		
		public function hide():void {
			
			if (isShown) {
				
				slideOff();
				isShown = false;
			}
		}
		
		private function slideOn(callback:Function=null):void {
			
			// Pretty well straight copying this from the control panel
			// TODO: Move it somewhere to be shared
			y = -HEIGHT;
			var tween:VarTween = new VarTween(callback);
			tween.tween(this, "y", 0, 0.35, Ease.cubeOut);
			parent.addTween(tween, true);
		}
		
		private function slideOff(callback:Function=null):void {
			
			y = 0;
			var tween:VarTween = new VarTween(callback);
			tween.tween(this, "y", -HEIGHT, 0.35, Ease.cubeIn);
			parent.addTween(tween, true);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.mousePressed && isFirstDisplayContaingMouse) hide();
		}
	}

}