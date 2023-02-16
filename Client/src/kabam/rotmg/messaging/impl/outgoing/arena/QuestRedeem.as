// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.arena.QuestRedeem

package kabam.rotmg.messaging.impl.outgoing.arena{
    import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;
    import kabam.rotmg.messaging.impl.data.SlotObjectData;
    import flash.utils.ByteArray;

    public class QuestRedeem extends OutgoingMessage {

        public var questID:String;
        public var slots:Vector.<SlotObjectData>;
        public var item:int;

        public function QuestRedeem(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:ByteArray):void{
            var _local2:SlotObjectData;
            _arg1.writeUTF(this.questID);
            _arg1.writeInt(this.item);
            _arg1.writeShort(this.slots.length);
            for each (_local2 in this.slots) {
                _local2.writeToOutput(_arg1);
            }
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing.arena

