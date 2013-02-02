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
		
		public function HexView() 
		{
			addGraphic(new Text("HexView", 10, 30, 100, 30));
			
			var grid:HexGrid = new HexGrid(800, 600, 62);
			
			for each (var tile:HexTile in grid.allTiles)	add(tile);
		}
		
		override public function update():void 
		{
			super.update();
			
			const speed:Number = 5;
			
			if (Input.check("hex-scroll-up"))		FP.camera.y -= speed;
			if (Input.check("hex-scroll-down"))		FP.camera.y += speed;
			if (Input.check("hex-scroll-left"))		FP.camera.x -= speed;
			if (Input.check("hex-scroll-right"))	FP.camera.x += speed;
		}
	}

}