package undersea.displays {

	import common.displays.Popup;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import hex.HexView;
    import map.MapView;
    import model.PlayerData;
    import net.flashpunk.FP;
    import net.flashpunk.Graphic;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
    import net.flashpunk.World;
    import common.ui.Button;
    import common.Assets;
    import common.ui.ButtonPaginator;
    import observatory.ComponentData;
    import common.displays.Display;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.ByteArray;
	import observatory.Instrument;
	import observatory.ObservatoryComponent;
	
    public class NodeDisplay extends Popup 
	{
		
		private var component:ObservatoryComponent;
		
        public function NodeDisplay(parent:World, component:ObservatoryComponent) 
		{
			this.component = component;
			clearColor = 0xDD000000;
			blocksUpdates = true;
			
            super(parent, FP.width - 100, FP.height - 100);


        }
		
    }
}