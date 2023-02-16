// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.GotoAck

package kabam.rotmg.messaging.impl.outgoing{
    import flash.utils.ByteArray;

    public class GotoAck extends OutgoingMessage {

        public var time_:int;

        public function GotoAck(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:ByteArray):void{
            _arg1.writeInt(this.time_);
        }

        override public function toString():String{
            return (formatToString("GOTOACK", "time_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

