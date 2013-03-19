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

    public class InstrumentDisplay extends Popup 
	{
		private var video:Video = new Video();
		private var ns:NetStream;
		
        public function InstrumentDisplay(parent:World) 
		{
            super(parent,FP.width - 200, FP.height - 200);
			setUpFLVStream();
			
			addOnEndCallback(onEnd);
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
			
			video.x = x;
			video.y = y;
		}
		
		override public function begin():void
		{
			super.begin();
		}
		
		override public function update():void
        {
            super.update();
        }
		
		override public function render():void
		{
			Draw.rect(100, 100, width, height,0xFFAAFF);
			super.render();
		}
		
    }
}