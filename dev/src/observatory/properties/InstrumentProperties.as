package observatory.properties {

    import hex.terrain.Terrain;

    public class InstrumentProperties {

        private var _name:String;
        public function get name():String { return _name; }

        private var _image:Class;
        public function get image():Class { return _image; }

        private var _isNode:Boolean;
        public function get isNode():Boolean { return _isNode; }
		
		private var _isSeenOnHexGrid:Boolean;
		public function get isSeenOnHexGrid():Boolean { return _isSeenOnHexGrid; }

        private var _dataTerrainTypes:Vector.<String> = new Vector.<String>;

        public function InstrumentProperties(
            name:String,
            image:Class,
			dataTerrainTypes:Vector.<String>,
            isNode:Boolean = false,
			isSeenOnHexGrid:Boolean = false) {

            _name               = name;
            _image              = image;
            _isNode             = isNode;
			_isSeenOnHexGrid	= isSeenOnHexGrid;
            _dataTerrainTypes   = dataTerrainTypes;
        }

        public function producesDataFor(terrain:Terrain):Boolean {

            return _dataTerrainTypes.indexOf(terrain.type) != -1;
        }

        public static function describe(name:String):InstrumentPropertiesBuilder {

            return new InstrumentPropertiesBuilder(name);
        }
    }
}
