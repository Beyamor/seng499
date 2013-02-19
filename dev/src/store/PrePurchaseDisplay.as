package store 
{
	import common.ui.Button;
	import model.PlayerData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import common.Assets;
	import net.flashpunk.graphics.Image;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ColtonPhillips
	 */
	public class PrePurchaseDisplay extends Entity
	{
		private var displayIsVisible:Boolean = false;
		private var buyButton:Button = null;
		private var playerData:PlayerData;
		
		public function PrePurchaseDisplay(data:PlayerData)
		{
			playerData = data;
			
			super();
			
			x = 50;
			y = 50;
			layer = -9001;
			
			graphic = new Image(Assets.IMG_PREPURCHASE_DISPLAY);		
		}
		
		override public function added():void
		{
			addDisplayButtons();
			setVisible(false);
		}
		
		private function buyButtonClicked():void
		{
			// TODO: A button needs to know what Instrument it referencing
			// in order display it's name, image, and description - CP
			playerData.addToInventory(new InstrumentData(0));
			FP.console.log("added to inventory");
		}
		
		private function addDisplayButtons():void
		{
			buyButton =  Button.description()
						.fixedAt(300, 500)
						.withDepth(-9002)
						.withImage(Assets.IMG_BUY)
						.whenClicked(buyButtonClicked)
						.build();
						
			FP.world.add(buyButton);
		}
		
		public function setVisible(bool:Boolean):void
		{
			graphic.visible = bool;
			buyButton.visible = bool;
			displayIsVisible = bool;
		}
		
		public function toggleVisible():void
		{
			setVisible(!visible);
		}
		
		override public function update():void 
		{
			super.update();
		}
		
	}

}