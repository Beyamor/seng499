package hex {

    public class HexIndices {

        private var _xIndex:int;
        public function get x():int { return _xIndex; }

        private var _yIndex:int;
        public function get y():int { return _yIndex; }

        public function HexIndices(xIndex:int, yIndex:int) {

            if (!HexIndices.areValid(xIndex, yIndex)) throw new Error("Indices don't match: " + xIndex + ", " + yIndex);
            _xIndex = xIndex;
            _yIndex = yIndex;
        }

        public function get isEven():Boolean {

            return x % 2 == 0;
        }

        public function get north():HexIndices      { return new HexIndices(x, y - 2); }
        public function get south():HexIndices      { return new HexIndices(x, y + 2); }
        public function get northWest():HexIndices  { return new HexIndices(x - 1, y - 1); }
        public function get northEast():HexIndices  { return new HexIndices(x + 1, y - 1); }
        public function get southWest():HexIndices  { return new HexIndices(x - 1, y + 1); }
        public function get southEast():HexIndices  { return new HexIndices(x + 1, y + 1); }

        public static function areValid(xIndex:int, yIndex:int):Boolean {

            return (Math.abs(xIndex) % 2) == (Math.abs(yIndex) % 2)
        }
    }
}
