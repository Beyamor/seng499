package title 
{
	import common.Assets;
	import common.NeptuneWorld;
	import map.MapView;
	import model.Game;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class TitleView extends NeptuneWorld 
	{
		private var game:Game;
		
		public function TitleView(game:Game)
		{
			addGraphic(new Image(Assets.IMG_TITLE),0,0,0);
			addGraphic(new Text("SUPER GREAT NEPTUNE GAME"), 0, 520, 500);
			addGraphic(new Text("(press any key)"), 0, 560, 520);
			this.game = game;
			
			camera.y = 130;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.check(Key.ANY) || Input.mousePressed) FP.world = new MapView(game);
			
			if (camera.y > 0) camera.y = camera.y - 0.5;
		}
	}

}