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

        public static function areValid(xIndex:int, yIndex:int):Boolean {

            return (Math.abs(xIndex) % 2) == (Math.abs(yIndex) % 2)
        }
    }
}
