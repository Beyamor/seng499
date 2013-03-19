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
			addGraphic(new Text("(click to start)"), 0, 560, 520);
			this.game = game;
			
			camera.y = 130;
		}
		
		override public function update():void 
		{
			super.update();
			
			// Commenting out key pressing because we don't want to create *two* new map views
			// Because they pop event displays in their constructors, we lose displays on subsequent map views.
			// TODO: Dunno. Move the popping into the start method?
			if (/*Input.check(Key.ANY) ||*/ Input.mousePressed) FP.world = new MapView(game);
			
			if (camera.y > 0) camera.y = camera.y - 0.5;
		}
	}

}