package hex {

	import observatory.Connectable;
    import observatory.Node;
    import hex.terrain.Terrain;
	import model.GameTables;
	import observatory.ComponentData;
    import observatory.ObservatoryComponent;
	import hex.terrain.Types;

    /**
     *      The data relevant to a single hex tile.
     *      This class should describe all the important information about a hex.
     *      As a requisite, this class should be ammenable to serialization.
     */
    public class HexData {

        private var components:Vector.<ObservatoryComponent> = new Vector.<ObservatoryComponent>;
		private var freeSpace:int = GameConstants.DEFAULT_FREE_SPACE;
        private var _terrain:Terrain;
		
		private var _discovered:Boolean;
		public function get discovered():Boolean { return _discovered; }
		
        public function get terrain():Terrain { return _terrain; }

        public function HexData(terrain:Terrain ,disc:Boolean = false) {

            _terrain = terrain;
			_discovered = disc;
        }

        public function addObservatoryComponent(component:ObservatoryComponent):void {

            components.push(component);
			discover(new Terrain(Types.MUD));
        }

        public function get observatoryComponents():Vector.<ObservatoryComponent> {

            // ugh should make a copy but whatever just don't modify this
            return components;
        }

        public function get hasConnectors():Boolean {

            for each (var observatoryComponent:ObservatoryComponent in observatoryComponents) {

                if (observatoryComponent is Connectable){ // Changed this to check other stuff

                    return true;
                }
            }

            return false;
        }
		
		public function hasSubImages():Boolean {

            for each (var observatoryComponent:ObservatoryComponent in observatoryComponents) {

                if (observatoryComponent.isSeenFromHexGrid()){ // Changed this to check other stuff

                    return true;
                }
            }

            return false;
        }
		
		public function hasNode():Boolean
		{
			for each (var observatoryComponent:ObservatoryComponent in observatoryComponents) {

                if (observatoryComponent.isNode()){ // Changed this to check other stuff

                    return true;
                }
            }

            return false;
		}
		
		/**
		 * Sets permanent terrain value of tile.
		 * @param	terrain
		 */
		public function discover(terrain:Terrain):void {
			_discovered = true;
			_terrain = terrain;
		}
		
		
    }
}
