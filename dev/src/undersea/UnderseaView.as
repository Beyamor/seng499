package undersea 
{
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.ByteArray;
	import hex.HexTile;
	import hex.HexView;
	import model.Game;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.World;
	import common.ui.Button;
	import net.flashpunk.FP;
	import common.Assets;
    import observatory.ObservatoryComponent;
	
	/**
	 * ...
	 * @author Colton Phillips
	 */
	public class UnderseaView extends World
	{
		private var game:Game;
		private var color:uint;
		private var tile:HexTile;

		private var video:Video = new Video();
		private var chinceRotate:int = -180;
		
		public function UnderseaView(tile:HexTile, game:Game) 
		{
			this.game = game;
			this.color = tile.color;
			this.tile = tile;
		}
		
		private function clickedBack():void
		{
			FP.world = new HexView(game, 0, 0);
			FP.stage.removeChild(video);
		}
		
		private function setUpButtons():void
		{
			add(Button.description()
						.fixedAt(FP.width - 58, FP.height - 42)
						.withImageAndText(new Image(Assets.IMG_MAPBUTTONBACKGROUND), new Text("back"))
						.withDepth(-1)
						.whenClicked(clickedBack)
						.build());
		}
		
		private function setUpInstruments():void
		{
			var instrument:ObservatoryComponent;
			var instruments:Vector.<ObservatoryComponent> = game.data.getHexData(tile.indices).observatoryComponents;
			
			for (var i:uint = 0; i < instruments.length; i++)
			{
				instrument = instruments[i];
				addGraphic(new Text(instrument.getName(), 20, 30 + 20 * i));
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
				var ns:NetStream = new NetStream(e.target as NetConnection);
				
				ns.client = {};
				var file:ByteArray = new Assets.VIDEO_TEST();
				ns.play(null);
				
				ns.appendBytes(file);
				video.attachNetStream(ns);
			}
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
			
			video.x = 300;
			video.y = 300;
		}
		
		override public function begin():void
		{
			super.begin();
			
			setUpButtons();
			setUpInstruments();		
			setUpFLVStream();
		}
		
		override public function render():void
		{
			Draw.rect(0, 0, FP.width, FP.height, color);
			super.render();
		}
		
		override public function update():void
		{
			super.update();
			chinceRotate++;
			
			video.rotationX = chinceRotate;
			video.rotationY = chinceRotate;
			video.rotationZ = chinceRotate;
			
			if (chinceRotate == 180)
				chinceRotate = -180;
		}
		
	}

}
