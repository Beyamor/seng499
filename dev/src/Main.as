package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import hex.HexView;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class Main extends Engine 
	{
		
		public function Main():void 
		{
			super(800, 600);
		}
		
		override public function init():void 
		{
			super.init();
			
			FP.console.enable();
			
			Input.define("debug-hex-start", Key.DIGIT_0);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed("debug-hex-start"))	FP.world = new HexView;
		}
	}
	
}