package data 
{
	import model.GameTables;
	import model.PlayerData;
	import observatory.ComponentData;
	import observatory.ObservatoryComponent;
	import observatory.properties.InstrumentProperties;
	import hex.HexData;
	/**
	 * This guy sums the data currently being produced.
	 * @author beyamor
	 */
	public class DataTally 
	{
		private var playerData:PlayerData;
		
		public function DataTally(playerData:PlayerData)
		{
			this.playerData = playerData;
		}
		
		public function get sum():uint {
			
			var sum:uint = 0;
			
			for each (var hexData:HexData in playerData.hexes) {
				
				for each (var component:ComponentData in hexData.observatoryComponents) {
					
					if (component.isNode()) continue;
					
					var componentProperties:InstrumentProperties = GameTables.instruments[GameTables.getInstrumentIDByName(component.getName())];
					var isProducingData = componentProperties.producesDataFor(hexData.terrain);
					
					if (isProducingData) ++sum;
				}
			}
			
			return sum;
		}
	}

}