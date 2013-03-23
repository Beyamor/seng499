package hex.entities
{
	import common.PositionHelper;
	import hex.HexTile;
	import net.flashpunk.Entity;
	import observatory.Instrument;
	import observatory.ObservatoryComponent;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class HexInstrumentImage extends HexComponentEntity
	{
		private var instrument:Instrument;
		public function HexInstrumentImage(instrument:ObservatoryComponent, tile:HexTile)
		{
			super(instrument, tile)
			
			switch (tile.hexSubEntities.length) {
				
				case 0:
					x = tile.x - width - 5;
					y = tile.y - height - 5;
					break;
					
				case 1:
					x = tile.x + 5;
					y = tile.y + 5;
					break;
					
				default:
					throw new Error("Don't know how to position for more than two sub entities");
			}
		}
	}
}
