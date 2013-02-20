package hex {

    /**
     *      The data relevant to a single hex tile.
     *      This class should describe all the important information about a hex.
     *      As a requisite, this class should be ammenable to serialization.
     */
    public class HexData {

        private var components:Vector.<ObservatoryComponent> = new Vector.<ObservatoryComponent>;

        public function HexData() {

        }

        public function addObservatoryComponent(component:ObservatoryComponent):void {

            components.push(component);
        }

        public function get observatoryComponents():Vector.<ObservatoryComponent> {

            // ugh should make a copy but whatever just don't modify this
            return components;
        }
    }
}
