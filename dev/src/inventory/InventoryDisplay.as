package inventory 
{
	import common.displays.ControlPanel;
	import common.displays.Display;
	import map.MapView;
	import model.PlayerData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import common.Assets;
	import net.flashpunk.graphics.Image;
	import flash.geom.Point;
		import net.flashpunk.tweens.misc.VarTween;
		import net.flashpunk.utils.Ease;
        import observatory.ComponentData;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class InventoryDisplay extends ControlPanel
	{
		private var instrumentSelectors:Vector.<InventoryItemSelector>;
		private var inventoryList:Vector.<ComponentData>;
		private const inventoryWidth:int = 2;
		private const inventoryHeight:int = 2;
		private const inventoryOffset:int = 0;

		public function InventoryDisplay(mapView:MapView, data:PlayerData) 
		{
			super(mapView);
			inventoryList = data.getInventory();
			fillInventoryDisplay();
		}
		
		public function fillInventoryDisplay():void
		{
			instrumentSelectors = new Vector.<InventoryItemSelector>;
			for (var i:int = 0; i < inventoryHeight; i++ )
			{
				for (var j:int = 0; j < inventoryWidth && (i*inventoryWidth)+j < inventoryList.length - inventoryOffset; j++)
				{
					var selector:InventoryItemSelector = new InventoryItemSelector(10 +(j*100)
																				, 50 + (i*100)
																				, inventoryList[(i*inventoryWidth)+j])
					instrumentSelectors.push(selector);
					add(selector.getButton());
				}
				
				if (i * inventoryWidth >= inventoryList.length - inventoryOffset)
					break;
			}
		}
	}

}
