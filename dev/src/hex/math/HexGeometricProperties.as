package hex.math
{
	/**
	 * This guy's just represents a bunch of mathematical properties
	 * of a hexagon. These properties are based off of the radius of
	 * a single hexagon.
	 * @author beyamor
	 */
	public class HexGeometricProperties 
	{
                // Geometric properties for different radii.
                private static var propertiesByRadius:Object = new Object;
                public static function getByRadius(radius:Number):HexGeometricProperties {

                    if (!propertiesByRadius[radius]) propertiesByRadius[radius] = new HexGeometricProperties(radius);
                    return propertiesByRadius[radius];
                }

		// The radius of our subject hexagon.
		private var _radius:Number;
		public function get radius():Number { return _radius; }
		
		// Properties of this thing
		private var _horizontalOverlap:Number;
		public function get horizontalOverlap():Number { return _horizontalOverlap; }
		
		private var _interleavedHorizontalDistance:Number;
		public function get interleavedHorizontalDistance():Number { return _interleavedHorizontalDistance; }
                
                private var _interleavedVerticalDistance:Number;
                public function get interleavedVerticalDistance():Number { return _interleavedVerticalDistance; }
		

		private var _horizontalDistance:Number;
		public function get horizontalDistance():Number { return _horizontalDistance; }
		
		private var _verticalHeight:Number;
		public function get verticalHeight():Number { return _verticalHeight; }
		
		/**
		 * Creates a new HexGeometricProperties instance. 
		 * @param	radius - The radius which the properties are based on.
		 */
		public function HexGeometricProperties(radius:Number)
		{
			_radius = radius;
			
			// Okay. Math. Math is hard.
			// We're going to ultimately store everything in a (sparse) 2d array of hexagons.
			// Uh. Like,
			// -----------------
			// | 1 | - | 2 | - |
			// | - | 3 | - | 4 |
			// | 5 | - | 6 | - |
			// | - | 7 | - | 8 |
			// -----------------
			// Hexes are vertically adjacent in column
			// and diagonally adjacent between columns.
			// e.g., with respect to "6":
			//			"2" is above
			//			"3" is to the upper-left
			//			"4" is to the upper-right
			//			"7" is to the lower-left
			//			and "8" is to the lower-right

			// Remember this triangle becase it's going to come in handy.
			//       |\
			//       | \
			//       |30\
			// ½√3*r |   \  r
			//       |    \
			//       |     \
			//       |      \
			//       |90   60\
			//       ----------
			//          ½r

			//Okay. Let's name a few values here.

			// An important propery when looking at horizontal texes is the overlap.
			// So, with hexes stacked like this:
			//  
			//   -------
			//  /       \         /
			// /         \       /
			//   |- 2r -| -------
			// \         /       \
			//  \       /         \
			//   -------  |- 2r -|
			//  /       \         /
			// /         \       /
			//
			// The hexes have overlapping x values.
			// We can get this value from our handy triangle.
			_horizontalOverlap = 0.5 * radius;

			// We can also look at horizontal distance between the centers
			// of hexes. This has two meanings. The first is the "interleaved"
			// distance - the horizontal distance btween two diagonally adjacent
			// hexes.
			_interleavedHorizontalDistance = 2 * radius - horizontalOverlap;

                        // Similarly, the interleaved vertical distance.
                        _interleavedVerticalDistance = 0.5 * Math.sqrt(3) * radius;

			// The second is the horizontal distance between two hexes in the same row.
			// e.g, the distance between A and B
			//   -------           -------
			//  /       \         /        \
			// /         \       /          \
			//      A     -------      B
			// \         /       \          /
			//  \       /         \        /
			//   -------            -------
			_horizontalDistance = 2 * radius + (2 * radius - 2 * horizontalOverlap);

			// Also nice to have is the vertical height of a hex.
			// i.e., ½√3*r * 2
			_verticalHeight = Math.sqrt(3) * radius;
		}
	}

}
