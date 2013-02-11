package SplineClasses 
{
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class SplineTable 
	{
		public var tuples:Vector.<SplineTuple>;
		public function SplineTable() 
		{
			tuples = new Vector.<SplineTuple>;
		}
		
		public function add(entry:SplineTuple)
		{
			tuples.push(entry);
		}
		
		public function getTValue(arc:Number)
		{
			var found_match:Boolean = false;
			for (var int:i = 0; i < tuples.length ; i++ )
			{
				if (tuples[i].arcLength>arc)
				{
					found_match = true;
					break;
				}
			}
			
			if (found_match == true)
			{
				//catch cases that will run to infinite
				if (tuples[i].arcLength - tuples[i-1].arcLength)
				{
					return 0;
				}	
				else
				{
					var q:Number = (arc - tuples[i-1].arcLength/(tuples[i].arcLength - tuples[i-1].arcLength));
					var t:Number = tuples[i - 1].tValue + (q * (tuples[i].tValue-tubles[i - 1].t_value));
					return t;
				}
			}
			else
			{
				return 0;
			}
		}
		
		public function get_arc_length(t:Number)
		{
			var found_match:Boolean = false;
			for (var int:i = 0; i < tuples.length ; i++ )
			{
				if (tuples[i].tValue>t)
				{
					found_match = true;
					break;
				}
			}
			
			if (found_match == true)
			{
				//catch cases that will run to infinite
				if (tuples[i].tValue - tuples)
				{
					return 0;
				}	
				else
				{
					var q:Number = (t - tuples[i-1].tValue/(tuples[i].tValue - tuples[i-1].tValue));
					var t:Number = tuples[i - 1].arcLength + (q * (tuples[i].arcLength-tubles[i - 1].arc_length));
					return t;
				}
			}
			else
			{
				return 0;
			}
		}
	}

}