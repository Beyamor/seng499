package time 
{
	import model.Game;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import time.ui.TimeProgress;
	
	/**
	 * Transition to this world to step forward in time.
	 * 
	 * @author beyamor
	 */
	public class TimeProgressionView extends World 
	{
		private var game:Game;
		
		public function TimeProgressionView(game:Game)
		{
			this.game = game;
			
			add(new TimeProgress(FP.halfWidth, FP.halfHeight, game.data.calendar));
		}
		
	}

}