package store.ui 
{
	import common.displays.DisplayStack;
	import common.ui.Button;
	import model.GameTables;
	import model.PlayerData;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import observatory.ComponentData;
	import store.displays.InsufficientFundsDisplay;
	import store.displays.PrePurchaseDisplay;
	import store.StoreView;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class PurchaseComponentButton extends Button 
	{
		private var playerData:PlayerData;
		private var component:ComponentData;
		private var storeView:StoreView;
		private var text:Text;
		private function get cost():uint { return GameTables.instrumentByName(component.getName()).cost; }
		
		public function PurchaseComponentButton(playerData:PlayerData, storeView:StoreView, component:ComponentData) 
		{
			this.playerData	= playerData;
			this.storeView	= storeView;
			this.component	= component;
			
			var image:Image = component.getStoreImage();
			
			var storeItemString:String = component.getName() + " - " + cost;
			
			text = new Text(storeItemString);
			text.color = textColor;
			
			super(
				false,
				0, 0,
				image.scaledWidth, image.scaledHeight,
				new Graphiclist(image, text),
				purchaseFunction
			);
		}
		
		private function purchaseFunction():void {
			
			if (playerData.canAfford(component)) {
					
				storeView.displays.push(new PrePurchaseDisplay(storeView, playerData, component));
			}
				 
			else {
				 
				storeView.displays.push(new InsufficientFundsDisplay(storeView, component));
			}
		}
		
		private function get textColor():uint {
			
			return playerData.canAfford(component)? 0x000000 : 0xff0000;	
		}
		
		override public function update():void 
		{
			super.update();
			text.color = textColor;
		}
	}

}