package hex {

    import observatory.Node;
    import hex.terrain.Terrain;
    import observatory.ObservatoryComponent;

    /**
     *      The data relevant to a single hex tile.
     *      This class should describe all the important information about a hex.
     *      As a requisite, this class should be ammenable to serialization.
     */
    public class HexData {

        private var components:Vector.<ObservatoryComponent> = new Vector.<ObservatoryComponent>;

        private var _terrain:Terrain;
        public function get terrain():Terrain { return _terrain; }

        public function HexData(terrain:Terrain) {

            _terrain = terrain;
        }

        public function addObservatoryComponent(component:ObservatoryComponent):void {

            components.push(component);
        }

        public function get observatoryComponents():Vector.<ObservatoryComponent> {

            // ugh should make a copy but whatever just don't modify this
            return components;
        }

        public function get hasNode():Boolean {

            for each (var observatoryComponent:ObservatoryComponent in observatoryComponents) {

                if (observatoryComponent is Node) { // Wut

                    return true;
                }
            }

            return false;
        }
    }
}
