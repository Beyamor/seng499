package inventory.ui 
{
	import common.ui.Button;
	import common.ui.Cursor;
	import inventory.displays.InventoryDisplay;
	import map.controllers.ControllerFactory;
	import map.MapView;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import model.GameState;
	import model.Game;
	import common.Assets;
		import net.flashpunk.World;
        import observatory.ComponentData;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class InventoryItemSelector extends Button
	{
		private var data:ComponentData;
		private var mapView:MapView;
		
		public function InventoryItemSelector(mapView:MapView, data:ComponentData) 
		{
			this.data = data
			this.mapView = mapView;
			
			var background:Image = new Image(Assets.IMG_ITEMBACKGROUND);
			
			var image:Image  = data.getImage();
			image.x = 5;
			image.y = 5;
			
			var text:Text = data.getText();
			text.x = 5;
			text.y = 60;
			text.color = 0xFF000000;
			
			super(
				false,
				x, y,
				background.width,
				background.height,
				new Graphiclist(background, image, text),
				whenClicked);
		}
		
		private function whenClicked():void {
			
			mapView.getGame().state.setInstrumentBeingPlaced(data);
			mapView.controller = new ControllerFactory(mapView).build();
			
			if (data.isNode())	mapView.instructionDisplay.show("select a location");
			else				mapView.instructionDisplay.show("select a node");;
		}
		
		public function get item():ComponentData { return data; }
		
	}

}
