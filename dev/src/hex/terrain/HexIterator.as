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
		private var radius:int;
		private var ringCount:int = 0;
		private var sequenceStep:int = 0;
		private var stepCounter:int = 0;
		private var directionSequence:Vector.<Function> = new Vector.<Function>;
		
		public function HexIterator(currHex:HexIndices, radius:int) 
		{
			directionSequence[0] = function(indecies:HexIndices) { return indecies.north };
			directionSequence[1] = function(indecies:HexIndices) { return indecies.southEast };
			directionSequence[2] = function(indecies:HexIndices) { return indecies.south };
			directionSequence[3] = function(indecies:HexIndices) { return indecies.southWest };
			directionSequence[4] = function(indecies:HexIndices) { return indecies.northWest };
			directionSequence[5] = function(indecies:HexIndices) { return indecies.north; };
			directionSequence[6] = function(indecies:HexIndices) { return indecies.northEast };
		
			this.currHex = currHex;
			this.radius = radius;
		}
		
		public function step():HexIndices
		{
			if (ringCount > radius)
			{
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
	}

}