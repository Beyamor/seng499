package map 
{
	//import common.ui.ButtonBuilder;
	import common.NeptuneWorld;
	import common.ui.Button;
	import common.Assets;
	import common.ui.Cursor;
	import inventory.InventoryDisplay;
	import inventory.InventoryItemSelector;
	import map.displays.MapDisplay;
	import model.Game;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import store.StoreView;
	import time.TimeProgressionView;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class MapView extends NeptuneWorld
	{
		private var game:Game;
		
		public function MapView(game:Game)
		{			
			this.game = game;
			
			var display:InventoryDisplay = new InventoryDisplay(game.data);
			add(display);
			//display.fillInventoryDisplay();
			var inventoryEntities:Vector.<InventoryItemSelector> = display.getInventoryEntities();
			for (var i:int = 0; i < inventoryEntities.length; i++ )
			{
				add(inventoryEntities[i].getButton())
			}
			
			add(Button.description()
						.fixedAt(FP.width - 58, FP.height - 42)
						.withImageAndText(new Image(Assets.IMG_MAPBUTTONBACKGROUND), new Text("Store"))
						.withDepth( -1)
						.whenClicked(function():void{FP.world = new StoreView(game)})
						.build());
			
			// TODO: Less suck button
			add(Button.description()
						.fixedAt(FP.width - 58, FP.height - 100)
						.withImageAndText(new Image(Assets.IMG_MAPBUTTONBACKGROUND), new Text("Time"))
						.withDepth( -1)
						.whenClicked(function():void{FP.world = new TimeProgressionView(game)})
						.build());
						
			if (game.state.isPlacing()) setCursor(Cursor.forPlacingInstrument(game.state.getInstrumentBeingPlaced()));
			
			displays.push(new MapDisplay(this, game));			
		}
		
		public function getGame():Game 
		{
			return game;
		}
	}

}
