package common.seq 
{
	/**
	 * ...
	 * @author beyamor
	 */
	public class DelayedCallback implements SequencerItem 
	{
		private var delay:DelayItem;
		private var callback:CallbackItem;
		
		public function DelayedCallback(delayInSeconds:Number, callback:Function)
		{
			this.delay		= new DelayItem(delayInSeconds);
			this.callback	= new CallbackItem(callback);
		}
		
		public function update():void {
			
			delay.update();
			if (delay.isFinished) callback.update();
		}
		
		public function get isFinished():Boolean {
			
			return delay.isFinished;
		}
		
	}

}