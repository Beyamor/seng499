package observatory.properties {

    import hex.terrain.Terrain;
	import hex.terrain.Types;

    public class InstrumentProperties {

        private var _name:String;
        public function get name():String { return _name; }

        private var _image:Class;
        public function get image():Class { return _image; }

        private var _storeImage:Class;
        public function get storeImage():Class { return _storeImage; }
		
        private var _isNode:Boolean;
        public function get isNode():Boolean { return _isNode; }
		
		private var _isSeenOnHexGrid:Boolean;
		public function get isSeenOnHexGrid():Boolean { return _isSeenOnHexGrid; }

		private var _cost:uint;
        public function get cost():uint { return _cost; }
		
		private var _dataTypeProduced:String;
		public function get dataType():String { return _dataTypeProduced; }
		
		private var _displayDescription:String;
		public function get description():String { return _displayDescription; }
		
		private var _dataDescription:String;
		public function get dataDescription():String { return _dataDescription; }

		private var _interestingDataDescription:String;
		public function get interestingDataDescription():String { return _interestingDataDescription; }

		private var _dataValue:int;
		public function get dataValue():int { return _dataValue; }
		
		
        private var _dataTerrainTypes:Vector.<String> = new Vector.<String>;

        public function InstrumentProperties(
            name:String,
            image:Class,
			storeImage:Class,
			dataTerrainTypes:Vector.<String>,
			cost:uint, 
            isNode:Boolean,
			isSeenOnHexGrid:Boolean,
			dataType:String,
			description:String,
			dataDescription:String,
			interestingDataDescription:String,
			dataValue:int){


            _name               		= name;
            _image              		= image;
			_storeImage					= storeImage
            _isNode             		= isNode;
			_isSeenOnHexGrid			= isSeenOnHexGrid;
            _dataTerrainTypes   		= dataTerrainTypes;
			_cost						= cost;
			_dataTypeProduced			= dataType;
			_displayDescription			= description;
			_dataDescription			= dataDescription;
			_interestingDataDescription	= interestingDataDescription;
			_dataValue					= dataValue;
        }

        public function producesDataFor(terrain:Terrain):Boolean {

            return _dataTerrainTypes.indexOf(terrain.type) != -1;
        }

        public static function describe(name:String):InstrumentPropertiesBuilder {

            return new InstrumentPropertiesBuilder(name);
        }
    }
}
