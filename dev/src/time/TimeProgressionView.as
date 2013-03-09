package time 
{
	import data.DataConverter;
	import map.MapView;
	import model.Game;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import time.ui.TimeProgressWidget;
	import data.DataTally;
	
	/**
	 * Transition to this world to step forward in time.
	 * 
	 * @author beyamor
	 */
	public class TimeProgressionView extends World 
	{
		private var game:Game;
		private var timeProgress:TimeProgressWidget;
		
		public function TimeProgressionView(game:Game)
		{
			this.game = game;
			
			timeProgress = new TimeProgressWidget(FP.halfWidth, FP.halfHeight, game.data.calendar);
			add(timeProgress);
			
			var dataSum:uint = new DataTally(game.data).sum;
			addGraphic(new Text("Data: " + dataSum, FP.halfWidth, FP.halfHeight + 100));
			game.data.addMoney(new DataConverter(dataSum).moneyValue);
			addGraphic(new Text("Money: " + game.data.money, FP.halfWidth, FP.halfHeight + 120));
		}
		
		override public function update():void 
		{
			super.update();
			
			if (timeProgress.isFinishedProgessing) FP.world = new MapView(game);
		}
	}

}