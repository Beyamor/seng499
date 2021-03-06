package undersea.displays {

	import common.displays.Popup;
	import common.ImageHelper;
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
    import common.displays.Display;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.ByteArray;
	import observatory.Instrument;
	import observatory.ObservatoryComponent;

    public class InstrumentDisplay extends Popup 
	{
		private var video:Video = new Video();
		private var ns:NetStream;
		
		private var instrument:Instrument;
		
        public function InstrumentDisplay(parent:World, instrument:Instrument) 
		{
			this.instrument = instrument;
			clearColor = 0xDD000000;
			blocksUpdates = true;
			
            super(parent, FP.width - 100, FP.height - 100);
			
			// We don't have any videos yet - CP
			//setUpFLVStream();
			//addOnEndCallback(onEnd);
			
			setUpinstrumentInformation();
			
        }
		
		private function setUpinstrumentInformation():void 
		{
			var instrumentName:Text = new Text(instrument.getName());
			instrumentName.scale = 3;
			addGraphic(instrumentName, 0, (width / 2) - (instrumentName.scaledWidth / 2), 20 );
			
			var instrumentDescription:Text = new Text("Description:\n" + instrument.description, 150, 100);
			addGraphic(instrumentDescription);

			addGraphic(new Text("Data:\n" + instrument.sample.description, 350, 250));

			if (instrument.sample.isVideo)
			{
				
				setUpFLVStream();
				addOnEndCallback(onEnd);
			}
			else
			{
				var instrumentDataImage:Image = new Image(instrument.sample.media);
				addGraphic(ImageHelper.scaleTo(instrumentDataImage, 300 , 300), 0, 10, height - instrumentDataImage.scaledHeight - 10);
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
				var file:ByteArray = new instrument.sample.media;//Assets.VIDEO_TEST();
				var file:ByteArray = new (instrument as Instrument).sample.media;
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