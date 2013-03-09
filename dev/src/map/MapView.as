package map 
{
	//import common.ui.ButtonBuilder;
	import common.ui.Button;
	import common.Assets;
	import inventory.InventoryDisplay;
	import inventory.InventoryItemSelector;
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
	public class MapView extends World
	{
		private const WIDTH:int = 1440;
		private const HEIGHT:int = 640;
		private var game:Game;
		
		public function MapView(game:Game)
		{
			this.game = game;
			add(new MapEntity(0, 0));
			
			for (var i:int = 0 ; i < game.data.nodeList.length; i++ )
			{
				add(new NodeEntity(game.data.nodeList[i]));
			}
			
			var display:InventoryDisplay = new InventoryDisplay(game.data);
			add(display);
			//display.fillInventoryDisplay();
			var inventoryEntities:Vector.<InventoryItemSelector> = display.getInventoryEntities();
			for (i = 0; i < inventoryEntities.length; i++ )
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
			
		}
		
		override public function update():void 
		{
			super.update();
			
			const speed:Number = 5;
			
			if (Input.check("hex-scroll-up") && camera.y > 0)					FP.camera.y -= speed;
			if (Input.check("hex-scroll-down") && camera.y < HEIGHT-FP.height)	FP.camera.y += speed;
			if (Input.check("hex-scroll-left") && camera.x > 0)					FP.camera.x -= speed;
			if (Input.check("hex-scroll-right") && camera.x < WIDTH-FP.width)	FP.camera.x += speed;
			
			if (game.state.isPlacing())
			{
                                // We currently have a bug where, if a node has been selected for placement,
                                // if the player clicks on an existing node, they will still be taken to the hex view.
                                // However, the logic below will have already added the node at the map level
                                // The visible symptom of the bug is a null pointer in the hex view when clicking on a tile.
                                // This is because the hex controller thinks that there's still an instrument to be placed,
                                // even though the logic below has already stopped instrument placement.
                                // We could add a check in the hex controller, but the heart of the problem is
                                // going to the hex view at all when placing a node.
                                // TODO: Figure this out, dawgs.
				if (game.state.getInstrumentBeingPlaced().isNode())
				{
					if (Input.mousePressed == true && FP.world.mouseX - camera.x < 600)//TODO make a proper check for wether click is over the display.
					{
						game.data.addNode(new Node(FP.world.mouseX, FP.world.mouseY));
						game.state.stopPlacingInstrument();
						add(new NodeEntity(game.data.nodeList[game.data.nodeList.length - 1]));
						//FP.console.log("Added a node.  Do you see it?");
					}
				}
			}
		}
		
		public function getGame():Game 
		{
			return game;
		}
	}

}
