// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.pets.DeletePetMessage

package kabam.rotmg.messaging.impl.incoming.pets{
import flash.net.Socket;

import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
    import flash.utils.ByteArray;

    public class DeletePetMessage extends IncomingMessage {

        public var petID:int;

        public function DeletePetMessage(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.petID = _arg1.readInt();
        }


    }
}//package kabam.rotmg.messaging.impl.incoming.pets

