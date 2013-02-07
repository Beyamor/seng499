package hex 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
        import flash.geom.Rectangle;
        import common.ui.Button;
        import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class HexView extends World 
	{
            [Embed(source="/assets/map-from-hex-button.png")]
            private const MAP_BUTTON_SOURCE:Class;

            private var grid:HexGrid;
            private var scrollCamera:ScrollCamera;
			
		
		public function HexView() 
		{			
                        // the hex grid bounds are 100% arbitrary, so deal with it
                        scrollCamera = new ScrollCamera(350, 0, 0, 2000, 2000);
			grid = new HexGrid(this, 64, 2000, 2000);

                        add(Button.describe()
                                    .at(FP.width - 50, 30)
                                    .withDepth(-1)
                                    .withImage(new Image(MAP_BUTTON_SOURCE))
                                    .whenClicked(function():void {

                                        trace("Clicked the button!");
                                    })
                                    .build());
		}
		
		override public function update():void 
		{
			super.update();

                        scrollCamera.update();
			
			grid.fillView();
		}
	}

}
