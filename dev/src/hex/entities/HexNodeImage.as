package hex.entities 
{
	import common.PositionHelper;
	import hex.HexTile;
	import net.flashpunk.Entity;
	import observatory.Connectable;
	import observatory.ObservatoryComponent;
	
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class HexNodeImage extends HexComponentEntity 
	{
		
		public function HexNodeImage(instrument:ObservatoryComponent, tile:HexTile)
		{
			super(instrument, tile)
			
			PositionHelper.centerOn(this, tile);
			
			for (var i:int; i < (tile.data.observatoryComponents[0]as Connectable).getConnections.length; i++ )
			{
				var destTile:Tile
			}
		}
	}
}