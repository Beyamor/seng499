package hex.debug 
{
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.World;
	import hex.HexTile;
	
	/**
	 * This is just a dummy world for me to test transitioning from a hex tile.
	 * @author beyamor
	 */
	public class DummyTileWorld extends World 
	{
		private var color:uint;
		
		public function DummyTileWorld(tile:HexTile)
		{
			color = tile.color;
		}
		
		override public function render():void 
		{
			Draw.rect(0, 0, FP.width, FP.height, color);
			
			super.render();
		}
	}

}