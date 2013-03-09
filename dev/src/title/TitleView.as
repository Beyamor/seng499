package title 
{
	import common.NeptuneWorld;
	import map.MapView;
	import model.Game;
	import net.flashpunk.FP;
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
			addGraphic(new Text("SUPER GREAT NEPTUNE GAME"), 0, 10, 100);
			addGraphic(new Text("(press any key)"), 0, 10, 120);
			this.game = game;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.check(Key.ANY)) FP.world = new MapView(game);
		}
	}

}