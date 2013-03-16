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


        private var _dataTerrainTypes:Vector.<String> = new Vector.<String>;

        public function InstrumentProperties(
            name:String,
            image:Class,
			storeImage:Class,
			dataTerrainTypes:Vector.<String>,
			cost:uint, 
            isNode:Boolean = false,
			isSeenOnHexGrid:Boolean = false) {


            _name               = name;
            _image              = image;
			_storeImage			= storeImage
            _isNode             = isNode;
			_isSeenOnHexGrid	= isSeenOnHexGrid;
            _dataTerrainTypes   = dataTerrainTypes;
			_cost				= cost;
        }

        public function producesDataFor(terrain:Terrain):Boolean {

            return _dataTerrainTypes.indexOf(terrain.type) != -1;
        }

        public static function describe(name:String):InstrumentPropertiesBuilder {

            return new InstrumentPropertiesBuilder(name);
        }
    }
}
