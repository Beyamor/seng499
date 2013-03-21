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
		private var _terrain:Terrain;
		public function get terrain():Terrain { return _terrain; }
		private var spread:int;
		private var force:int;
		private var _alreadyPropegated:Boolean = false;
		public function get alreadyPropegated():Boolean { return _alreadyPropegated; }
		
		//Don't worry Tom, I'm planning a fluent constructor for this later.  This is just a stand in.
		public function TerrainForce(terrain:Terrain, direction:int, force:int, spread:int) 
		{
			this._terrain = terrain;
			this.direction = direction;
			this.spread = spread;
			this.force = force;
		}	
		
		//called when a terrain force is going to create a child.
		public function propegate(forceData:Object/*Vector.<Vector.<Vector.<TerrainForce> > >*/,indecies:HexIndices):void
		{
			if (force > 0)
			{
				var newTargets:Vector.<HexIndices> = getPropegationList(indecies);
				
				//replace with use of fluent constructor?
				var childForce:TerrainForce = new TerrainForce(_terrain,direction,force-1,spread);
				
				for each (var target:HexIndices in newTargets)
				{
					if (!forceData[target.x]) 			forceData[target.x] = new Object;
					if (!forceData[target.x][target.y])	forceData[target.x][target.y] = new Vector.<TerrainForce>
					forceData[target.x][target.y].push(childForce);
				}
			}
		}
		
		//Caculates whether a given hex is in range
		public function getPropegationList(indecies:HexIndices):Vector.<HexIndices>
		{
			var hexes:Vector.<HexIndices> = new Vector.<HexIndices>;
			
			//get the initial spread limits
			var maxClockwise:int = direction - (spread * 30);
			var maxCounterClockwise:int = direction + (spread * 30);
			
			//directions divisible by 60 are on the line rather than the face, 
			//so expand by 30 degrees in each direction to include that face.
			if (maxClockwise % 60 == 0)
			{
				maxClockwise -= 30;
			}
			
			if (maxCounterClockwise % 60 == 0)
			{
				maxCounterClockwise += 30
			}
			
			//gather the applicable directions
			for (var i:int = maxClockwise;  i <= maxCounterClockwise; i += 60 )
			{
				switch(i)
				{
					case 30:
						hexes.push(indecies.northEast);
						break;
					case 90:
						hexes.push(indecies.north);
						break;
					case 150:
						hexes.push(indecies.northWest);
						break;
					case 210:
						hexes.push(indecies.southWest);
						break;
					case 270:
						hexes.push(indecies.south);
						break;
					case 330:
						hexes.push(indecies.southEast);
						break;
					default:
				}
			}
			
			
			return hexes;
		}
	}
}