package store.displays
{
	import common.displays.Popup;
	import common.ui.Button;
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
	/**
	 * ...
	 * @author ColtonPhillips
	 */
	public class PrePurchaseDisplay extends Popup
	{
		private var displayIsVisible:Boolean = false;
		private var buyButton:Button = null;
		private var playerData:PlayerData;
                private var component:ComponentData;
                private var componentImage:Entity;
		
		public function PrePurchaseDisplay(parent:World, data:PlayerData, component:ComponentData)
		{
			var background:Image = new Image(Assets.IMG_PREPURCHASE_DISPLAY);

			playerData      = data;
			this.component  = component;

			super(
				parent,
				background.width,
				background.height);

			addGraphic(background, 100);

			addDisplayButtons();
			
			var description:Text = new Text(component.getName() + " - $" + GameTables.instrumentByName(component.getName()).cost);
			description.color = 0;
			addGraphic(description, 0, 10, 10);

			componentImage = addGraphic(component.getImage());
			componentImage.layer = -9003;

			// This is all junk. Gotta it at some point.
			componentImage.x = center.x;
			componentImage.y = center.y;

			blocksUpdates = true;
		}
		
		private function buyButtonClicked():void
		{
			playerData.purchase(component);
			FP.console.log("added to inventory: " + component.getName());
			close();
		}
		
		private function addDisplayButtons():void
		{
			var img:Image = new Image(Assets.IMG_BUY);

			buyButton =  Button.description()
						.at(center.x - img.width/2, center.y + height/2 - img.height)
						.withDepth(-9002)
						.withImage(img)
						.whenClicked(buyButtonClicked)
						.build();
						
			add(buyButton);
		}
	}

}
