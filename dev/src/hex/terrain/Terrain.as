package hex.terrain {

    /**
     *      Describes, obviously, the terrain of a single hex.
     */
    public class Terrain {

        private var _type:String;
        public function get type():String { return _type; }

        public function Terrain() {

            _type = Types.getAny();
        }
    }
}
