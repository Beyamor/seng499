package hex 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	/**
	 * So, a hex (HexTile) is sort of the atom of the hex-based game view.
	 * It represents a single unit of space in the world.
	 * @author beyamor
	 */
	public class HexTile extends Entity 
	{
		// The radius of the hexgon.
		private var _radius:Number;
		private function get radius():Number { return _radius; }

		// This hex's color. Probably a temporary feature.
		private var _color:uint;
		private function get color():uint { return _color; }

		// The list of this hex's vertices
		private var _vertices:Vector.<Point>;
		private function get vertices():Vector.<Point> { return _vertices; }

		/**
		 * Creates a new hex tile.
		 * @param	x - The x position of the hex in the world.
		 * @param	y - The y position of the hex in the world.
		 * @param	radius - The distane from the center of the hex to one of its vertices.
		 */
		public function HexTile(x:Number, y:Number, radius:Number)
		{
			super(x, y);

			_radius = radius;
			_color = FP.rand(0xFFFFFF);

			buildVertexList();
		}

		/**
		 * Builds the list of vertices.
		 */
		private function buildVertexList():void {

			var theta:Number;
			_vertices = new Vector.<Point>;

			for (var pointIndex:uint = 0; pointIndex < 6; ++pointIndex) {

				theta = pointIndex * (Math.PI * 2 / 6);

				_vertices.push(new Point(
							x + radius * Math.cos(theta),
							y + radius * Math.sin(theta)));
			}
		}

		/**
		 * Checks if the hex is onscreen.
		 */
		override public function get onCamera():Boolean 
		{
			var threshold:Number = 2 * radius;
			
			return collideRect(
				x, y,
				FP.camera.x	- threshold,
				FP.camera.y	- threshold,
				FP.width	+ threshold,
				FP.height	+ threshold);
		}
		
		/**
		 * Renders the hex.
		 * Right now, this is done with primities.
		 * At some point, it should probably be sprite-based.
		 */
		override public function render():void 
		{
			if (!onCamera) return;

			var firstPoint:Point;
			var secondPoint:Point;
			var pointIndex:uint;

			for (pointIndex = 0; pointIndex < vertices.length; ++pointIndex) {

				firstPoint = vertices[pointIndex];
				secondPoint = vertices[(pointIndex + 1) % vertices.length];

				Draw.linePlus(firstPoint.x, firstPoint.y, secondPoint.x, secondPoint.y, 0x000000, 1, 2);
			}

			Draw.circlePlus(x, y, radius * 0.8, color);
		}
	}

}