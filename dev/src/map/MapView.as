package map 
{
	import inventory.InventoryDisplay;
	import inventory.InventoryItemSelector;
	import model.Game;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class MapView extends World
	{
		
		private var game:Game;
		public function MapView(game:Game)
		{
			this.game = game;
			add(new Node(70, 70));
			var display:InventoryDisplay = new InventoryDisplay(game.data);
			add(display);
			//display.fillInventoryDisplay();
			var inventoryEntities:Vector.<InventoryItemSelector> = display.getInventoryEntities();
			for (var i:int = 0; i < inventoryEntities.length; i++ )
			{
				add(inventoryEntities[i].getButton())
			}
			
		}
		
		override public function update():void 
		{
			super.update();
			
			const speed:Number = 5;
			
			if (Input.check("hex-scroll-up"))		FP.camera.y -= speed;
			if (Input.check("hex-scroll-down"))		FP.camera.y += speed;
			if (Input.check("hex-scroll-left"))		FP.camera.x -= speed;
			if (Input.check("hex-scroll-right"))	FP.camera.x += speed;
			
			//if(game.state.isPlacing())
				//FP.log("state = placing "+game.state.getInstrumentBeingPlaced().getNameString());
		}
		
		public function getGame():Game 
		{
			return game;
		}
	}

}
