package hex 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class HexView extends World 
	{
            private var grid:HexGrid;
		
		public function HexView() 
		{			
			grid = new HexGrid(this, 64);
		}
		
		override public function update():void 
		{
			super.update();
			
			const speed:Number = 5;
			
			if (Input.check("hex-scroll-up"))		FP.camera.y -= speed;
			if (Input.check("hex-scroll-down"))		FP.camera.y += speed;
			if (Input.check("hex-scroll-left"))		FP.camera.x -= speed;
			if (Input.check("hex-scroll-right"))	FP.camera.x += speed;

                        grid.fillView();
		}
	}

}
