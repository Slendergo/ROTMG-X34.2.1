// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.arena.ArenaDeath

package kabam.rotmg.messaging.impl.incoming.arena{
import flash.net.Socket;

import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
    import flash.utils.ByteArray;

    public class ArenaDeath extends IncomingMessage {

        public var cost:int;

        public function ArenaDeath(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.cost = _arg1.readInt();
        }

        override public function toString():String{
            return (formatToString("ARENADEATH", "cost"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming.arena

