package inventory.ui 
{
	import common.Assets;
	import common.displays.Display;
	import common.ui.Button;
	import flash.geom.Rectangle;
	import map.MapView;
	import model.PlayerData;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import observatory.ComponentData;
	import common.ui.ButtonPaginator;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class SelectorWidget extends Display 
	{
		public static const SELECTORS_WIDTH:int		= 170;
		public static const SELECTORS_HEIGHT:int	= 170;
		public static const WIDTH:int				= SELECTORS_WIDTH + 20;
		public static const HEIGHT:int				= SELECTORS_HEIGHT + 50;
		
		private var paginator:ButtonPaginator;
		private var selectors:Vector.<Button>;
		private var playerData:PlayerData;
		private var mapView:MapView;
		
		public function SelectorWidget(parent:Display, mapView:MapView, playerData:PlayerData)
		{			
			super(parent, (parent.width - WIDTH) / 2, 100, WIDTH, HEIGHT);
			this.playerData	= playerData;
			this.mapView	= mapView;
			clearColor		= 0xFFFFFFFF;
			
			var leftImage:Image		= new Image(Assets.IMG_SMALL_LEFT);
			var rightImage:Image	= new Image(Assets.IMG_SMALL_RIGHT);
			
			// And we're potentially running into the overlapping buttons issue again.
			// Man, if only I had time.
			add(Button.description()
					.fixedAt(0, height - leftImage.height)
					.withImage(leftImage)
					.whenClicked(function():void { paginator.goToPreviousPage(); } )
					.build());
					
			add(Button.description()
					.fixedAt(width - rightImage.width, height - rightImage.height)
					.withImage(rightImage)
					.whenClicked(function():void { paginator.goToNextPage(); } )
					.build());
					
			addSelectors();
			
			var selectorMargin:Number = (WIDTH - SELECTORS_WIDTH) / 2;
			paginator = new ButtonPaginator(
							this,
							new Rectangle(selectorMargin, selectorMargin, SELECTORS_WIDTH, SELECTORS_HEIGHT),
							2, 2,
							selectors);
		}
		
		override public function update():void 
		{
			super.update();
			paginator.update();
		}
		
		public function updateSelectors():void {
			
			for each (var selector:Button in selectors) remove(selector);
			addSelectors();
			paginator.resetList(selectors);
		}
		
		private function addSelectors():void 
		{
			selectors = new Vector.<Button>;
			for each (var item:ComponentData in playerData.getInventory()) selectors.push(new InventoryItemSelector(mapView, item));
			
			for each (var selector:Button in selectors) add(selector);
		}
	}

}