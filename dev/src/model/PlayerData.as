package model 
{
	import common.Assets;
	import net.flashpunk.graphics.Image;
	import map.Node;
	import hex.math.SpaceConverter;
	import flash.geom.Point;
        import hex.HexData;
        import net.flashpunk.FP;
        import hex.terrain.Terrain;

	/**
	 * ...
	 * @author Lambwatt
	 */
	public class PlayerData 
	{

		public var instrumentsInventory:Vector.<InstrumentData> = new Vector.<InstrumentData>();
		public var storeList:Vector.<InstrumentData> = new Vector.<InstrumentData>();
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
		
		public function addToInventory(data:InstrumentData):void
		{
			instrumentsInventory.push(data);
		}
		
		public function addNode(node:Node):void
		{
			var converter:SpaceConverter = SpaceConverter.getCanonical();
			var hexCoords:Point         = converter.getTileIndices(node.getMapX(), node.getMapY());
			nodeList.push(node);

                        getHexData(hexCoords.x, hexCoords.y).addObservatoryComponent(node);
		}
		
		public function populateStoreList():void
		{
			storeList.push(new InstrumentData(0));
			storeList.push(new InstrumentData(1));
			storeList.push(new InstrumentData(0));
			storeList.push(new InstrumentData(1));
			storeList.push(new InstrumentData(0));
			storeList.push(new InstrumentData(1));
			storeList.push(new InstrumentData(0));
			storeList.push(new InstrumentData(1));
			storeList.push(new InstrumentData(0));
			storeList.push(new InstrumentData(1));
			storeList.push(new InstrumentData(0));
			storeList.push(new InstrumentData(1));
		}
		
		public function addDummyData():void
		{
			addToInventory(new InstrumentData(0));
			instrumentsInventory.push(new InstrumentData(1));
		}
		
		public function getInventory():Vector.<InstrumentData>
		{
			return instrumentsInventory;
		}
		
		public function getNextId():uint {
			return nextId++;
		}

                public function hexDataExists(xIndex:uint, yIndex:uint):Boolean {

                    if (!hexData[xIndex])           return false;
                    if (!hexData[xIndex][yIndex])   return false;
                    return true;
                }

                public function setHexData(xIndex:uint, yIndex:uint, data:HexData):void {
 
			if (!hexData[xIndex]) hexData[xIndex] = new Object;
			hexData[xIndex][yIndex] = data;
                }

                private function createHexDataIfNecessary(xIndex:uint, yIndex:uint):void {

			if (!hexData[xIndex])          hexData[xIndex]            = new Object;
			if (!hexData[xIndex][yIndex])  hexData[xIndex][yIndex]    = new HexData(new hex.terrain.Terrain);
                }

                public function getHexData(xIndex:uint, yIndex:uint):HexData {

                    // For the sake of adding nodes to hexes, we'll still create hex data if necessary
                    // However, we need to figure out what to do about stuff like the node hex's terrain
                    createHexDataIfNecessary(xIndex, yIndex);
                    return hexData[xIndex][yIndex];
                }
	}

}
