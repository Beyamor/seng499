package store 
{
	import common.ui.Button;
	import model.PlayerData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import common.Assets;
	import net.flashpunk.graphics.Image;
	import flash.geom.Point;
        import observatory.ComponentData;
	/**
	 * ...
	 * @author ColtonPhillips
	 */
	public class PrePurchaseDisplay extends Entity
	{
		private var displayIsVisible:Boolean = false;
		private var buyButton:Button = null;
		private var playerData:PlayerData;
                private var component:ComponentData;
		
		public function PrePurchaseDisplay(data:PlayerData, component:ComponentData)
		{
			playerData      = data;
                        this.component  = component;
			
			super();
			
			x = 50;
			y = 50;
			layer = -9001;
			
			graphic = new Image(Assets.IMG_PREPURCHASE_DISPLAY);		
		}
		
		override public function added():void
		{
			addDisplayButtons();
		}

                override public function removed():void {

                    if (buyButton.world) buyButton.world.remove(buyButton);
                }
		
		private function buyButtonClicked():void
		{
			playerData.addToInventory(component);
			FP.console.log("added to inventory: " + component.getName());
                        close();
		}

                public function close():void {

                    if (world) {

                        world.remove(this);
                    }
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
		
		override public function update():void 
		{
			super.update();
		}
		
	}

}
