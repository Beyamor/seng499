package store 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import common.ui.Button;
	/**
	 * ...
	 * TODO: Where does it pull my author name from? Coolton is cheeky, though.
	 * @author coolton
	 */
	
	 
	public class StoreView extends World
	{
	
		[Embed(source="/assets/store/back.png")]
            private const BACK:Class;
		
		[Embed(source="/assets/store/bg.png")]
            private const BG:Class;	
		
		[Embed(source="/assets/store/buy.png")]
            private const BUY:Class;
			
		[Embed(source="/assets/store/instrument_image.png")]
            private const INSTRUMENT_ITEM:Class;
			
		[Embed(source="/assets/store/left.png")]
            private const LEFT:Class;
			
		[Embed(source="/assets/store/right.png")]
            private const RIGHT:Class;
		 	
		public function StoreView() 
		{
			addStoreButtons();
			
		}
		
		private function addStoreButtons():void
		{
			add(Button.description()
						.at(0, FP.height - 100)
						.withDepth(-1)
						.withImage(new Image(LEFT))
						.whenClicked(function():void {

							FP.console.log("clicked left");
						})
						.build());	
						
						
			add(Button.description()
						.at(200, FP.height - 100)
						.withDepth(-1)
						.withImage(new Image(BACK))
						.whenClicked(function():void {

							FP.console.log("clicked back");
						})
						.build());	
						
						
			add(Button.description()
						.at(400, FP.height - 100)
						.withDepth(-1)
						.withImage(new Image(BUY))
						.whenClicked(function():void {

							FP.console.log("clicked buy");
						})
						.build());	
						
						
			add(Button.description()
						.at(600, FP.height - 100)
						.withDepth(-1)
						.withImage(new Image(RIGHT))
						.whenClicked(function():void {

							FP.console.log("clicked right");
						})
						.build());	
						
						
			add(Button.description()
						.at(50, 30)
						.withDepth(-1)
						.withImage(new Image(INSTRUMENT_ITEM))
						.whenClicked(function():void {

							FP.console.log("clicked instrument");
						})
						.build());	
		}
		
		override public function update():void 
		{
			super.update();
		}
		
	}
}