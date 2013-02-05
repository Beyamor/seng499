package hex 
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
        import flash.geom.Point;

	/**
	 * This represents a grid of hexagon tiles.
	 * @author beyamor
	 */
	public class HexGrid 
	{
		// That grid, baby
                private var tiles:Object = new Object;

                // Dat world
                private var _world:World;
                private function get world():World { return _world; }
		
		// Properties!
		private var _hexProperties:HexGeometricProperties;
		private function get hexProperties():HexGeometricProperties { return _hexProperties; }
		
		/**
		 * Creates a new hex grid.
		 * The hex grid builds enough hexagons to fill the given dimensions.
		 */
		public function HexGrid(world:World, hexagonRadius:Number)
		{
                        _world = world;
			_hexProperties	= new HexGeometricProperties(hexagonRadius);

                        fillView();
		}
		
                /**
                 *  Checks if the index pair is valid.
                 *  i.e., they must both be even or odd
                 */
                private function validIndices(xIndex:int, yIndex:int):Boolean {

                    return (Math.abs(xIndex) % 2) == (Math.abs(yIndex) % 2);
                }

                /**
                 * Checks if a tile already exists in the grid at the given indices.
                 */
                private function tileExists(xIndex:int, yIndex:int):Boolean {

                    if (!tiles.hasOwnProperty(xIndex))          return false;
                    if (!tiles[xIndex].hasOwnProperty(yIndex))  return false;
                    return (tiles[xIndex][yIndex] != null);
                }

                /**
                 *  Translates indices in the grid to coordinates in world space.
                 */
                private function positionByIndices(xIndex:int, yIndex:int):Point {

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

                /**
                 *  Adds a created tile to the grid.
                 */
                private function addToGrid(xIndex:int, yIndex:int, tile:HexTile):void {

                    if (!tiles.hasOwnProperty(xIndex)) tiles[xIndex] = new Object;

                    tiles[xIndex][yIndex] = tile;
                }

                /**
                 *  If the tile doesn't already exist, this:
                 *      - creates it 
                 *      - adds it to the world
                *       - adds it to the grid
                 */
                private function createIfNecessary(xIndex:int, yIndex:int):void {

                    if (tileExists(xIndex, yIndex)) return;

                    var pos:Point = positionByIndices(xIndex, yIndex);
                    var tile:HexTile = new HexTile(pos.x, pos.y, hexProperties.radius);

                    world.add(tile);
                    addToGrid(xIndex, yIndex, tile);

                    // Comment in to log indices of last created tile
                    //FP.console.log("Creating at " + xIndex + ", " + yIndex);
                }

                /**
                 *  Ensures the view space is covered by tiles.
                 */
                public function fillView():void {

                    var minX:Number, maxX:Number,
                        minY:Number, maxY:Number;

                    minX = FP.camera.x;
                    maxX = FP.camera.x + FP.width;
                    minY = FP.camera.y;
                    maxY = FP.camera.y + FP.height;

                    var minXIndex:int, maxXIndex:int,
                        minYIndex:int, maxYIndex:int;

                    minXIndex = Math.floor(minX / hexProperties.interleavedHorizontalDistance);
                    minYIndex = Math.floor(minY / hexProperties.interleavedVerticalDistance);

                    maxXIndex = Math.ceil(maxX / hexProperties.interleavedHorizontalDistance);
                    maxYIndex = Math.ceil(maxY / hexProperties.interleavedVerticalDistance);

                    for (var xIndex:int = minXIndex; xIndex <= maxXIndex; ++xIndex) {
                        for (var yIndex:int = minYIndex; yIndex <= maxYIndex; ++yIndex) {

                            if (validIndices(xIndex, yIndex)) {

                                createIfNecessary(xIndex, yIndex);
                            }
                        }
                    }
                }
	}

}
