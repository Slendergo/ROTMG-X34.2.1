﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.IncomingMessage

package kabam.rotmg.messaging.impl.incoming{
    import kabam.lib.net.impl.Message;
    import flash.utils.IDataOutput;

    public class IncomingMessage extends Message {

        public function IncomingMessage(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        final override public function writeToOutput(_arg1:IDataOutput):void{
            throw (new Error((("Client should not send " + id) + " messages")));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

