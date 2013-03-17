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
			
			var dataTally:DataTally		= new DataTally(game.data);
			var moneyValue:uint			= new DataConverter(dataTally.sum).moneyValue;
			
			game.data.calendar.goToNextSeason();
			game.data.addMoney(moneyValue);

			var representativeImage:Image = new Image(Calendar.SEASON_PICTURE[calendar.season]);
			representativeImage.scale = Math.min(200.0 / representativeImage.width, 200.0 / representativeImage.height);
			addGraphic(representativeImage, 0, FP.width - representativeImage.scaledWidth - 50, 50);
			
			addGraphic(new Text(Calendar.SEASON_NAME[calendar.season].toUpperCase(), 50, 50));
			addGraphic(new Text(Calendar.SEASON_DESCRIPTION[calendar.season], 50, 80));
			
			addGraphic(new Text(dataTally.activeInstrumentCount + " instruments producing data."), 0, 50, FP.halfHeight);
			addGraphic(new Text("$" + moneyValue + " dollars earned."), 0, 50, FP.halfHeight + 20);
			
			var buttonBackground:Image = new Image(Assets.IMG_MAPBUTTONBACKGROUND); // TODO: Make this dude standard
			add(Button.description()
				.at(FP.width - buttonBackground.width - 50, FP.height - buttonBackground.height - 50)
				.withImageAndText(buttonBackground, new Text("Continue"))
				.whenClicked(function():void { FP.world = new MapView(game); } )
				.build());
		}
	}

}