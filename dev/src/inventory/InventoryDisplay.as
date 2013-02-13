package inventory 
{
	import PlayerData;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class InventoryDisplay 
	{
		private var instrumentSelectors:Vector.<InventoryItemSelector>;
		private var inventory:Vector.<InstrumentStub>;
		private const inventoryWidth:int = 1;
		private const inventoryHeight:int = 1;
		private const inventoryOffset:int = 0;
		public function InventoryDisplay(data:PlayerData) 
		{
			//graphic = INVENTORY
			inventory = data.getInventory();
			fillInventoryDisplay();
		}
		
		public function fillInventoryDisplay()
		{
			instrumentSelectors = new Vector.<InventoryItemSelector>;
			for (var i:int = 0; i < inventoryHeight; i++ )
			{
				for (var j:int = 0; j < inventoryWidth && (i*inventoryWidth)+j < inventory.length - inventoryOffset; j++)
				{
					var selector:InventoryItemSelector = new InventoryItemSelector(610+(j*100)
																				, 50 + (i*100)
																				, inventory[(i*inventoryWidth)+j])
					instrumentSelectors.push(selector);
					FP.world.add(selector);
				}
				
				if (i * inventoryWidth >= inventory.length - inventoryOffset)
					break;
			}
		}
		
	}

}