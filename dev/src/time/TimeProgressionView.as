package time 
{
	import common.seq.DelayedCallback;
	import common.seq.DelayItem;
	import common.seq.Sequencer;
	import data.DataConverter;
	import map.MapView;
	import model.Game;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.Alarm;
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
		private var dataDisplay:Text;
		private var moneyDisplay:Text;
		private var seq:Sequencer;
		
		public function TimeProgressionView(game:Game)
		{
			this.game = game;
			
			timeProgress = new TimeProgressWidget(FP.halfWidth, FP.halfHeight, game.data.calendar);
			add(timeProgress);
			
			var dataSum:uint = new DataTally(game.data).sum;
			dataDisplay = new Text("Data: " + dataSum, FP.halfWidth, FP.halfHeight + 100)
			addGraphic(dataDisplay);
			
			moneyDisplay = new Text("Money: " + game.data.money, FP.halfWidth, FP.halfHeight + 120, 100);
			addGraphic(moneyDisplay);
			
			seq = new Sequencer(
			
				// Update season
				new DelayedCallback(1, function():void {
					
					game.data.calendar.goToNextSeason();
					timeProgress.updateDisplayText();
				}),
				
				// Accumulate money
				new DelayedCallback(1, function():void {
					
					game.data.addMoney(new DataConverter(dataSum).moneyValue);
					moneyDisplay.text = "Money: " + game.data.money;
				}),
				
				// Return to map
				new DelayedCallback(1, function():void {
					
					FP.world = new MapView(game);
				})
			);
		}
		
		override public function update():void 
		{
			super.update();
			seq.update();
		}
	}

}