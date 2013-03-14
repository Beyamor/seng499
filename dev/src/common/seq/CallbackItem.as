package common.seq 
{
	/**
	 * ...
	 * @author beyamor
	 */
	public class CallbackItem implements SequencerItem 
	{
		private var callback:Function;
		
		public function CallbackItem(callback:Function)
		{
			this.callback = callback;
		}
		
		public function update():void {
			
			callback();
		}
		
		public function get isFinished():Boolean {
			
			return true;
		}
	}

}