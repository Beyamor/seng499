package hex.controllers {
        
    import model.HexData;
    import hex.HexTile;
    import net.flashpunk.FP;

    /**
     *  The InstrumentPlacer controller places an instrument on a tile.
     */
    public class InstrumentPlacer implements HexController {

        private var instrument:Instrument;

        public function InstrumentPlacer() {

            // TODO: get the instrument from the game state
            instrument = new Instrument(randomInstrumentName());
        }

    /**
     *      Yoinked from: http://actionscriptsnips.blogspot.ca/2009/08/generate-random-string.html
     *      Temporary until reading real instruments.
     */
    private function randomInstrumentName():String{

        var strlen:uint = 8;
        var chars:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        var num_chars:Number = chars.length - 1;
        var randomChar:String = "";

        for (var i:Number = 0; i < strlen; i++){

            randomChar += chars.charAt(Math.floor(Math.random() * num_chars));
        }

        return randomChar;
     }

        public function hexSelected(tile:HexTile):void {

            HexData.addToInstruments(tile.xIndex, tile.yIndex, instrument);
            // TODO: exit inventory placement

            var instruments:Vector.<Instrument> = HexData.getInstruments(tile.xIndex, tile.yIndex);
            var placedInstrument:Instrument     = instruments[instruments.length-1] 
            FP.log("Placed " + placedInstrument.get_name() + " at " + tile.xIndex + ", " + tile.yIndex);
        }
    }
}
