package model {

    public class HexData {
    
        private static var data:Object = new Object;

        public static function addToInstruments(x:uint, y:uint, instrument:Instrument):void {

            if (!data[x])       data[x]     = new Object;
            if (!data[x][y])    data[x][y]  = new Vector.<Instrument>;

            data[x][y].push(instrument);
        }

        public static function getInstruments(x:uint, y:uint):Vector.<Instrument> {

            if (!data[x])       return new Vector.<Instrument>;
            if (!data[x][y])    return new Vector.<Instrument>;

            return data[x][y];
        }
    }
}
