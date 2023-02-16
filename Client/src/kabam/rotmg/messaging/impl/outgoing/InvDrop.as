// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.InvDrop

package kabam.rotmg.messaging.impl.outgoing{
    import kabam.rotmg.messaging.impl.data.SlotObjectData;
    import flash.utils.ByteArray;

    public class InvDrop extends OutgoingMessage {

        public var slotObject_:SlotObjectData;

        public function InvDrop(_arg1:uint, _arg2:Function){
            this.slotObject_ = new SlotObjectData();
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:ByteArray):void{
            this.slotObject_.writeToOutput(_arg1);
        }

        override public function toString():String{
            return (formatToString("INVDROP", "slotObject_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

