// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.data.GroundTileData

package kabam.rotmg.messaging.impl.data{
import flash.net.Socket;
import flash.utils.ByteArray;

    public class GroundTileData {

        public var x_:int;
        public var y_:int;
        public var type_:uint;

        public function parseFromInput(_arg1:Socket):void{
            this.x_ = _arg1.readShort();
            this.y_ = _arg1.readShort();
            this.type_ = _arg1.readUnsignedShort();
        }

        public function toString():String{
            return (((((("x_: " + this.x_) + " y_: ") + this.y_) + " type_:") + this.type_));
        }


    }
}//package kabam.rotmg.messaging.impl.data

