package inventory.displays 
{
	import common.displays.ControlPanel;
	import common.displays.Display;
	import common.displays.DisplayStack;
	import inventory.ui.InventoryItemSelector;
	import inventory.ui.SelectorWidget;
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
		
		private var widgets:DisplayStack;

		public function InventoryDisplay(mapView:MapView, data:PlayerData) 
		{
			super(mapView);
			inventoryList = data.getInventory();
			
			widgets = new DisplayStack(
						new SelectorWidget(this, mapView, data.getInventory()));
		}
		
		override public function update():void 
		{
			super.update();
			widgets.update();
		}
		
		override protected function renderBody():void 
		{
			super.renderBody();
			widgets.render();
		}
	}

}
