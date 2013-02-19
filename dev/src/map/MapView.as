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
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class MapView extends World
	{
		private const worldWidth:int = 1440;
		private const worldHeight:int = 640;
		private var game:Game;
		public function MapView(game:Game)
		{
			this.game = game;
			add(new MapEntity(0, 0));
			add(new NodeEntity(game.data.nodeList[0]));
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
			
		}
		
		override public function update():void 
		{
			super.update();
			
			const speed:Number = 5;
			
			if (Input.check("hex-scroll-up") && camera.y > 0)					FP.camera.y -= speed;
			if (Input.check("hex-scroll-down") && camera.y < 640-FP.height)		FP.camera.y += speed;
			if (Input.check("hex-scroll-left") && camera.x > 0)					FP.camera.x -= speed;
			if (Input.check("hex-scroll-right") && camera.x < 1440-FP.width)	FP.camera.x += speed;
			
		}
		
		public function getGame():Game 
		{
			return game;
		}
	}

}
