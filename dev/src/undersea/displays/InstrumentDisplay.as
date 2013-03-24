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

	// Crackers. InstrumentDisplay is displaying non instrument things now. Whatever. - CP
	
    public class InstrumentDisplay extends Popup 
	{
		private var video:Video = new Video();
		private var ns:NetStream;
		
		private var component:ObservatoryComponent;
		
        public function InstrumentDisplay(parent:World, component:ObservatoryComponent) 
		{
			this.component = component;
			clearColor = 0xDD000000;
			blocksUpdates = true;
			
            super(parent, FP.width - 100, FP.height - 100);
			
			setUpFLVStream();
			setUpInstrumentInformation();
			
			addOnEndCallback(onEnd);
			
        }
		
		private function setUpInstrumentInformation():void 
		{
			var componentName:Text = new Text(component.getName());
			componentName.scale = 3;
			addGraphic(componentName, 0, (width / 2) - (componentName.scaledWidth / 2), 20 );
			
			var componentDescription:Text = new Text("Description:\n" + component.description, 150, 100);
			addGraphic(componentDescription);
			
			// more like, if produces data - CP
			if (!component.isNode()) {
				addGraphic(new Text("Data:\n" + (component as Instrument).dataDescription, 350, 250));
			}
		}

		private function getMeta(mdata:Object):void
		{
			video.width = mdata.width / 2;
			video.height = mdata.height / 2;
		}
		
		private function onConnect(e:NetStatusEvent):void 
		{
			if (e.info.code == 'NetConnection.Connect.Success') {
				trace(e.target as NetConnection);
				ns = new NetStream(e.target as NetConnection);
				
				ns.client = {};
				var file:ByteArray = new Assets.VIDEO_TEST();
				ns.play(null);
				
				ns.appendBytes(file);
				video.attachNetStream(ns);
			}
		}
		
		private function onEnd():void
		{
			FP.stage.removeChild(video);
			ns.close();
		}
		
		private function setUpFLVStream():void
		{
			FP.stage.addChild(video);
			
			var nc:NetConnection = new NetConnection();
			nc.addEventListener(NetStatusEvent.NET_STATUS, onConnect);
			nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, trace);
			
			var metaSniffer:Object = new Object();
			nc.client = metaSniffer;
			metaSniffer.onMetaData = getMeta;
			nc.connect(null);
			
			video.x = x + 10;
			video.y = height - video.height + 40;//huh
		}
		
    }
}