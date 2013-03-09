package hex {

    import map.Node;
    import hex.terrain.Terrain;
	import model.GameTables;
	import observatory.ComponentData;
    import observatory.ObservatoryComponent;

    /**
     *      The data relevant to a single hex tile.
     *      This class should describe all the important information about a hex.
     *      As a requisite, this class should be ammenable to serialization.
     */
    public class HexData {

        private var components:Vector.<ComponentData> = new Vector.<ComponentData>;

        private var _terrain:Terrain;
        public function get terrain():Terrain { return _terrain; }

        public function HexData(terrain:Terrain) {

            _terrain = terrain;
        }

        public function addObservatoryComponent(component:ComponentData):void {

            components.push(component);
        }

        public function get observatoryComponents():Vector.<ComponentData> {

            // ugh should make a copy but whatever just don't modify this
            return components;
        }

        public function get hasNode():Boolean {

            for each (var observatoryComponent:ComponentData in observatoryComponents) {

                if (observatoryComponent.isNode()) { // Wut

                    return true;
                }
            }

            return false;
        }
    }
}
