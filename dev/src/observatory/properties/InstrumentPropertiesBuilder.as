package observatory.properties {

    public class InstrumentPropertiesBuilder {

        private var _name:String;
        private var _image:Class;
        private var _isNode:Boolean                     = false;
        private var _dataTerrainTypes:Vector.<String>   = new Vector.<String>;

        public function InstrumentPropertiesBuilder(name:String) {

            _name = name;
        }

        public function image(img:Class):InstrumentPropertiesBuilder {

            _image = img;
            return this;
        }

        public function producesDataOn(... terrainTypes):InstrumentPropertiesBuilder {

            for (var i:int = 0; i < terrainTypes.length; ++i) {

                _dataTerrainTypes.push(terrainTypes[i]);
            }

            return this;
        }

        public function isNode():InstrumentPropertiesBuilder {

            _isNode = true;
            return this;
        }

        public function finish():InstrumentProperties {

            if (!_image) throw new Error("Image not set");

            return new InstrumentProperties(
                _name,
                _image,
                _isNode,
                _dataTerrainTypes
            );
        }
    }
}
