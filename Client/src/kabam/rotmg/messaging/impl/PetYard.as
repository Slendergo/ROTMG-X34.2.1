// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.PetYard

package kabam.rotmg.messaging.impl{
import flash.net.Socket;

import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
    import flash.utils.ByteArray;

    public class PetYard extends IncomingMessage {

        public var type:int;

        public function PetYard(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.type = _arg1.readInt();
        }


    }
}//package kabam.rotmg.messaging.impl

