package time 
{
	import common.Assets;
	import common.displays.BackgroundDisplay;
	import common.displays.DisplayStack;
	import common.NeptuneWorld;
	import common.seq.DelayedCallback;
	import common.seq.DelayItem;
	import common.seq.Sequencer;
	import common.ui.Button;
	import common.ui.NeptuneButtons;
	import data.DataConverter;
	import flash.events.TextEvent;
	import map.MapView;
	import model.Game;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	import data.DataTally;
	
	/**
	 * Transition to this world to step forward in time.
	 * 
	 * @author beyamor
	 */
	public class TimeProgressionView extends NeptuneWorld
	{
		private var game:Game;
		private var dataDisplay:Text;
		private var moneyDisplay:Text;
		private function get calendar():Calendar { return game.data.calendar; }
		
		public function TimeProgressionView(game:Game)
		{
			this.game = game;
			
			new SeasonChanger(game).changeSeason();
			
			var dataTally:DataTally		= new DataTally(game.data);
			//var insTally:InstrumentTally = new InstrumentTally(game.data);
			var dataMoney:DataConverter	= new DataConverter(dataTally);
			var moneyValue:uint			= dataMoney.baseValue;
			var bonusValue:uint			= dataMoney.bonusValue;

			var representativeImage:Image = new Image(calendar.season.picture);
			representativeImage.scale = Math.min(200.0 / representativeImage.width, 200.0 / representativeImage.height);
			addGraphic(representativeImage, 0, FP.width - representativeImage.scaledWidth - 50, 50);
			
			addGraphic(new Text(calendar.season.name.toUpperCase(), 50, 50));
			//this description will be replaced with a larger, more detailed stats display
			//addGraphic(new Text(calendar.season.description, 50, 80));
			
			addGraphic(new Text("Nodes placed this season:       " + dataTally.NodesPlaced, 50, 80));
			addGraphic(new Text("Instruments placed this season: " + dataTally.InstrumentsPlaced, 50, 100));
			
			//Put special data here
			
			addGraphic(new Text(dataTally.totalDataCount + " gigs of data produced by "+dataTally.activeInstrumentCount+" instruments producing data."), 0, 50, FP.halfHeight);
			addGraphic(new Text("$" + moneyValue + " dollars earned."), 0, 50, FP.halfHeight + 20);
			
			//need to replace this with more detailed stuff.
			if (bonusValue > 0) {
				
				addGraphic(new Text("An instrument detected an interesting event"), 0, 50, FP.halfHeight + 40);
				addGraphic(new Text("$" + bonusValue + " bonus dollars earned."), 0, 50, FP.halfHeight + 60);
			}
			
			var backButton:Button = NeptuneButtons.standard("Continue", 0, 0, function():void { FP.world = new MapView(game); } );
			backButton.x = FP.width - backButton.width - 50;
			backButton.y = FP.height - backButton.height - 50;
			add(backButton);
			
			game.data.clearSeasonTotals();
		}
	}

}