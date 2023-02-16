// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.ReskinUnlock

package kabam.rotmg.messaging.impl.incoming{
import flash.net.Socket;
import flash.utils.ByteArray;

    public class ReskinUnlock extends IncomingMessage {

        public var skinID:int;
        public var isPetSkin:int;

        public function ReskinUnlock(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.skinID = _arg1.readInt();
            this.isPetSkin = _arg1.readInt();
        }

        override public function toString():String{
            return (formatToString("RESKIN", "skinID"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

