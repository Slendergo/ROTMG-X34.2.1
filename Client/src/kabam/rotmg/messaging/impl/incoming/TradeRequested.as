// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.TradeRequested

package kabam.rotmg.messaging.impl.incoming{
import flash.net.Socket;
import flash.utils.ByteArray;

    public class TradeRequested extends IncomingMessage {

        public var name_:String;

        public function TradeRequested(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.name_ = _arg1.readUTF();
        }

        override public function toString():String{
            return (formatToString("TRADEREQUESTED", "name_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

