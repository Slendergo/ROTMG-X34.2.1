// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.Goto

package kabam.rotmg.messaging.impl.incoming{
import flash.net.Socket;

import kabam.rotmg.messaging.impl.data.WorldPosData;
    import flash.utils.ByteArray;

    public class Goto extends IncomingMessage {

        public var objectId_:int;
        public var pos_:WorldPosData;

        public function Goto(_arg1:uint, _arg2:Function){
            this.pos_ = new WorldPosData();
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.objectId_ = _arg1.readInt();
            this.pos_.parseFromInput(_arg1);
        }

        override public function toString():String{
            return (formatToString("GOTO", "objectId_", "pos_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

