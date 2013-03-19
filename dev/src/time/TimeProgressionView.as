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
			var moneyValue:uint			= new DataConverter(dataTally.sum).moneyValue;

			var representativeImage:Image = new Image(calendar.season.picture);
			representativeImage.scale = Math.min(200.0 / representativeImage.width, 200.0 / representativeImage.height);
			addGraphic(representativeImage, 0, FP.width - representativeImage.scaledWidth - 50, 50);
			
			addGraphic(new Text(calendar.season.name.toUpperCase(), 50, 50));
			addGraphic(new Text(calendar.season.description, 50, 80));
			
			addGraphic(new Text(dataTally.activeInstrumentCount + " instruments producing data."), 0, 50, FP.halfHeight);
			addGraphic(new Text("$" + moneyValue + " dollars earned."), 0, 50, FP.halfHeight + 20);
			
			var backButton:Button = NeptuneButtons.standard("Continue", 0, 0, function():void { FP.world = new MapView(game); } );
			backButton.x = FP.width - backButton.width - 50;
			backButton.y = FP.height - backButton.height - 50;
			add(backButton);
		}
	}

}