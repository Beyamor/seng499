package model {

    public class HexData {
    
        private static data:Object = new Object;

        public static function addToInventory(x:uint, y:uint, item:String):void {

            if (!data[x])       data[x]     = new Object;
            if (!data[x][y])    data[x][y]  = new Vector.<String>;

            data[x][y].push(item);
        }
    }
}
