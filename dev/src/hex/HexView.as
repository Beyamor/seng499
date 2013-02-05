package hex 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
        import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class HexView extends World 
	{
            private var grid:HexGrid;
            private var scrollCamera:ScrollCamera;
			
		
		public function HexView() 
		{			
                        // the hex grid bounds are 100% arbitrary, so deal with it
                        scrollCamera = new ScrollCamera(350, 0, 0, 2000, 2000);
			grid = new HexGrid(this, 64, 2000, 2000);
		}
		
		override public function update():void 
		{
			super.update();

                        scrollCamera.update();
			
			grid.fillView();
		}
	}

}
