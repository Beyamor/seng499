package common.displays {

    /**
     *      A stack of displays?
     *      Updates top to bottom, render bottom to top.
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
    }
}
