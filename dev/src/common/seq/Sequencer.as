package common.seq 
{
	/**
	 * ...
	 * @author beyamor
	 */
	public class Sequencer 
	{
		private var items:Vector.<SequencerItem> = new Vector.<SequencerItem>;
		
		public function Sequencer(...items)
		{
			for each (var item:SequencerItem in items) push(item);
		}
		
		public function push(... items):Sequencer {
			
			for each (var item:SequencerItem in items) this.items.push(item);
			return this;
		}
		
		public function update():void {
			
			if (items.length == 0) return;
			
			var item:SequencerItem = items[0];
			item.update();
			if (item.isFinished) items.shift();
		}
	}

}