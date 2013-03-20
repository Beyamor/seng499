package observatory.properties {
	import hex.terrain.Types;

    public class InstrumentPropertiesBuilder {

        private var _name:String;
        private var _image:Class;
		private var _storeImage:Class;
		private var _isSeenOnHexGrid:Boolean			= true;
        private var _isNode:Boolean                     = false;
        private var _dataTerrainTypes:Vector.<String>   = new Vector.<String>;
		private var _cost:uint;

        public function InstrumentPropertiesBuilder(name:String) {

            _name = name;
        }

        public function image(img:Class):InstrumentPropertiesBuilder {

            _image = img;
            return this;
        }
		
		public function storeImage(img:Class):InstrumentPropertiesBuilder {

            _storeImage = img;
            return this;
        }

        public function producesDataOn(... terrainTypes):InstrumentPropertiesBuilder {

            for (var i:int = 0; i < terrainTypes.length; ++i) {

                _dataTerrainTypes.push(terrainTypes[i]);
            }

            return this;
        }
		
		public function get producesDataOnAllTerrain():InstrumentPropertiesBuilder {
			
			_dataTerrainTypes = Types.ALL_TYPES;
			return this;
		}

        public function get isNode():InstrumentPropertiesBuilder {

            _isNode = true;
            return this;
        }
		

		public function isNotSeenOnGird():InstrumentPropertiesBuilder {
			
			_isSeenOnHexGrid = false;
			return this;
		}
		
		public function costs(costs:uint):InstrumentPropertiesBuilder {
			
			_cost = costs;
			return this;
		}

        public function finish():InstrumentProperties {

            if (!_image) throw new Error("Image not set");
			if (!_cost) throw new Error("Cost not set");

            return new InstrumentProperties(
                _name,
                _image,
				_storeImage,
                _dataTerrainTypes,
				_cost,
				_isNode,
				_isSeenOnHexGrid

            );
        }
    }
}
