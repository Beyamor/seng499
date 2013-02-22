package observatory {

    public class InstrumentProperties {

        private var dataTerrains:Vector.<String> = new Vector.<String>;

        public function producesDataOn(... terrains):InstrumentProperties {

            for (var i:int = 0; i < terrains.length; ++i) dataTerrains.push(terrains[i]);

            return this;
        }
    }
}
