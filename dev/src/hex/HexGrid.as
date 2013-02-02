package hex 
{
	/**
	 * This represents a grid of hexagon tiles.
	 * @author beyamor
	 */
	public class HexGrid 
	{
		// Dimensions in pixels
		private var _widthInPixels:uint;
		private function get widthInPixels():uint { return _widthInPixels; }
		private var _heightInPixels:uint;
		private function get heightInPixels():uint { return _heightInPixels; }
		
		// Dimensions in terms of the hex tiles
		private var _width:uint;
		private function get width():uint { return _width; }
		private var _height:uint;
		private function get height():uint { return _height; }
		
		// That grid, baby
		private var tiles:Vector.<Vector.<HexTile>>;
		
		// Properties!
		private var _hexProperties:HexGeometricProperties;
		private function get hexProperties():HexGeometricProperties { return _hexProperties; }
		
		/**
		 * Creates a new hex grid.
		 * The hex grid builds enough hexagons to fill the given dimensions.
		 * @param	widthInPixels	- The width of the grid in pixels.
		 * @param	heightInPixels	- The height of the grid in pixels.
		 * @param	hexagonRadius	- The radius of the hexagons.
		 */
		public function HexGrid(widthInPixels:uint, heightInPixels:uint, hexagonRadius:Number)
		{
			_widthInPixels	= widthInPixels;
			_heightInPixels	= heightInPixels;
			_hexProperties	= new HexGeometricProperties(hexagonRadius);
			
			prepGrid();
			build();
		}
		
		/**
		 * Sets up the datastructure in which the hexagons are stored.
		 */
		private function prepGrid():void {
			
			// The width then is how many interleaved distances can fit in the space
			_width = Math.ceil(widthInPixels / hexProperties.interleavedHorizontalDistance);

			// The height is how many heights can fit in the space,
			// times two for the sparse array
			_height = Math.ceil(heightInPixels / hexProperties.verticalHeight) * 2;
			
			// Nice. Nice. Let's just create the (empty) entire array now.
			tiles = new Vector.<Vector.<HexTile>>;
			for (var tileX:uint = 0; tileX < width; ++tileX) {
				
				tiles.push(new Vector.<HexTile>);
				for (var tileY:uint = 0; tileY < height; ++tileY) {
					
					tiles[tileX][tileY] = null;
				}
			}
		}
		
		/**
		 * Contructs the hexagons in the grid.
		 * NB: there's a good chance we'll need to do this lazily instead.
		 */
		private function build():void {
			
			var x:Number;
			var y:Number;
			
			// Now here's where we're going to introduce some magic.
			// In even columns (0, 2, etc.), we're dealing with even rows (0, 2, etc.)
			// In odd columns (1, 3, etc.), we're dealing with odd columns (1, 3, etc.)
			// So, when we actually add a hex, we need to treat the two column types differently.
			// I ain't even gunna justify the math tho. Draw it out.
			for (var tileX:uint = 0; tileX < width; ++tileX) {
				for (var tileY:uint = 0; tileY < height; ++tileY) {

					if (tileX % 2 != tileY % 2) continue;

					// even columns
					if (tileX % 2 == 0) {

						x = (tileX / 2) * hexProperties.horizontalDistance;
						y = (tileY / 2) * hexProperties.verticalHeight;						
					}

					// odd columns
					else {

						x = Math.floor(tileX / 2) * hexProperties.horizontalDistance + hexProperties.interleavedHorizontalDistance;
						y = Math.floor(tileY / 2) * hexProperties.verticalHeight + hexProperties.verticalHeight/2;
					}

					tiles[tileX][tileY] = new HexTile(
											x,
											y,
											hexProperties.radius);
				}				
			}
		}
		
		/**
		 * Gets all of the tiles in this grid.
		 */
		public function get allTiles():Vector.<HexTile> {
			
			var allTiles:Vector.<HexTile> = new Vector.<HexTile>;
			
			for (var tileX:uint = 0; tileX < width; ++tileX) {
				for (var tileY:uint = 0; tileY < height; ++tileY) {
					
					if (tiles[tileX][tileY] != null) allTiles.push(tiles[tileX][tileY]);
				}
			}
			
			return allTiles;
		}
	}

}