package hex.entities 
{
	import hex.displays.HexDisplay;
	import hex.HexGrid;
	import hex.HexTile;
	import model.PlayerData;
	import hex.HexData;
	import observatory.Connectable;
	import observatory.Instrument;
	import observatory.Node;
	import observatory.ObservatoryComponent;
	import hex.math.SpaceConverter;
	import hex.HexIndices;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class CableAdder 
	{
		private var data:PlayerData;
		private var grid:HexGrid;
		private var display:HexDisplay;
		
		public function CableAdder(display:HexDisplay,grid:HexGrid,data:PlayerData) 
		{
			this.display = display;
			this.grid = grid;
			this.data = data;
		}
		
		public function addCables():void
		{
			for each (var tile:HexData in data.hexes)
			{
				if (tile.hasNode())
				{
					
					var converter:SpaceConverter = SpaceConverter.getCanonical();
					var hexCoords:HexIndices     = converter.getTileIndices((tile.observatoryComponents[0] as Connectable as Node).getMapX(),
																			(tile.observatoryComponents[0] as Connectable as Node).getMapY());
				
					var startTile:HexTile = grid.getTileAtIndex(hexCoords);
					
					for each( var component:ObservatoryComponent in (tile.observatoryComponents[0] as Connectable).getConnections())
					{
						for each (var subEntity:HexComponentEntity in (component as Instrument).getTile().hexSubEntities)
						{
							display.add(new ConnectedCable(startTile.x, startTile.y, subEntity.wireX(), subEntity.wireY()));
						}
					}
					
					
				}
			}
		}
	}

}