package hex.math {

    import flash.geom.Point;
    import hex.HexIndices;

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
        public function getTileIndices(x:Number, y:Number):HexIndices {

            var convertedPoint:Point = getConvertedPoint(x, y);
            
            // I haven't thought of a way to do this accurately, but efficiently
            // I know it's possible, but I'm not very smart
            // For the time being, we'll do a rough approximation
            var xIndex:uint = Math.round(
                                convertedPoint.x
                                / hexProperties.interleavedHorizontalDistance);
            var yIndex:uint;

            // Ugh this is incredibly opaque
            // Trust that it kinda works in a non-mathy way
            if (xIndex % 2 == 0) {

                yIndex = Math.round(
                            convertedPoint.y
                            / hexProperties.verticalHeight) * 2;
            }

            else {

                yIndex = Math.round(
                            (convertedPoint.y - hexProperties.verticalHeight / 2)
                            / hexProperties.verticalHeight) * 2 + 1;
            }

            return new HexIndices(xIndex, yIndex);
        }

        /**
         *      Gets the space converter defined in terms of game constants.
         */
         public static function getCanonical():SpaceConverter {

            return new SpaceConverter(
                GameConstants.HEX_RADIUS,
                GameConstants.MAP_PIXEL_WIDTH, GameConstants.MAP_PIXEL_HEIGHT,
	        GameConstants.HEX_VIEW_WIDTH, GameConstants.HEX_VIEW_HEIGHT);

         }
    }
}
