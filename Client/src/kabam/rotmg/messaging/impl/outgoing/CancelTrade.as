// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.CancelTrade

package kabam.rotmg.messaging.impl.outgoing{
    import flash.utils.ByteArray;

    public class CancelTrade extends OutgoingMessage {

        public var objectId_:int;

        public function CancelTrade(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:ByteArray):void{
        }

        override public function toString():String{
            return (formatToString("CANCELTRADE"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

