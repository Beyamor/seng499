package SplineClasses 
{
	/**
	 * ...
	 * @author Lambwatt
	 */
	public class SplineTable 
	{
		var tuples:Vector.<SplineTuple>;
		public function SplineTable() 
		{
			tuples = new Vector.<SplineTuple>;
		}
		
		public function add(entry:SplineTuple)
		{
			tuples.push(entry);
		}
		
		public function get_arc_length()
		{
		}
	}

}