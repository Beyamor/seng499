package time.ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.Alarm;
	import time.Calendar;
	
	/**
	 * Displays the change in time for a calendar.
	 * @author beyamor
	 */
	public class TimeProgressWidget extends Entity 
	{
		private var calendar:Calendar;
		private var seasonDisplay:Text;
		private var yearDisplay:Text;
		private var finished:Boolean = false;
		
		public function TimeProgressWidget(x:Number, y:Number, calendar:Calendar)
		{
			this.calendar = calendar;
			
			seasonDisplay	= new Text("obligatory constructor text");
			yearDisplay		= new Text("obligatory constructor text");
			
			yearDisplay.y = seasonDisplay.height + 3;
			updateDisplayText();
			
			super(x, y, new Graphiclist(seasonDisplay, yearDisplay));
		}
		
		public function updateDisplayText():void {
			
			seasonDisplay.text	= "Season: " + calendar.season;
			yearDisplay.text	= "Year: " + calendar.year;
		}
	}

}