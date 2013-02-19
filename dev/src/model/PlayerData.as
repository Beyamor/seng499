package model 
{
	import common.Assets;
	import net.flashpunk.graphics.Image;
	import map.Node;
	import hex.math.SpaceConverter;
	import flash.geom.Point;

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
        private var hexInstruments:Object = new Object;//Vector.<ObservatoryComponent> = new Vector.<ObservatoryComponent>;
		
		
		public function PlayerData()
		{
			populateStoreList();
			addDummyData();
		}
		
		public function printInventory()
		{
			trace("begin");
			for (var i:int; i < instrumentsInventory.length; i++ )
			{
				trace((instrumentsInventory[i]as Instrument).getName());
			}
			trace("end");
		}
		
		public function addToInventory(data:InstrumentData)
		{
			instrumentsInventory.push(data);
		}
		
		public function addNode(node:Node)
		{
			var converter:SpaceConverter = new SpaceConverter(GameConstants.HEX_RADIUS,
																GameConstants.MAP_PIXEL_WIDTH, GameConstants.MAP_PIXEL_HEIGHT,
																GameConstants.HEX_VIEW_WIDTH, GameConstants.HEX_VIEW_HEIGHT);
			var hexCoords:Point         = converter.getConvertedPoint(node.getMapX(), node.getMapY());
			addToHexInstruments(hexCoords.x, hexCoords.y, node)
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


		public function addToHexInstruments(xIndex:uint, yIndex:uint, instrument:ObservatoryComponent):void {

			if (!hexInstruments[xIndex])          hexInstruments[xIndex]            = new Object;//Vector.<ObservatoryComponent>;
			if (!hexInstruments[xIndex][yIndex])  hexInstruments[xIndex][yIndex]    = new Vector.<ObservatoryComponent>;

			hexInstruments[xIndex][yIndex].push(instrument);
		}

		public function getHexInstruments(xIndex:uint, yIndex:uint):Vector.<ObservatoryComponent> {

			if (!hexInstruments[xIndex])          return new Vector.<ObservatoryComponent>;
			if (!hexInstruments[xIndex][yIndex])  return new Vector.<ObservatoryComponent>;

			return hexInstruments[xIndex][yIndex];
		}
	}

}
