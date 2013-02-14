package store 
{
	import model.Game;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import common.ui.Button;
	import common.Assets;
	
	/**
	 * ...
	 * TODO: Where does it pull my author name from? Coolton is cheeky, though.
	 * @author coolton
	 */
	
	 
	public class StoreView extends World
	{	
		private var game:Game;
		public function StoreView(game:Game) 
		{
			this.game = game;
			addStoreButtons();
			
		}
		
		private function addStoreButtons():void
		{
			add(Button.description()
						.at(0, FP.height - 100)
						.withDepth(-1)
						.withImage(new Image(Assets.IMG_LEFT))
						.whenClicked(function():void {

							FP.console.log("clicked left");
						})
						.build());	
						
						
			add(Button.description()
						.at(200, FP.height - 100)
						.withDepth(-1)
						.withImage(new Image(Assets.IMG_BACK))
						.whenClicked(function():void {

							FP.console.log("clicked back");
						})
						.build());	
						
						
			add(Button.description()
						.at(400, FP.height - 100)
						.withDepth(-1)
						.withImage(new Image(Assets.IMG_BUY))
						.whenClicked(function():void {

							FP.console.log("clicked buy");
						})
						.build());	
						
						
			add(Button.description()
						.at(600, FP.height - 100)
						.withDepth(-1)
						.withImage(new Image(Assets.IMG_RIGHT))
						.whenClicked(function():void {

							FP.console.log("clicked right");
						})
						.build());	
						
						
			add(Button.description()
						.at(50, 30)
						.withDepth(-1)
						.withImage(new Image(Assets.IMG_INSTRUMENT_IMAGE))
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