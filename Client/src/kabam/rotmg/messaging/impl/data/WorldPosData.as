// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.data.WorldPosData

package kabam.rotmg.messaging.impl.data{
    import flash.geom.Point;
import flash.net.Socket;
import flash.utils.ByteArray;
    import flash.utils.ByteArray;

    public class WorldPosData {

        public var x_:Number;
        public var y_:Number;


        public function toPoint():Point{
            return (new Point(this.x_, this.y_));
        }

        public function parseFromInput(_arg1:Socket):void{
            this.x_ = _arg1.readFloat();
            this.y_ = _arg1.readFloat();
        }

        public function writeToOutput(_arg1:ByteArray):void{
            _arg1.writeFloat(this.x_);
            _arg1.writeFloat(this.y_);
        }

        public function toString():String{
            return (((("x_: " + this.x_) + " y_: ") + this.y_));
        }


    }
}//package kabam.rotmg.messaging.impl.data

