package common.displays {

    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.TiledImage;

    public class BackgroundDisplay extends Display {

        public function BackgroundDisplay(parent:World, texture:*) {

            super(parent, 0, 0, FP.width, FP.height);

            addGraphic(new TiledImage(texture, width, height));
        }

    }
}
