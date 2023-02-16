// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.Pic

package kabam.rotmg.messaging.impl.incoming{
    import flash.display.BitmapData;
import flash.net.Socket;
import flash.utils.ByteArray;
    import flash.utils.ByteArray;

    public class Pic extends IncomingMessage {

        public var bitmapData_:BitmapData = null;

        public function Pic(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            var _local2:int = _arg1.readInt();
            var _local3:int = _arg1.readInt();
            var _local4:ByteArray = new ByteArray();
            _arg1.readBytes(_local4, 0, ((_local2 * _local3) * 4));
            this.bitmapData_ = new BitmapDataSpy(_local2, _local3);
            this.bitmapData_.setPixels(this.bitmapData_.rect, _local4);
        }

        override public function toString():String{
            return (formatToString("PIC", "bitmapData_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

