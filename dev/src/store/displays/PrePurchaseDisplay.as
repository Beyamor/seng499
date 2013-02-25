package store.displays
{
	import common.ui.Button;
	import model.PlayerData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import common.Assets;
	import net.flashpunk.graphics.Image;
	import flash.geom.Point;
        import observatory.ComponentData;
        import common.displays.Display;
        import net.flashpunk.World;
        import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author ColtonPhillips
	 */
	public class PrePurchaseDisplay extends Display
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
                            FP.width/2 - background.width/2,
                            FP.height/2 - background.height/2,
                            background.width,
                            background.height);
			
			super.addGraphic(background, 100);

			addDisplayButtons();

                        componentImage = addGraphic(component.getImage());
                        componentImage.layer = -9003;

                        // This is all junk. Gotta it at some point.
                        componentImage.x = center.x;
                        componentImage.y = center.y;

                        blocksUpdates = true;
		}
		
		private function buyButtonClicked():void
		{
			playerData.addToInventory(component);
			FP.console.log("added to inventory: " + component.getName());
                        close();
		}

                public function close():void {

                    // Just gunna assume this is the top of the stack
                    if (stack && stack.top == this) stack.pop();
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
		
                override public function update():void {

                    super.update();

                    if (Input.mousePressed && !containsMouse) close();
                }
	}

}
