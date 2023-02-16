// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.PlaySound

package kabam.rotmg.messaging.impl.incoming{
import flash.net.Socket;
import flash.utils.ByteArray;

    public class PlaySound extends IncomingMessage {

        public var ownerId_:int;
        public var soundId_:int;

        public function PlaySound(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.ownerId_ = _arg1.readInt();
            this.soundId_ = _arg1.readUnsignedByte();
        }

        override public function toString():String{
            return (formatToString("PLAYSOUND", "ownerId_", "soundId_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

