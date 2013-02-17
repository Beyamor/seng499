package inventory 
{
	import model.PlayerData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import common.Assets;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class InventoryDisplay extends Entity
	{
		private var instrumentSelectors:Vector.<InventoryItemSelector>;
		private var inventoryList:Vector.<InstrumentData>;
		private const inventoryWidth:int = 2;
		private const inventoryHeight:int = 1;
		private const inventoryOffset:int = 0;
		private var screenX:int = 600;
		private var screenY:int = 0;
		public function InventoryDisplay(data:PlayerData) 
		{
			super();
			x = screenX;
			y = screenY;
			graphic = new Image(Assets.IMG_INVENTORYBACKGOUND);
			inventoryList = data.getInventory();
			//fillInventoryDisplay();
		}
		
		public function getInventoryEntities():Vector.<InventoryItemSelector>//fillInventoryDisplay()
		{
			instrumentSelectors = new Vector.<InventoryItemSelector>;
			for (var i:int = 0; i < inventoryHeight; i++ )
			{
				for (var j:int = 0; j < inventoryWidth && (i*inventoryWidth)+j < inventoryList.length - inventoryOffset; j++)
				{
					var selector:InventoryItemSelector = new InventoryItemSelector(610+(j*100)
																				, 50 + (i*100)
																				, inventoryList[(i*inventoryWidth)+j])
					instrumentSelectors.push(selector);
					//FP.world.add(selector);
				}
				
				if (i * inventoryWidth >= inventoryList.length - inventoryOffset)
					break;
			}
			return instrumentSelectors;
		}
		
		override public function update():void 
		{
			super.update();
			x = FP.camera.x + screenX;
			y = FP.camera.y + screenY;
		}
	}

}