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
			addGraphic(new Image(Assets.IMG_SCIENTIST_1),0,160,150);
			addGraphic(new Text("SUPER GREAT NEPTUNE GAME"), 0, 180, 400);
			addGraphic(new Text("(press any key)"), 0, 220, 420);
			this.game = game;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.check(Key.ANY)) FP.world = new MapView(game);
		}
	}

}