package hex 
{
	import net.flashpunk.graphics.Text;
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
	}

}