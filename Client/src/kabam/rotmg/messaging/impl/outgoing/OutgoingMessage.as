﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.OutgoingMessage

package kabam.rotmg.messaging.impl.outgoing{
    import kabam.lib.net.impl.Message;
    import flash.utils.IDataInput;

    public class OutgoingMessage extends Message {

        public function OutgoingMessage(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        final override public function parseFromInput(_arg1:IDataInput):void{
            throw (new Error((("Client should not receive " + id) + " messages")));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

