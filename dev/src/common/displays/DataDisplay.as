package common.displays 
{
	import common.displays.Display;
	import data.DataTally;
	import model.PlayerData;
	import net.flashpunk.FP;
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
		private var			playerData:PlayerData;
		
		// Re: the palceholder text: I don't want to specify the actual widths. Ain't nobody got time for that
		private var			moneyDisplay:Text	= new Text("some great placeholder text", 350, 25);
		private var			dataDisplay:Text	= new Text("some placeholder text", 350, 5);
		private var			seasonDisplay:Text	= new Text("some placeholder text", 10, 5);
		private var			yearDisplay:Text	= new Text("some placeholder text", 10, 25);
		
		private var			tallier:DataTally;
		
		public function DataDisplay(parent:World, playerData:PlayerData)
		{
			super(parent, 0, FP.height - HEIGHT, WIDTH, HEIGHT);
			this.playerData = playerData;
			clearColor = 0x88000000;
			tallier = new DataTally(playerData);
			
			addGraphic(moneyDisplay);
			addGraphic(dataDisplay);
			addGraphic(seasonDisplay);
			addGraphic(yearDisplay);
		}
		
		override public function update():void 
		{
			super.update();
			
			moneyDisplay.text	= "Money:\t\t\t\t$" + playerData.money;
			dataDisplay.text	= "Data production:\t" + tallier.baseSum;
			seasonDisplay.text	= "Season:\t" + playerData.calendar.season.name;
			yearDisplay.text	= "Year:\t\t" + playerData.calendar.year;
		}
	}

}