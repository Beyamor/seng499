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
		
		public function get_t_value(arc:Number)
		{
			var found_match:Boolean = false;
			for (var int:i = 0; i < tuples.length ; i++ )
			{
				if (tuples[i].arc_length>arc)
				{
					found_match = true;
					break;
				}
			}
			
			if (found_match == true)
			{
				//catch cases that will run to infinite
				if (tuples[i].arc_length - tuples[i-1].arc_length)
				{
					return 0;
				}	
				else
				{
					var q:Number = (arc - tuples[i-1].arc_length/(tuples[i].arc_length - tuples[i-1].arc_length));
					var t:Number = tuples[i - 1].t_value + (q * (tuples[i].t_value-tubles[i - 1].t_value));
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
				if (tuples[i].t_value>t)
				{
					found_match = true;
					break;
				}
			}
			
			if (found_match == true)
			{
				//catch cases that will run to infinite
				if (tuples[i].t_value - tuples)
				{
					return 0;
				}	
				else
				{
					var q:Number = (t - tuples[i-1].t_value/(tuples[i].t_value - tuples[i-1].t_value));
					var t:Number = tuples[i - 1].arc_length + (q * (tuples[i].arc_length-tubles[i - 1].arc_length));
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