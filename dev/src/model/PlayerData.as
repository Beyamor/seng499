package model 
{
	import common.Assets;
	import net.flashpunk.graphics.Image;
	import hex.math.SpaceConverter;
	import hex.HexData;
	import net.flashpunk.FP;
	import hex.terrain.Terrain;
	import hex.HexIndices;
	import observatory.ComponentData;
	import observatory.Instrument;
	import observatory.Node;
	import time.Calendar;
	import map.terrain.TerrainForce;
	import hex.terrain.TerrainSetter;

	/**
	 * ...
	 * @author Lambwatt
	 */
	public class PlayerData 
	{

		public var instrumentsInventory:Vector.<ComponentData> = new Vector.<ComponentData>();
		public var storeList:Vector.<ComponentData> = new Vector.<ComponentData>();
		public var nodeList:Vector.<Node> = new Vector.<Node>();//Instruments will be added here.
		private var nextId:uint = 0; //This will need to be treated differently when loading a saved game.
        private var hexData:Object = new Object;//Vector.<ObservatoryComponent> = new Vector.<ObservatoryComponent>;
		public var calendar:Calendar = new Calendar;
		private var _money:uint = 100;
		private var _unresolvedTerrainForces:Vector.< Vector.< Vector.<TerrainForce> > > = new Vector.< Vector.< Vector.<TerrainForce> > >;	
		
		public function PlayerData()
		{
			populateStoreList();
		}
		
		public function printInventory():void
		{
			trace("begin");
			for (var i:int; i < instrumentsInventory.length; i++ )
			{
				trace((instrumentsInventory[i]as Instrument).getName());
			}
			trace("end");
		}
		
		public function addToInventory(data:ComponentData):void
		{
			instrumentsInventory.push(data);
		}
		
		public function removeFromInventory(data:ComponentData):void
		{
			var dataIndex:int = instrumentsInventory.indexOf(data);
			if (dataIndex < 0) return;
			
			instrumentsInventory.splice(dataIndex, 1);
		}
		
		public function addNode(node:Node):void
		{
			var converter:SpaceConverter = SpaceConverter.getCanonical();
			var hexCoords:HexIndices     = converter.getTileIndices(node.getMapX(), node.getMapY());
			nodeList.push(node);
			new TerrainSetter(this).setTerrain(hexCoords);
			getHexData(hexCoords).addObservatoryComponent(node/*new Observ(new ComponentData(GameTables.instrumentIDByName("node"))*/);
		}
		
		public function populateStoreList():void
		{
			storeList.push(new ComponentData(GameTables.instrumentIDByName("Node")));
			storeList.push(new ComponentData(GameTables.instrumentIDByName("Hydraphone")));
			storeList.push(new ComponentData(GameTables.instrumentIDByName("CTB")));
			storeList.push(new ComponentData(GameTables.instrumentIDByName("Camera")));
			storeList.push(new ComponentData(GameTables.instrumentIDByName("ADCR")));
		}
		
		public function getInventory():Vector.<ComponentData>
		{
			return instrumentsInventory;
		}
		
		public function getNextId():uint {
			return nextId++;
		}

		public function hexDataExists(indices:HexIndices):Boolean {

			if (!hexData[indices.x])            return false;
			if (!hexData[indices.x][indices.y]) return false;
			return true;
		}
		
		public function hexDataDiscovered(indices:HexIndices):Boolean {

			if (!hexData[indices.x][indices.y].discovered) return false;
			return true;
		}

		public function setHexData(indices:HexIndices, data:HexData):void {
 
			if (!hexData[indices.x]) hexData[indices.x] = new Object;
			hexData[indices.x][indices.y] = data;
		}

		private function createHexDataIfNecessary(indices:HexIndices):void {

			if (!hexData[indices.x])            
				hexData[indices.x]            = new Object;
			if (!hexData[indices.x][indices.y]) 
				hexData[indices.x][indices.y] = new HexData(new hex.terrain.Terrain);
		}

		public function getHexData(indices:HexIndices):HexData {

			// For the sake of adding nodes to hexes, we'll still create hex data if necessary
			// However, we need to figure out what to do about stuff like the node hex's terrain
			createHexDataIfNecessary(indices);
			return hexData[indices.x][indices.y];
		}
		
		public function get hexes():Vector.<HexData> {
			
			var hexes:Vector.<HexData> = new Vector.<HexData>;
			
			for (var xIndex:String in hexData) {
				for (var yIndex:String in hexData[xIndex]) {
					
					hexes.push(hexData[xIndex][yIndex]);
				}
			}
			
			return hexes;
		}
		
		public function addMoney(amount:uint):PlayerData {
			
			_money += amount;
			return this;
		}
		
		public function get money():uint {
			
			return _money;
		}
		
		public function canAfford(component:ComponentData):Boolean {
			
			return money >= GameTables.instrumentByName(component.getName()).cost;
		}
		
		public function purchase(component:ComponentData):void {
			
			if (!canAfford(component)) throw new Error("Can't afford " + component.getName() + "; check first!");
			
			_money -= GameTables.instrumentByName(component.getName()).cost;
			addToInventory(component);
		}
		
		/**
		 * Used to store terrain forces that affect unknown tiles.
		 * @param	force
		 * @param	indecies
		 */
		public function storeTerrainForce(force:TerrainForce, indecies:HexIndices)
		{
			_unresolvedTerrainForces[indecies.x][indecies.y].push(force);
		}
		
		public function getTerrainForces(indecies:HexIndices):Vector.<TerrainForce>
		{
			return _unresolvedTerrainForces[indecies.x][indecies.y];
		}
	}

}

