package common.displays 
{
	import common.tweens.InOutTweener;
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
		public static const HEIGHT:Number		= 100;
		public static const DISPLAY_TIME:Number	= 4;
		
		private var isShown:Boolean = false;
		
		private var text:Text;
		private var textEntity:Entity;
		private var autoclearAlarm:Alarm;
		private var tweener:InOutTweener;
		
		public function InstructionDisplay(parent:World)
		{
			super(parent, FP.halfWidth - WIDTH / 2, -HEIGHT, WIDTH, HEIGHT);
			clearColor = 0x88000000;
			tweener = InOutTweener.forY(parent, this, 0, -HEIGHT);
		}
		
		public function show(instruction:String, autoclear:Boolean=true):void {
			
			if (textEntity) remove(textEntity);
			
			text = new Text(instruction, halfWidth, halfHeight);
			text.centerOO();
			textEntity = addGraphic(text);
			
			if (!isShown) {
				
				tweener.moveIn();
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
				
				tweener.moveOut();
				isShown = false;
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.mousePressed && isFirstDisplayContaingMouse) hide();
		}
	}

}