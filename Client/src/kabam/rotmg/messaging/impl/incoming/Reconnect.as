﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.Reconnect

package kabam.rotmg.messaging.impl.incoming{
import flash.net.Socket;
import flash.utils.ByteArray;
    import flash.utils.ByteArray;

    public class Reconnect extends IncomingMessage {

        public var name_:String;
        public var host_:String;
        public var port_:int;
        public var gameId_:int;
        public var keyTime_:int;
        public var key_:ByteArray;
        public var isFromArena_:Boolean;
        public var stats_:String;

        public function Reconnect(_arg1:uint, _arg2:Function){
            this.key_ = new ByteArray();
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.name_ = _arg1.readUTF();
            this.host_ = _arg1.readUTF();
            this.stats_ = _arg1.readUTF();
            this.port_ = _arg1.readInt();
            this.gameId_ = _arg1.readInt();
            this.keyTime_ = _arg1.readInt();
            this.isFromArena_ = _arg1.readBoolean();
            var _local2:int = _arg1.readShort();
            this.key_.length = 0;
            _arg1.readBytes(this.key_, 0, _local2);
        }

        override public function toString():String{
            return (formatToString("RECONNECT", "name_", "host_", "port_", "gameId_", "keyTime_", "key_", "isFromArena_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

