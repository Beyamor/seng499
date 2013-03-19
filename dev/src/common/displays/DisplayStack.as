package common.displays {

    /**
     *      A stack of displays?
     *      Push and pop displays onto the stack.
     *      Updates top to bottom, render bottom to top.
     *
     *      Displays can be set as blocksUpdates.
     *      This will prevent displays below them from being updated.
     *
     */
    public class DisplayStack {

        private var displays:Vector.<Display> = new Vector.<Display>;

        public function DisplayStack(... displaysToAdd) {

            for each (var display:Display in displaysToAdd) push(display);
        }

        public function get top():Display {

            return (displays.length > 0)? displays[displays.length - 1] : null;
        }

        public function push(... displaysToAdd):DisplayStack {

            for each (var display:Display in displaysToAdd) {
            
                displays.push(display);
                display.stack = this;
            }

            return this;
        }

        public function pop():Display {

            var display:Display = displays.pop();
			display.end();
            display.stack = null;
            return display;
        }

        public function update():DisplayStack {
            
            var display:Display;
            var displayIndex:int;

            // Easiest way to allow pushing/popping while updating
            // is just to produced a copy of the display list which does not get changed
            var snapshotOfDisplays:Vector.<Display> = displays.concat();

            for (displayIndex = snapshotOfDisplays.length - 1; displayIndex >=0; --displayIndex) {

                snapshotOfDisplays[displayIndex].update();
                if (snapshotOfDisplays[displayIndex].blocksUpdates) break;
            }

            for each (display in displays) display.updateLists();

            return this;
        }

        public function render():DisplayStack {

            for each (var display:Display in displays) display.render();

            return this;
        }
		
		/**
		 * From the top of the stack down to the bottom, checks if the provided display is the first
		 * which contains the given point
		 */
		public function isFirstDisplayContainingPoint(display:Display, x:Number, y:Number):Boolean {
			
			for (var displayIndex:int = displays.length - 1; displayIndex >= 0; --displayIndex) {

                if (displays[displayIndex].containsPoint(x, y)) return (displays[displayIndex] == display);
            }
			
			return false;
		}
		
		public function popIfTop(display:Display):Boolean {
			
			if (display != top) return false;
			
			pop();
			return true;
		}
		
		public function end():void 
		{
			for each (var display:Display in displays) display.end();
		}
    }
}
