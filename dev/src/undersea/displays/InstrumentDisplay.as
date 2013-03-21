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
	import observatory.ObservatoryComponent;

    public class InstrumentDisplay extends Popup 
	{
		private var video:Video = new Video();
		private var ns:NetStream;
		
		private var instrument:ObservatoryComponent;
		
        public function InstrumentDisplay(parent:World, instrument:ObservatoryComponent) 
		{
			this.instrument = instrument;
			clearColor = 0xff000000;
			blocksUpdates = true;
			
            super(parent, FP.width - 100, FP.height - 100);
			
			setUpFLVStream();
			setUpInstrumentInformation();
			
			addOnEndCallback(onEnd);
			
        }
		
		private function setUpInstrumentInformation():void 
		{
			addGraphic(new Text(instrument.getName(), 400, 200));
			addGraphic(new Text("A description of the instrument\n in question.", 400, 300));
		
			//addGraphic(new Text(instrument.getDescription(), 400, 200))
			
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
			video.y = y + 10;
		}
		
    }
}