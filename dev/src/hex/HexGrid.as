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

                // Math
                private var _gridMather:HexGridMather;
                private function get gridMather():HexGridMather { return _gridMather; }
		
		/**
		 * Creates a new hex grid.
		 * The hex grid builds enough hexagons to fill the given dimensions.
		 */
		public function HexGrid(world:World, hexagonRadius:Number, widthInPixels:Number, heightInPixels:Number)
		{
                        _world = world;
			_hexProperties	= new HexGeometricProperties(hexagonRadius);
                        _gridMather  = new HexGridMather(hexProperties, widthInPixels, heightInPixels);

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

                    var pos:Point = gridMather.positionByIndices(xIndex, yIndex);
                    var tile:HexTile = new HexTile(xIndex, yIndex, pos.x, pos.y, hexProperties.radius);

                    world.add(tile);
                    addToGrid(xIndex, yIndex, tile);

                    // Comment in to log indices of last created tile
                    //FP.console.log("Creating at " + xIndex + ", " + yIndex);
                }

                /**
                 *  Gets the min and max x and y indices of the tiles on screen.
                 */
                private function getIndicesOfViewTiles():Object {

                    var minX:Number, maxX:Number,
                        minY:Number, maxY:Number;

                    minX = FP.camera.x;
                    maxX = FP.camera.x + FP.width;
                    minY = FP.camera.y;
                    maxY = FP.camera.y + FP.height;

                    var minXIndex:int, maxXIndex:int,
                        minYIndex:int, maxYIndex:int;

                    minXIndex = gridMather.lowerXIndex(minX);
                    minYIndex = gridMather.lowerYIndex(minY);
                    maxXIndex = gridMather.upperXIndex(maxX);
                    maxYIndex = gridMather.upperYIndex(maxY);

                    return {
                        minXIndex: gridMather.lowerXIndex(minX),
                        minYIndex: gridMather.lowerYIndex(minY),
                        maxXIndex: gridMather.upperXIndex(maxX),
                        maxYIndex: gridMather.upperYIndex(maxY)
                    };
                }

                /**
                 *  Ensures the view space is covered by tiles.
                 */
                public function fillView():void {

                    var indexBounds:Object = getIndicesOfViewTiles();

                    for (var xIndex:int = indexBounds.minXIndex; xIndex <= indexBounds.maxXIndex; ++xIndex) {
                        for (var yIndex:int = indexBounds.minYIndex; yIndex <= indexBounds.maxYIndex; ++yIndex) {

                            if (validIndices(xIndex, yIndex)) {

                                createIfNecessary(xIndex, yIndex);
                            }
                        }
                    }
                }

                /**
                 *  Gets all of the tiles which are in view.
                 */
                 public function get tilesOnScreen():Vector.<HexTile> {

                    var onscreenTiles:Vector.<HexTile> = new Vector.<HexTile>;

                    var indexBounds:Object = getIndicesOfViewTiles();

                    for (var xIndex:int = indexBounds.minXIndex; xIndex <= indexBounds.maxXIndex; ++xIndex) {
                        for (var yIndex:int = indexBounds.minYIndex; yIndex <= indexBounds.maxYIndex; ++yIndex) {

                            if (tileExists(xIndex, yIndex)) onscreenTiles.push(tiles[xIndex][yIndex]);
                        }
                    }

                    return onscreenTiles;
                 }
	}

}
