package hex.entities 
{
	import hex.HexGrid;
	import model.PlayerData;
	import hex.HexData;
	import observatory.Connectable;
	import observatory.Instrument;
	import observatory.Node;
	import observatory.ObservatoryComponent;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class CableAdder 
	{
		private var data:PlayerData;
		
		public function CableAdder(grid:HexGrid,data:PlayerData) 
		{
			for each (var tile:HexData in data.hexes)
			{
				if (tile.hasNode)
				{
					if ((tile.observatoryComponents[0] as Connectable).getConnections.length > 0)
					{
						var rootX:int = tile.
						for each( var component:ObservatoryComponent in (tile.observatoryComponents[0] as Connectable).getConnections())
						{
							(component as Instrument).getTile
						}
					}
				}
			}
		}
		
	}

}