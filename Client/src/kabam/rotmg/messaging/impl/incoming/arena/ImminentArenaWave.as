﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.arena.ImminentArenaWave

package kabam.rotmg.messaging.impl.incoming.arena{
    import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
    import flash.utils.IDataInput;

    public class ImminentArenaWave extends IncomingMessage {

        public var currentRuntime:int;

        public function ImminentArenaWave(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:IDataInput):void{
            this.currentRuntime = _arg1.readInt();
        }

        override public function toString():String{
            return (formatToString("IMMINENTARENAWAVE", "currentRuntime"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming.arena

