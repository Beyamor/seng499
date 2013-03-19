package map 
{
	//import common.ui.ButtonBuilder;
	import common.displays.ControlPanel;
	import common.displays.Display;
	import common.displays.InstructionDisplay;
	import common.NeptuneWorld;
	import common.ui.Button;
	import common.Assets;
	import common.ui.Cursor;
	import common.displays.DataDisplay;
	import hex.HexView;
	import inventory.displays.InventoryDisplay;
	import inventory.ui.InventoryItemSelector;
	import map.controllers.ControllerFactory;
	import map.controllers.MapController;
	import map.displays.MapDisplay;
	import model.Game;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import store.StoreView;
	import time.TimeProgressionView;
	import observatory.Node;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class MapView extends NeptuneWorld
	{
		private var game:Game;
		public var mapDisplay:MapDisplay;
		public var inventoryDisplay:InventoryDisplay;
		public var instructionDisplay:InstructionDisplay;
		private var whatDisplay:Display;
		
		public var _controller:MapController;
		public function get controller():MapController { return _controller; }
		public function set controller(controller:MapController):void {
			
			removeCursor();
			_controller = controller;
			controller.start();
		}
		
		public function get nodePlacementValidator():NodePlacementValidator { return new NodePlacementValidator; }
		
		public function MapView(game:Game)
		{			
			this.game = game;
						
			controller = new ControllerFactory(this).build();
			
			inventoryDisplay = new InventoryDisplay(this, game.data);
			inventoryDisplay.slideOn(function():void {
				showNextEventDisplay();
			});
			
			mapDisplay = new MapDisplay(this, game);
			mapDisplay.expandRightEdgeTo(inventoryDisplay);
			
			instructionDisplay = new InstructionDisplay(this);
				
			displays.push(
				mapDisplay,
				inventoryDisplay,
				new DataDisplay(this, game.data),
				instructionDisplay);
			
			// TODO: Move this into the inventory display?
			inventoryDisplay.addStandardButton(
						"Next Season",
						function():void { FP.world = new TimeProgressionView(game); } );
						
			inventoryDisplay.addStandardButton(
						"Store",
						function():void { goToStore(); } );
		}
		
		public function getGame():Game 
		{
			return game;
		}
		
		public function goToStore():void {
			
			inventoryDisplay.slideOff(function():void {
			
				FP.world = new StoreView(game);
			});
		}
		
		public function goToHexViewFromNode(node:NodeEntity):void {
			
			inventoryDisplay.slideOff(function():void {
			
				FP.world = new HexView(game, node.mapX, node.mapY);
			});
		}
		
		private function showNextEventDisplay():void {
			
			if (!game.state.hasEventDisplays) return;
			
			var eventDisplay:Display = game.state.popEventDisplay();
			whatDisplay = eventDisplay;
			
			eventDisplay.addOnEndCallback(function():void { showNextEventDisplay(); } );
			eventDisplay.parent = this;
			
			displays.push(eventDisplay);
		}
	}

}

