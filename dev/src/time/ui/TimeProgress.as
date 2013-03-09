package time.ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.Alarm;
	import time.Calendar;
	
	/**
	 * Displays the change in time for a calendar.
	 * Because I'm a terrible hack (and it's easier than, say, hooking up callbacks or something),
	 * it's also responsible for making the change in time happen.
	 * @author beyamor
	 */
	public class TimeProgress extends Entity 
	{
		private var calendar:Calendar;
		private var seasonDisplay:Text;
		private var yearDisplay:Text;
		private var finished:Boolean = false;
		
		public function TimeProgress(x:Number, y:Number, calendar:Calendar)
		{
			this.calendar = calendar;
			
			seasonDisplay	= new Text("obligatory constructor text");
			yearDisplay		= new Text("obligatory constructor text");
			
			yearDisplay.y = seasonDisplay.height + 3;
			updateDisplayText();
			
			super(x, y, new Graphiclist(seasonDisplay, yearDisplay));
		}
		
		private function updateDisplayText():void {
			
			seasonDisplay.text	= "Season: " + calendar.season;
			yearDisplay.text	= "Year: " + calendar.year;
		}
		
		override public function added():void 
		{
			super.added();
			
			world.addTween(new Alarm(1, function():void {
				
				calendar.goToNextSeason();
				updateDisplayText();
			
			world.addTween(new Alarm(1, function():void {
				
				finished = true;
				
			}), true);
			}), true);
		}
		
		public function get isFinishedProgessing():Boolean {
			
			return finished;
		}
	}

}