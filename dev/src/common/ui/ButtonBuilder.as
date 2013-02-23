package common.ui
{

    import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
    import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;

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
        private var isFixed:Boolean             = false;

        public function ButtonBuilder() {

        }

        /**
         *      Sets the position of the button in the world.
         *      This is not screen-relative.
         */
        public function at(x:int, y:int):ButtonBuilder {

            this.isFixed = false;
            this.x = x;
            this.y = y;

            return this;
        }

        /**
         *      Sets the position of the button relative to the screen.
         *      The button will be fixed onscreen at these screen-relative coordinates.
         */
         public function fixedAt(x:int, y:int):ButtonBuilder {

            this.isFixed = true;
            this.x = x;
            this.y = y;

            return this;
         }

        /**
         *      Sets the button's image.
         *      This implicitly sets the height and width.
         */
         public function withImage(image:*):ButtonBuilder {
			 
			 if (!(image is Image)) {
				 image = new Image(image);
			 }

            impliedWidth    = image.width;
            impliedHeight   = image.height;
            graphic         = image;

            return this;
         }
		 
		 /**
		  * 	Sets the button's image to an incomming image list
		  * 	This implicitly sets the height and width to that of the first image in the list
		  */
		 public function withGraphicList(list:Graphiclist):ButtonBuilder{
			 
			impliedWidth 	= list.width;
			impliedHeight 	= list.height;
			graphic 		= list;
			
			return this;
		 }
		 
		 /**
		  * Sets the image to be the text over image.
		  */
		 public function withImageAndText(image:*, text:Text):ButtonBuilder {
			 
                         if (!(image is Image)) image = new Image(image);

			 impliedWidth = image.width;
			 impliedHeight = image.height;
			 
			 text.color = 0x000000;
			 text.y = 5;
			 
			 var list:Graphiclist = new Graphiclist();
			 list.add(image);
			 list.add(text);
			 graphic = list;
			 
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
                                        isFixed,
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
