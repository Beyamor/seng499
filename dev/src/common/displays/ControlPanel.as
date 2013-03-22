package common.displays 
{
	import common.Assets;
	import common.tweens.InOutTweener;
	import common.ui.Button;
	import common.ui.NeptuneButtons;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author beyamor
	 */
	public class ControlPanel extends Display 
	{
		public static const SCREEN_X:int		= 600;
		public static const VERTICAL_MARGIN:int	= 80;
		
		private var tweener:InOutTweener;
		private var numberOfStandardButtons:int = 0;
		
		private var subDisplay:Display;
		
		public function ControlPanel(parent:World) 
		{
			clearColor		= 0x88FFFFFF;
					
			super(parent, FP.width, VERTICAL_MARGIN, 200, 600 - VERTICAL_MARGIN * 2);	

			tweener = InOutTweener.forX(parent, this, SCREEN_X, FP.width);
		}
		
		public function slideOn(callback:Function=null):void {
			
			tweener.moveIn(callback);
		}
		
		public function slideOff(callback:Function=null):void {
						
			tweener.moveOut(callback);
		}
		
		// Totally redundant, but it reads better
		public function get thatSlidesOn():ControlPanel { slideOn(); return this; }
		
		public function addStandardButton(label:String, onClick:Function):void {
						
			var button:Button = NeptuneButtons.standard(label, 0, 0, onClick);
			button.x = halfWidth - button.width / 2;
			button.y = height - 50 - 30 * numberOfStandardButtons
			add(button);
					
			++numberOfStandardButtons;
		}
	}

}