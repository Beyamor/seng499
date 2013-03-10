package common.displays 
{
	import common.Assets;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author beyamor
	 */
	public class ControlPanel extends Display 
	{
		public static const SCREEN_X:int = 600;
		public static const SCREEN_Y:int = 0;
		
		public function ControlPanel(parent:World) 
		{
			var backgroundImage:Image = new Image(Assets.IMG_INVENTORYBACKGOUND);			
			super(parent, FP.width, SCREEN_Y, backgroundImage.width, backgroundImage.height);			
			addGraphic(backgroundImage);
		}
		
		public function slideOn(callback:Function=null):void {
			
			x = FP.width; // Right of screen
			
			var tween:VarTween = new VarTween(callback);
			tween.tween(this, "x", SCREEN_X, 0.25, Ease.quadOut);
			parent.addTween(tween, true);
		}
		
		public function slideOff(callback:Function=null):void {
						
			var tween:VarTween = new VarTween(callback);
			tween.tween(this, "x", FP.width, 0.25, Ease.quadIn);
			parent.addTween(tween, true);
		}
		
		// Totally redundant, but it reads better
		public function get thatSlidesOn():ControlPanel { slideOn(); return this; }
	}

}