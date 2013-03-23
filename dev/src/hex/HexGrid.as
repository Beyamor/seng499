package hex 
{
	import model.Game;
	import net.flashpunk.World;
	import net.flashpunk.FP;
        import flash.geom.Point;
        import hex.math.*;
        import model.PlayerData;

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
		private var _camera:Point;
		private function get camera():Point { return _camera; }

		// How do we even make a hex tile
		private var _factory:HexFactory;
		private function get factory():HexFactory { return _factory; }

		// Properties!
		private var _hexProperties:HexGeometricProperties;
		private function get hexProperties():HexGeometricProperties { return _hexProperties; }

		// Math
		private var _gridMather:HexGridMather;
		private function get gridMather():HexGridMather { return _gridMather; }
		
		//Game
		private var _game:Game;
		private function get game():Game { return _game; }

		/**
		 * Creates a new hex grid.
		 * The hex grid builds enough hexagons to fill the given dimensions.
		 */
		public function HexGrid(
                    factory:HexFactory,
                    world:World,
					camera:Point,
                    hexagonRadius:Number,
                    widthInPixels:Number,
                    heightInPixels:Number,
					game:Game)
		{
			_camera = camera;
            _factory = factory;
			_world = world;
			_hexProperties	= HexGeometricProperties.getByRadius(hexagonRadius);
			_gridMather  = new HexGridMather(hexagonRadius, widthInPixels, heightInPixels);
			_game = game;

			fillView();
		}

		/**
		 * Checks if a tile already exists in the grid at the given indices.
		 */
		private function tileExists(indices:HexIndices):Boolean {

			if (!tiles[indices.x])              return false;
			if (!tiles[indices.x][indices.y])   return false;

			return (tiles[indices.x][indices.y] != null);
		}
		
		private function tileChanged(indices:HexIndices):Boolean
		{
			return tiles[indices.x][indices.y].changed;
		}

		/**
		 *  Adds a created tile to the grid.
		 */
		private function addToGrid(indices:HexIndices, tile:HexTile):void {

			if (!tiles[indices.x]) tiles[indices.x] = new Object;

			tiles[indices.x][indices.y] = tile;
		}

		/**
		 *  If the tile doesn't already exist, this:
		 *      - creates it 
		 *      - adds it to the world
		*       - adds it to the grid
		 */
		private function createIfNecessary(indices:HexIndices):void {

			if (tileExists(indices)) return;

			var pos:Point = gridMather.positionByIndices(indices);
			var tile:HexTile = factory.create(camera, indices, pos.x, pos.y, hexProperties.radius);
			world.add(tile);
			addToGrid(indices, tile);
		}

		/**
		 *  Gets the min and max x and y indices of the tiles on screen.
		 */
		private function getIndicesOfViewTiles():Object {

			var minX:Number, maxX:Number,
				minY:Number, maxY:Number;

			minX = camera.x;
			maxX = camera.x + FP.width;
			minY = camera.y;
			maxY = camera.y + FP.height;

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

                                        if (HexIndices.areValid(xIndex, yIndex)) {

                                            createIfNecessary(new HexIndices(xIndex, yIndex));
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
                        var indices:HexIndices;

			for (var xIndex:int = indexBounds.minXIndex; xIndex <= indexBounds.maxXIndex; ++xIndex) {
				for (var yIndex:int = indexBounds.minYIndex; yIndex <= indexBounds.maxYIndex; ++yIndex) {

						if (HexIndices.areValid(xIndex, yIndex) && tileExists(new HexIndices(xIndex, yIndex))) {

							onscreenTiles.push(tiles[xIndex][yIndex]);
						}
				}
			}

			return onscreenTiles;
		 }
	}

}
