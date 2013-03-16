package common.ui {

    import flash.geom.Rectangle;
    import flash.geom.Point;
    import common.ui.Button;
    import net.flashpunk.FP;
    import net.flashpunk.World;

    /**
     *  Displays pages of buttons
     */
    public class ButtonPaginator {

	private static const SCROLL_SCALING_FACTOR:Number   = 30;

        private var world:World;
        private var buttons:Vector.<Button>;
        private var view:Rectangle;
        private var horizontalNumber:uint;
        private var verticalNumber:uint;
        private function get numberPerPage():uint { return horizontalNumber * verticalNumber; }
        private var buttonWidth:Number;
        private var buttonHeight:Number;
		private var pageIndex:int = 0;
		private var scrollSpeed:Number = 0;
		private var cameraTargetPoint:Point = new Point(0, 0);
        private function get camera():Point { return world.camera; }
	
        // TODO: Figure out page separation. Maybe supply in constructor?
        private function get pageSeparation():Number { return 2 * view.width; }

        public function ButtonPaginator(world:World, bounds:Rectangle, horizontalNumber:uint, verticalNumber:uint, buttons:Vector.<Button>) {

            this.world              = world;
            this.view               = bounds;
            this.horizontalNumber   = horizontalNumber;
            this.verticalNumber     = verticalNumber;
            this.buttons            = buttons;
            buttonWidth             = maxButtonWidth();
            buttonHeight            = maxButtonHeight();

            positionButtons();
        }

        private function maxButtonWidth():Number {

            var maxWidth:Number = 0;
            for each (var button:Button in buttons)
                { if (button.width > maxWidth) maxWidth = button.width; }
            return maxWidth;
        }

        private function maxButtonHeight():Number {

            var maxHeight:Number = 0;
            for each (var button:Button in buttons)
                 { if (button.height > maxHeight) maxHeight = button.height; }
            return maxHeight;
        }

        private function positionButtons():void {

            // The buttons should be layed out in a grid such that a single page falls exactly inside the view.
            // So, left edge of leftmost button lies on left edge of view, and so on for right, top, and bottom.
            var lowerX:Number   = view.left;
            var upperX:Number   = view.right - buttonWidth;
            var lowerY:Number   = view.top;
            var upperY:Number   = view.bottom - buttonHeight;

            var xStep:Number    = (upperX - lowerX) / (horizontalNumber - 1);
            var yStep:Number    = (upperY - lowerY) / (verticalNumber - 1);

            for (var buttonIndex:uint = 0; buttonIndex < buttons.length; ++buttonIndex) {

                var gridX:uint  = buttonIndex % horizontalNumber;
                var gridY:uint  = (buttonIndex / horizontalNumber) % verticalNumber;
                var page:uint   = buttonIndex / numberPerPage;

                var button:Button = buttons[buttonIndex];

                button.x = lowerX + gridX * xStep + page * pageSeparation;
                button.y = lowerY + gridY * yStep;
            }
        }

		public function update():void
        {
                FP.stepTowards(camera, cameraTargetPoint.x, cameraTargetPoint.y, scrollSpeed);
        }

        private function get highestPageIndex():int {

            return (buttons.length - 1) / (horizontalNumber * verticalNumber);
         }
	
        public function goToNextPage():void {

			if (pageIndex < highestPageIndex) 
			{
				pageIndex++;
				setTargetToPage(pageIndex);
			}
        }
	  
        public function goToPreviousPage():void {

			if (pageIndex > 0) 
			{
				pageIndex--;
				setTargetToPage(pageIndex);
			}
        }
	   
		private function calculateScrollSpeed():void
		{
				scrollSpeed = Math.abs(cameraTargetPoint.x - camera.x) / SCROLL_SCALING_FACTOR;
		}
		
		public function setTargetToPage(pageIndex:int):void
		{
			cameraTargetPoint.x = pageIndex * pageSeparation;
			calculateScrollSpeed();
		}
		
		public function resetList(buttons:Vector.<Button>):void {
			
			this.buttons = buttons;			
			positionButtons();
			if (pageIndex > highestPageIndex) setTargetToPage(highestPageIndex);
		}
    }
}
