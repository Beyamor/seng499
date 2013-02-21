package hex.math {

    import flash.geom.Point;

    /**
     *      This guy provides conversions between one space (e.g., map) to another (e.g., hexes)
     */
    public class SpaceConverter {
        
        // Properties!
        private var _hexProperties:HexGeometricProperties;
        private function get hexProperties():HexGeometricProperties { return _hexProperties; }
        private var _gridMather:HexGridMather;
        private function get gridMather():HexGridMather { return _gridMather; }

        private var _xScale:Number;
        private function get xScale():Number { return _xScale; }
        private var _yScale:Number;
        private function get yScale():Number { return _yScale; }

        public function SpaceConverter(
            hexagonRadius:Number,
            fromWidthInPixels:Number, fromHeightInPixels:Number,
            toWidthInPixels:Number, toHeightInPixels:Number) {

            _hexProperties = HexGeometricProperties.getByRadius(hexagonRadius);
            _gridMather = new HexGridMather(hexagonRadius, toWidthInPixels, toHeightInPixels);
            _xScale = toWidthInPixels / fromWidthInPixels;
            _yScale = toHeightInPixels / fromHeightInPixels;
        }

        /**
         *      Convertes coordinates from the from space to the to space
         */
        public function getConvertedPoint(x:Number, y:Number):Point {

            return new Point(x * xScale, y * yScale);
        }

        /**
         *      Convertes coordinates between spaces and gets the hex containing those coordinates.
         */
        public function getTileIndices(x:Number, y:Number):Object {

            var convertedPoint:Point = getConvertedPoint(x, y);

            var xIndex:uint = gridMather.lowerXIndex(convertedPoint.x);
            var yIndex:uint = gridMather.lowerYIndex(convertedPoint.y);

            // ughhhh
            // TODO: revisit this when soberer. Do it better.
            if (xIndex % 2 != yIndex % 2) yIndex -= 1;

            return {x: xIndex, y: yIndex};
        }
    }
}
