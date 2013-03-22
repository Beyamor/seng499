package hex 
{
	import flash.display.BitmapData;
	import flash.geom.Vector3D;
	import hex.entities.HexComponentEntity;
	import hex.entities.HexInstrumentImage;
	import hex.entities.HexNodeImage;
	import hex.HexSubhitbox;
	import hex.terrain.Terrain;
	import map.NodeEntity;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import flash.geom.Point;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import flash.utils.getTimer;
	import net.flashpunk.World;
	import observatory.Node;
	import observatory.ObservatoryComponent;
	import hex.terrain.Tables;
	import common.Assets;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Graphiclist;
	
	/**
	 * So, a hex (HexTile) is sort of the atom of the hex-based game view.
	 * It represents a single unit of space in the world.
	 * @author beyamor
	 */
	public class HexTile extends Entity 
	{
		//wether tile has been discovered
		private var _discovered:Boolean;
		public function get discovered():Boolean { return _discovered; }
		
		//wether something was recently changed
		public var changed:Boolean = false;
		
		// Data!
		private var _data:HexData;
		public function get data():HexData { return _data; }
		
		private var _hexSubEntities:Vector.<HexComponentEntity>;
		public function get hexSubEntities():Vector.<HexComponentEntity> { return _hexSubEntities; } 

		// The radius of the hexgon.
		private var _radius:Number;
		private function get radius():Number { return _radius; }

		// The indices in the grid
		private var _indices:HexIndices;
		public function get indices():HexIndices { return _indices; }
		
		// Da camera
		private var _camera:Point;
		private function get camera():Point { return _camera; }

		/**
		 * Creates a new hex tile.
		 */
		public function HexTile(camera:Point, data:HexData, indices:HexIndices, x:Number, y:Number, radius:Number)
		{
			super(x, y);

			_data		= data;
			_discovered = data.discovered;
			_indices	= indices;
			_radius		= radius;
			_camera		= camera;

			var graphics:Graphiclist = new Graphiclist;
			graphics.add(new HexSprite(radius, data.terrain));

			var subImage:HexSubhitbox;
			var image:Image;
			_hexSubEntities = new Vector.<HexComponentEntity>;
			
			for (var i:int = 0; i < data.observatoryComponents.length; i++)
			{
				if( data.observatoryComponents[i] is Node)
				{
					var nodeEnt:HexNodeImage = new HexNodeImage(data.observatoryComponents[i],
																x - data.observatoryComponents[i].getImage().width / 2,
																y - data.observatoryComponents[i].getImage().height / 2);
					_hexSubEntities.push(nodeEnt);
					break;
				}
				else if (data.observatoryComponents[i].isSeenFromHexGrid())
				{
					var instEnt:HexInstrumentImage;
					if (i == 0)
					{
						instEnt = new HexInstrumentImage(data.observatoryComponents[i],
														x - data.observatoryComponents[i].getImage().width - 5,
														y - data.observatoryComponents[i].getImage().height - 5);
						_hexSubEntities.push(instEnt);
					}
					else if(i == 1)
					{
						instEnt = new HexInstrumentImage(data.observatoryComponents[i], 5, 5);
						_hexSubEntities.push(instEnt);
					}
				}
			}
				
			graphic = graphics;
			layer = 3;
		}

		public function addImageEntities(world:World):void
		{
			for each(var image:HexComponentEntity in _hexSubEntities)
			{
				world.add(image);
			}
		}
		
		/**
		 * Checks if the hex is onscreen.
		 */
		override public function get onCamera():Boolean 
		{			
			return collideRect(
				x, y,
				camera.x	- radius,
				camera.y	- radius,
				FP.width	+ radius * 2,
				FP.height	+ radius * 2);
		}
		
		/**
		 * Check if a point is contained inside the hex's area.
		 * @param	x - The x coordinate of the point.
		 * @param	y - The y coordinate of the point.
		 */
		public function containsPoint(x:Number, y:Number):Boolean {
			
			// very rough check
			if (!onCamera) return false;
			
			// Playchilla has a neat way of doing this, so we'll mostly steal it
			// http://www.playchilla.com/how-to-check-if-a-point-is-inside-a-hexagon
			// However, for some reason, that example only includes one of the dot products we need.
			// Whatever?
			// Anyway, it's basically a standard "point-inside-convex-polygon" deal,
			// but taking advantage of the hexagon's symmetry
			
			// First, get the relative vector from the center of the hexagon
			const relX:Number = x - this.x;
			const relY:Number = y - this.y;
			
			FP.log(relX + ", " + relY);
			
			// Now, so we only have to check one case
			// (as opposed to each combination of positive and negative x and y),
			// we consider the absolute relatives
			const absRelX:Number = Math.abs(relX);
			const absRelY:Number = Math.abs(relY);
			
			// Okay. Cool. That's got us in a good place.
			// Now, we're going to consider that point relative to the corner of the hexagon.
			// With a vector from the corner to the point we're checking,
			// we can perform dot products against the inwards-facing normals of the hexagon's edges.
			// If the dot products are positive, then the point lies inward with respect to the edge.
			// Cool?
			
			// Okay. Let's get that corner point.
			// Seriously, this triangle.
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
			var cornerPoint:Point = new Point(
									0.5 * radius,
									0.5 * Math.sqrt(3) * radius);
			
			// Let's get that point.
			var vectorFromCorner:Vector3D = new Vector3D(
									absRelX - cornerPoint.x,
									absRelY - cornerPoint.y);
			
			// Now, assuming our vector lies with the axis-parallel edge parallel to the x-axis
			// e.g.,    ----
			//        /      \
			//        \      /
			//          ----
			//  ^ y
			//  |
			//  +--> x
			//
			// The first of these normals is pretty simple. It point from the top edge down.
			var normal1:Vector3D	= new Vector3D(0, -1);
			var dotProduct1:Number	= normal1.dotProduct(vectorFromCorner);
			if (dotProduct1 < 0) return false;
			
			// The second of these normals is more mathy, but not too bad.
			// The other edge is (0.5r, -0.5sqrt(3)r)
			// The inwards-pointing normal then is (-0.5sqrt(3)r, -0.5r)
			var normal2:Vector3D	= new Vector3D(
											-0.5 * Math.sqrt(3) * radius,
											-0.5 * radius);
			var dotProduct2:Number	= normal2.dotProduct(vectorFromCorner);
			if (dotProduct2 < 0) return false;
			
			return true;
		}
	}

}
