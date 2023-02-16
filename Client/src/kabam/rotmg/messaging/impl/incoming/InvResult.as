// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.InvResult

package kabam.rotmg.messaging.impl.incoming{
import flash.net.Socket;
import flash.utils.ByteArray;

    public class InvResult extends IncomingMessage {

        public var result_:int;

        public function InvResult(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.result_ = _arg1.readInt();
        }

        override public function toString():String{
            return (formatToString("INVRESULT", "result_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

