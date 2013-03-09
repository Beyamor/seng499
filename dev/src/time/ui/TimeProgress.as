package time.ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
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
		
		public function TimeProgress(x:Number, y:Number, calendar:Calendar)
		{
			this.calendar = calendar;
			
			seasonDisplay	= new Text("Season: "	+ calendar.season);
			yearDisplay		= new Text("Year: "		+ calendar.year);
			
			yearDisplay.y = seasonDisplay.height + 3;
			
			super(x, y, new Graphiclist(seasonDisplay, yearDisplay));
		}
	}

}