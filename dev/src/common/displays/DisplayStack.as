package common.displays {

    /**
     *      A stack of displays?
     *      Updates and renders bottom to top
     */
    public class DisplayStack {

        private var displays:Vector.<Display> = new Vector.<Display>;

        public function DisplayStack(... displaysToAdd) {

            for each (var display:Display in displaysToAdd) push(display);
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

            for each (display in displays) display.update();
            for each (display in displays) display.updateLists();

            return this;
        }

        public function render():DisplayStack {

            for each (var display:Display in displays) display.render();

            return this;
        }
    }
}
