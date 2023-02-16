// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.Load

package kabam.rotmg.messaging.impl.outgoing{
    import flash.utils.ByteArray;

    public class Load extends OutgoingMessage {

        public var charId_:int;
        public var isFromArena_:Boolean;

        public function Load(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:ByteArray):void{
            _arg1.writeInt(this.charId_);
            _arg1.writeBoolean(this.isFromArena_);
        }

        override public function toString():String{
            return (formatToString("LOAD", "charId_", "isFromArena_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

