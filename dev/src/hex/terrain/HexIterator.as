package hex.terrain 
{
	import hex.HexIndices;
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class HexIterator 
	{
		private var currHex:HexIndices;
		private var _radius:int;
		private var ringCount:int = 0;
		private var sequenceStep:int = 0;
		private var stepCounter:int = 0;
		private var directionSequence:Vector.<Function> = new Vector.<Function>;
		private var done:Boolean = false;
		
		public function get radius():int { return ringCount; }//This is not a typo.  It refers to the active radius, as opposed to the 
		
		public function HexIterator(currHex:HexIndices, radius:int) 
		{
			directionSequence[0] = function(indecies:HexIndices):HexIndices { return indecies.north };
			directionSequence[1] = function(indecies:HexIndices):HexIndices { return indecies.southEast };
			directionSequence[2] = function(indecies:HexIndices):HexIndices { return indecies.south };
			directionSequence[3] = function(indecies:HexIndices):HexIndices { return indecies.southWest };
			directionSequence[4] = function(indecies:HexIndices):HexIndices { return indecies.northWest };
			directionSequence[5] = function(indecies:HexIndices):HexIndices { return indecies.north; };
			directionSequence[6] = function(indecies:HexIndices):HexIndices { return indecies.northEast };
		
			this.currHex = currHex;
			this._radius = radius;
		}
		
		public function step():HexIndices
		{
			if (ringCount > _radius)
			{
				done = true;
				return null;
			}
			
			var result:HexIndices = currHex;
			
			currHex = directionSequence[sequenceStep](currHex);
			
			if (sequenceStep == 0)//finished a ring
			{
				sequenceStep = 1;
				stepCounter = ++ringCount;
				step();
			}
			else 
			{
				stepCounter--;
				if (stepCounter == 0)
				{
					sequenceStep = (sequenceStep+1)%directionSequence.length;
					stepCounter = ringCount;
				}
				
			}
			return result;
		}
		
		public function isDone():Boolean
		{
			return done;
		}
	}

}