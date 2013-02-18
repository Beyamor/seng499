package hex.math {

    import flash.geom.Point;

    /**
     *      Lemme just wrap up some math here.
     */
    public class HexGridMather {

        // Those properties'll be handy
        private var _hexProperties:HexGeometricProperties;
        private function get hexProperties():HexGeometricProperties { return _hexProperties; }

        // Okay. Let's bound this thing.
        private var _absMinXIndex:int;
        private function get absMinXIndex():int { return _absMinXIndex; }
        private var _absMaxXIndex:int;
        private function get absMaxXIndex():int { return _absMaxXIndex; }
        private var _absMinYIndex:int;
        private function get absMinYIndex():int { return _absMinYIndex; }
        private var _absMaxYIndex:int;
        private function get absMaxYIndex():int { return _absMaxYIndex; }
	
        /**
         *  Creates a new mather. What a silly name.
         */
        public function HexGridMather(radius:Number, widthInPixels:Number, heightInPixels:Number) {

            _hexProperties = HexGeometricProperties.getByRadius(radius);

            _absMinXIndex = 0;
            _absMinYIndex = 0;
            _absMaxXIndex = Math.ceil(widthInPixels / hexProperties.interleavedHorizontalDistance);
            _absMaxYIndex = Math.ceil(heightInPixels / hexProperties.interleavedVerticalDistance);
        }

        /**
         *  Converts from world/pixel space to grid indices, rounding down.
         */
        public function lowerXIndex(x:Number):int {

            return Math.max(absMinXIndex, Math.floor(x / hexProperties.interleavedHorizontalDistance));
        }

        /**
         *  Converts from world/pixel space to grid indices, rounding down.
         */
        public function lowerYIndex(y:Number):int {

            return Math.max(absMinYIndex, Math.floor(y / hexProperties.interleavedVerticalDistance));
        }

        /**
         *  Converts from world/pixel space to grid indices, rounding up.
         */
        public function upperXIndex(x:Number):int {

            return Math.min(absMaxXIndex, Math.ceil(x / hexProperties.interleavedHorizontalDistance));
        }
        
         /**
         *  Converts from world/pixel space to grid indices, rounding up.
         */
       public function upperYIndex(y:Number):int {

            return Math.min(absMaxYIndex, Math.ceil(y / hexProperties.interleavedVerticalDistance));
        }

        /**
         *  Translates indices in the grid to coordinates in world space.
         */
        public function positionByIndices(xIndex:int, yIndex:int):Point {

            var x:Number;
            var y:Number;
            
            // Now here's where we're going to introduce some magic.
            // In even columns (0, 2, etc.), we're dealing with even rows (0, 2, etc.)
            // In odd columns (1, 3, etc.), we're dealing with odd columns (1, 3, etc.)
            // So, when we actually add a hex, we need to treat the two column types differently.
            // I ain't even gunna justify the math tho. Draw it out.
            
            // even columns
            if (xIndex % 2 == 0) {
            
                    x = (xIndex / 2) * hexProperties.horizontalDistance;
                    y = (yIndex / 2) * hexProperties.verticalHeight;						
            }
            
            // odd columns
            else {
            
                    x = Math.floor(xIndex / 2) * hexProperties.horizontalDistance + hexProperties.interleavedHorizontalDistance;
                    y = Math.floor(yIndex / 2) * hexProperties.verticalHeight + hexProperties.verticalHeight/2;
            }

            return new Point(x, y);
        }
    }
}
