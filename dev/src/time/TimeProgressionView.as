package time 
{
	import map.MapView;
	import model.Game;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import time.ui.TimeProgress;
	import data.DataTally;
	
	/**
	 * Transition to this world to step forward in time.
	 * 
	 * @author beyamor
	 */
	public class TimeProgressionView extends World 
	{
		private var game:Game;
		private var timeProgress:TimeProgress;
		
		public function TimeProgressionView(game:Game)
		{
			this.game = game;
			
			timeProgress = new TimeProgress(FP.halfWidth, FP.halfHeight, game.data.calendar);
			add(timeProgress);
			
			var dataSum:uint = new DataTally(game.data).sum;
			addGraphic(new Text("Data: " + dataSum, FP.halfWidth, FP.halfHeight + 100)); 
		}
		
		override public function update():void 
		{
			super.update();
			
			if (timeProgress.isFinishedProgessing) FP.world = new MapView(game);
		}
	}

}