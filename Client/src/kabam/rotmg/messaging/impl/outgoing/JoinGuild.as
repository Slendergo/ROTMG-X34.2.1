﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.JoinGuild

package kabam.rotmg.messaging.impl.outgoing{
    import flash.utils.IDataOutput;

    public class JoinGuild extends OutgoingMessage {

        public var guildName_:String;

        public function JoinGuild(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:IDataOutput):void{
            _arg1.writeUTF(this.guildName_);
        }

        override public function toString():String{
            return (formatToString("JOINGUILD", "guildName_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

