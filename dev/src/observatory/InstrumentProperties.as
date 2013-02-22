package observatory {

    import hex.terrain.Terrain;

    public class InstrumentProperties {

        private var dataTerrainTypes:Vector.<String> = new Vector.<String>;

        public function producesDataOn(... terrainTypes):InstrumentProperties {

            for (var i:int = 0; i < terrainTypes.length; ++i) dataTerrainTypes.push(terrainTypes[i]);

            return this;
        }

        public function producesDataFor(terrain:Terrain):Boolean {

            return dataTerrainTypes.indexOf(terrain.type) != -1;
        }
    }
}
