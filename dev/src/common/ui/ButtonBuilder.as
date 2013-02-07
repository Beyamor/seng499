package common.ui
{

    import net.flashpunk.Graphic;
    import net.flashpunk.graphics.Image;

    /**
     *  A fluent builder for buttons.
     */
    public class ButtonBuilder {

        private var width:Number;
        private var height:Number;
        private var widthExplicitlySet:Boolean  = false;
        private var heightExplicitlySet:Boolean = false;
        private var impliedWidth:Number         = 0;
        private var impliedHeight:Number        = 0;
        private var x:int                       = 0;
        private var y:int                       = 0;
        private var graphic:Graphic;
        private var onClick:Function;
        private var depth:Number                = 0;

        public function ButtonBuilder() {

        }

        /**
         *      Sets the position of the button relative to the screen.
         */
        public function at(x:int, y:int):ButtonBuilder {

            this.x = x;
            this.y = y;

            return this;
        }

        /**
         *      Sets the button's image.
         *      This implicitly sets the height and width.
         */
         public function withImage(image:Image):ButtonBuilder {

            impliedWidth    = image.width;
            impliedHeight   = image.height;
            graphic         = image;

            return this;
         }

         /**
          *     Sets the button's onClick handler.
          */
          public function whenClicked(f:Function):ButtonBuilder {

            onClick = f;

            return this;
          }

          /**
           *    Sets the depth (the layer) of the button.
           */
           public function withDepth(depth:Number):ButtonBuilder {

                this.depth = depth;

                return this;
           }

          /**
           *    Actually builds the button.
           */
           public function build():Button {

                if (!widthExplicitlySet)    width   = impliedWidth;
                if (!heightExplicitlySet)   height  = impliedHeight;

                var b:Button =  new Button(
                                        x,
                                        y,
                                        width,
                                        height,
                                        graphic,
                                        onClick);
                b.layer = depth;

                return b;
           }
    }
}
