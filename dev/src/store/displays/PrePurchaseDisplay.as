package store.displays
{
	import common.displays.Popup;
	import common.ui.Button;
	import common.ui.NeptuneButtons;
	import model.GameTables;
	import model.PlayerData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import common.Assets;
	import net.flashpunk.graphics.Image;
	import flash.geom.Point;
		import net.flashpunk.graphics.Text;
        import observatory.ComponentData;
        import common.displays.Display;
        import net.flashpunk.World;
        import net.flashpunk.utils.Input;
		import store.StoreView;
	/**
	 * ...
	 * @author ColtonPhillips
	 */
	public class PrePurchaseDisplay extends Popup
	{
		private var storeView:StoreView;
		private var playerData:PlayerData;
        private var component:ComponentData;
        private var componentDisplay:Image;
		
		public function PrePurchaseDisplay(storeView:StoreView, data:PlayerData, component:ComponentData)
		{
			this.storeView = storeView;
			this.clearColor = 0xEE000000;
			this.playerData = data;
			this.component = component;
			this.blocksUpdates = true;

			super(
				parent,
				700,
				500);
			
			var componentDisplay:Image = new Image(component.getImage());
			componentDisplay.scale = 4.0;
			addGraphic(componentDisplay, 0, 50, 50)
				
			var buyButton:Button = NeptuneButtons.standard("Buy", width - 100, height - 80, function():void {
				
				storeView.instructionDisplay.show("added to inventory: " + component.getName());
				playerData.purchase(component);
				FP.console.log("added to inventory: " + component.getName());
				close();
				
			});		
			add(buyButton);
			
			var nameDisplay:Text = new Text(component.getName());
			nameDisplay.color = 0xFFFFFF;
			nameDisplay.scale = 3;
			addGraphic(nameDisplay, 0, (width / 2) - (nameDisplay.scaledWidth / 2), 50);
					
			var costDisplay:Text = new Text("Cost: $" + component.properties.cost);
			costDisplay.color = 0xFFFFFF;
			addGraphic(costDisplay, 0, 50, 180);	
			
			// HACK: if we're making a list of things, it should be in a list, not hardcode - CP
			if (component.dataType) {
				var typeDisplay:Text = new Text("Type: " + component.dataType);
				typeDisplay.color = 0xFFFFFF;
				addGraphic(typeDisplay, 0, 50, 200);				
			}

			var descriptionDisplay:Text = new Text("Description: \n" + component.properties.description);
			descriptionDisplay.color = 0xFFFFFF;
			addGraphic(descriptionDisplay, 0, 250, 150);
		}

	}

}
