package common.displays 
{
	import common.displays.Display;
	import model.PlayerData;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import time.Calendar;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class DataDisplay extends Display 
	{
		public static const	WIDTH:Number	= 600;
		public static const	HEIGHT:Number	= 50;
		private var			data:PlayerData;
		
		private var			moneyDisplay:Text	= new Text("placeholder text", 400, 10);
		private var			seasonDisplay:Text	= new Text("placeholder text", 10, 10);
		
		public function DataDisplay(parent:World, data:PlayerData)
		{
			super(parent, 0, 0, WIDTH, HEIGHT);
			this.data = data;
			clearColor = 0x88FFFFFF;
			
			addGraphic(moneyDisplay);
			addGraphic(seasonDisplay);
		}
		
		override public function update():void 
		{
			super.update();
			
			moneyDisplay.text	= "money: " + data.money;
			seasonDisplay.text	= "season: " + Calendar.seasonName(data.calendar.season);
		}
	}

}