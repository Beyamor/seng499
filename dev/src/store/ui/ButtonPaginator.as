package store.ui {

    import flash.geom.Rectangle;
    import common.ui.Button;
    import net.flashpunk.FP;

    /**
     *  Displays pages of buttons
     */
    public class ButtonPaginator {

        private var buttons:Vector.<Button>;
        private var view:Rectangle;
        private var horizontalNumber:uint;
        private var verticalNumber:uint;
        private function get numberPerPage():uint { return horizontalNumber * verticalNumber; }
        private var buttonWidth:Number;
        private var buttonHeight:Number;

        // TODO: Figure out page separation. Maybe supply in constructor?
        private function get pageSeparation():Number { return FP.width; }

        public function ButtonPaginator(view:Rectangle, horizontalNumber:uint, verticalNumber:uint, buttons:Vector.<Button>) {

            this.view               = view;
            this.horizontalNumber   = horizontalNumber;
            this.verticalNumber     = verticalNumber;
            this.buttons            = buttons;
            buttonWidth             = maxButtonWidth();
            buttonHeight            = maxButtonHeight();

            positionButtons();
        }

        private function maxButtonWidth():Number {

            var maxWidth:Number = 0;
            buttons.forEach(function(button:Button, _:int, __:Vector.<Button>):void
                { if (button.width > maxWidth) maxWidth = button.width; })
            return maxWidth;
        }

        private function maxButtonHeight():Number {

            var maxHeight:Number = 0;
            buttons.forEach(function(button:Button, _:int, __:Vector.<Button>):void
                { if (button.height > maxHeight) maxHeight = button.height; })
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
    }
}
