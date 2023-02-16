// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.arena.ImminentArenaWave

package kabam.rotmg.messaging.impl.incoming.arena{
import flash.net.Socket;

import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
    import flash.utils.ByteArray;

    public class ImminentArenaWave extends IncomingMessage {

        public var currentRuntime:int;

        public function ImminentArenaWave(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.currentRuntime = _arg1.readInt();
        }

        override public function toString():String{
            return (formatToString("IMMINENTARENAWAVE", "currentRuntime"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming.arena

