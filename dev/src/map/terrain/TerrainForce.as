package map.terrain 
{
	import flash.geom.Point;
	import hex.HexIndices;
	import hex.terrain.Terrain;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class TerrainForce 
	{
		private var direction:int;
		private var terrain:Terrain;
		//private var rootHex:HexIndices;
		private var spread:int;
		private var decay:int;
		private var force:int;
		private var _alreadyPropegated:Boolean = false;
		public function get alreadyPropegated():Boolean { return _alreadyPropegated; }
		
		//Don't worry Tom, I'm planning a fluent constructor for this later.  This is just a stand in.
		public function TerrainForce(terrain:Terrain, direction:int, /*root:HexIndices,*/ force:int, spread:int, decay:int) 
		{
			this.terrain = terrain;
			this.direction = direction;
			//this.rootHex = root;
			this.spread = spread;
			this.decay = decay;
			this.force = force;
		}	
		
		//called when a terrain force is going to create a child.
		public function propegate(forceData:Vector.<Vector.<Vector.<TerrainForce> > >,indecies:HexIndices):void
		{
			if (force > 0)
			{
				var newTargets:Vector.<HexIndices> = getPropegationList(indecies);
				
				//replace with use of fluent constructor?
				var childForce:TerrainForce = new TerrainForce(terrain,direction,force-decay,spread,decay);
				
				for each (var target:HexIndices in newTargets)
				{
					forceData[target.x][target.y].push(childForce);
				}
			}
		}
		
		//I need to think more about how these will work with our system.
		/*public function inSpread(indecies:HexIndices):Boolean
		{
			var angle:int  = Math.atan2(indecies.y-rootHex.y,indecies.x-rootHex.x) * 180 / Math.PI;
			translate
			return false;
		}*/
		
		//Caculates whether a given hex is in range
		public function getPropegationList(indecies:HexIndices):Vector.<HexIndices>
		{
			var hexes:Vector.<HexIndices> = new Vector.<HexIndices>;
			switch(direction)
			{
				case 0:
					hexes.push(indecies.northEast);
					hexes.push(indecies.southEast);
					break;
				case 30:
					hexes.push(indecies.northEast);
					break;
				case 60:
					hexes.push(indecies.north);
					hexes.push(indecies.northEast);
					break;
				case 90:
					hexes.push(indecies.north);
					break;
				case 120:
					hexes.push(indecies.north);
					hexes.push(indecies.northWest);
					break;
				case 150:
					hexes.push(indecies.northWest);
					break;
				case 180:
					hexes.push(indecies.northWest);
					hexes.push(indecies.southWest);
					break;
				case 210:
					hexes.push(indecies.southWest);
					break;
				case 240:
					hexes.push(indecies.south);
					hexes.push(indecies.southWest);
					break;
				case 270:
					hexes.push(indecies.south);
					break;
				case 300:
					hexes.push(indecies.south);
					hexes.push(indecies.southEast);
					break;
				case 330:
					hexes.push(indecies.southEast);
					break;
				case 360://duplicate case, but just in case it isn't caught.
					hexes.push(indecies.northEast);
					hexes.push(indecies.southEast);
					break;
				default:
			}
			return hexes;
		}
	}
}