package model 
{
	import common.Assets;
	import net.flashpunk.graphics.Image;
	import observatory.Node;
	import observatory.Instrument;
	import hex.math.SpaceConverter;
	import hex.HexData;
	import net.flashpunk.FP;
	import hex.terrain.Terrain;
	import hex.HexIndices;
	import observatory.ComponentData;

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
		
		
		public function PlayerData()
		{
			populateStoreList();
			addDummyData();
			
            addNode(new Node(70, 70));
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
		
		public function addNode(node:Node):void
		{
			var converter:SpaceConverter = SpaceConverter.getCanonical();
			var hexCoords:HexIndices     = converter.getTileIndices(node.getMapX(), node.getMapY());
			nodeList.push(node);

                        getHexData(hexCoords).addObservatoryComponent(node);
		}
		
		public function populateStoreList():void
		{
			storeList.push(new ComponentData(0));
			storeList.push(new ComponentData(1));
			storeList.push(new ComponentData(0));
			storeList.push(new ComponentData(1));
			storeList.push(new ComponentData(0));
			storeList.push(new ComponentData(1));
			storeList.push(new ComponentData(0));
			storeList.push(new ComponentData(1));
			storeList.push(new ComponentData(0));
			storeList.push(new ComponentData(1));
			storeList.push(new ComponentData(0));
			storeList.push(new ComponentData(1));
		}
		
		public function addDummyData():void
		{
			addToInventory(new ComponentData(0));
			instrumentsInventory.push(new ComponentData(1));
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

                public function setHexData(indices:HexIndices, data:HexData):void {
 
			if (!hexData[indices.x]) hexData[indices.x] = new Object;
			hexData[indices.x][indices.y] = data;
                }

                private function createHexDataIfNecessary(indices:HexIndices):void {

			if (!hexData[indices.x])            hexData[indices.x]            = new Object;
			if (!hexData[indices.x][indices.y]) hexData[indices.x][indices.y] = new HexData(new hex.terrain.Terrain);
                }

                public function getHexData(indices:HexIndices):HexData {

                    // For the sake of adding nodes to hexes, we'll still create hex data if necessary
                    // However, we need to figure out what to do about stuff like the node hex's terrain
                    createHexDataIfNecessary(indices);
                    return hexData[indices.x][indices.y];
                }
	}

}
