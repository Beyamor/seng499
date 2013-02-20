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

		public var instrumentsInventory:Vector.<ComponentData> = new Vector.<ComponentData>();
		public var storeList:Vector.<ComponentData> = new Vector.<ComponentData>();
		public var nodeList:Vector.<Node> = new Vector.<Node>();//Instruments will be added here.
		private var nextId:uint = 0; //This will need to be treated differently when loading a saved game.
        private var hexInstruments:Object = new Object;//Vector.<ObservatoryComponent> = new Vector.<ObservatoryComponent>;
		
		
		public function PlayerData()
		{
			populateStoreList();
			addDummyData();
			
			nodeList.push(new Node(70, 70));
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
			var converter:SpaceConverter = new SpaceConverter(GameConstants.HEX_RADIUS,
																GameConstants.MAP_PIXEL_WIDTH, GameConstants.MAP_PIXEL_HEIGHT,
																GameConstants.HEX_VIEW_WIDTH, GameConstants.HEX_VIEW_HEIGHT);
			var hexCoords:Point         = converter.getConvertedPoint(node.getMapX(), node.getMapY());
			nodeList.push(node);
			addToHexInstruments(hexCoords.x, hexCoords.y, node)
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
