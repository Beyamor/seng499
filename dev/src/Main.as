package 
{
	import common.Assets;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import hex.HexView;
	import map.MapView;
	import model.Game;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import store.StoreView;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class Main extends Engine 
	{
		private var game:Game;
		public function Main():void 
		{
			super(800, 600);
		}
		
		override public function init():void 
		{
			super.init();
			
			initModel();
			initSound();
			
			FP.console.enable();
			
			Input.define("debug-hex-start",		Key.DIGIT_0);
			Input.define("debug-map-start",		Key.DIGIT_1);
			Input.define("debug-store-start",	Key.DIGIT_2);
			Input.define("hex-scroll-up",		Key.W, Key.UP);
			Input.define("hex-scroll-down",		Key.S, Key.DOWN);
			Input.define("hex-scroll-left",		Key.A, Key.LEFT);
			Input.define("hex-scroll-right",	Key.D, Key.RIGHT);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed("debug-hex-start"))	FP.world = new HexView(game, 0, 0);
			else if (Input.pressed("debug-map-start"))	FP.world = new MapView(game);
			else if (Input.pressed("debug-store-start")) FP.world = new StoreView(game);
		}
		
		private function initModel():void
		{
			game = new Game();
		}

		private function initSound():void
		{
			var sound:Sound = (new Assets.SOUND_NEPTUNE) as Sound;
			sound.play();
		}
}
	
}
