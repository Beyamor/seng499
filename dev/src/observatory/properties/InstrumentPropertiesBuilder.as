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
		private var _dataTypeProduced:String;
		private var _displayDescription:String;
		private var _dataDescription:String;
		private var _interestingDataDescription:String;

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
		
		public function produces(dataType:String):InstrumentPropertiesBuilder {
			
			_dataTypeProduced = dataType;
			return this;
		}
		
		public function displayDescription(descrption:String):InstrumentPropertiesBuilder {
			
			_displayDescription = descrption;
			return this;
		}
		
		public function dataDescription(descrption:String):InstrumentPropertiesBuilder {
			
			_dataDescription = descrption;
			return this;
		}
		
		public function interestingDataDescription(descrption:String):InstrumentPropertiesBuilder {
			
			_interestingDataDescription = descrption;
			return this;
		}

        public function finish():InstrumentProperties {

            if (!_image) throw new Error("Image not set");
			if (!_cost) throw new Error("Cost not set");
			
			// Instruments only
			if (!_isNode) {
				
				if (!_dataTypeProduced) throw new Error("Data production type not set");
				if (!_displayDescription) throw new Error("Instrument description not provided");
			}

            return new InstrumentProperties(
                _name,
                _image,
				_storeImage,
                _dataTerrainTypes,
				_cost,
				_isNode,
				_isSeenOnHexGrid,
				_dataTypeProduced,
				_displayDescription,
				_dataDescription? _dataDescription : ("Description not provided for " + _name),
				_interestingDataDescription? _interestingDataDescription : ("Interesting data description not provided for " + _name)
            );
        }
    }
}
