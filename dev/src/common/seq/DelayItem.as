package common.seq 
{
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author beyamor
	 */
	public class DelayItem implements SequencerItem 
	{
		private var duration:Number;
		private var elapsed:Number = 0;
		
		public function DelayItem(durationInSeconds:Number) 
		{
			duration = durationInSeconds;
		}
		
		public function update():void {
			
			elapsed += FP.elapsed;
		}
		
		public function get isFinished():Boolean {
			
			return elapsed >= duration;
		}
	}

}