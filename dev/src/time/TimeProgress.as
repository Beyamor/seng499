package time 
{
	import model.PlayerData;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	/**
	 * Makes time change.
	 * Includes time padding before and after the change.
	 * Register callbacks for onChange and onFinished.
	 * @author beyamor
	 */
	public class TimeProgress 
	{
		public static const DEFAULT_DELAY:Number = 1;
		
		private var changeAlarm:Alarm;
		private var finishedAlarm:Alarm;
		private var onChangeCallbacks:Vector.<Function> = new Vector.<Function>;
		private var onFinishedCallbacks:Vector.<Function> = new Vector.<Function>;
		
		public function TimeProgress(
			world:World,
			calendar:Calendar,
			changeDelayInSeconds:Number = DEFAULT_DELAY,
			finishedDelayInSeconds:Number=DEFAULT_DELAY)
		{
			changeAlarm = new Alarm(changeDelayInSeconds, function():void {
				
				calendar.goToNextSeason();
				for each (var callback:Function in onChangeCallbacks) callback();
				finishedAlarm.start();
			});
			
			finishedAlarm = new Alarm(finishedDelayInSeconds, function():void {
				
				for each (var callback:Function in onFinishedCallbacks) callback();
			});
			
			world.addTween(changeAlarm);
			world.addTween(finishedAlarm);
		}
		
		public function start():TimeProgress {
			
			changeAlarm.start();
			return this;
		}
		
		public function addOnChangeCallback(callback:Function):TimeProgress {
			
			onChangeCallbacks.push(callback);
			return this;
		}
		
		public function addOnFinishedCallback(callback:Function):TimeProgress {
			
			onFinishedCallbacks.push(callback);
			return this;
		}
	}

}