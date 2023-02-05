// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.PetUpgradeRequest

package kabam.rotmg.messaging.impl{
    import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;
    import kabam.rotmg.messaging.impl.data.SlotObjectData;
    import flash.utils.IDataOutput;

    public class PetUpgradeRequest extends OutgoingMessage {

        public static const GOLD_PAYMENT_TYPE:int = 0;
        public static const FAME_PAYMENT_TYPE:int = 1;

        public var petTransType:int;
        public var PIDOne:int;
        public var PIDTwo:int;
        public var objectId:int;
        public var slotsObject:Vector.<SlotObjectData>;
        public var paymentTransType:int;

        public function PetUpgradeRequest(_arg1:uint, _arg2:Function){
            this.slotsObject = new Vector.<SlotObjectData>();
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:IDataOutput):void{
            var _local2:SlotObjectData;
            _arg1.writeByte(this.petTransType);
            _arg1.writeInt(this.PIDOne);
            _arg1.writeInt(this.PIDTwo);
            _arg1.writeInt(this.objectId);
            _arg1.writeByte(this.paymentTransType);
            _arg1.writeShort(this.slotsObject.length);
            for each (_local2 in this.slotsObject) {
                _local2.writeToOutput(_arg1);
            }
        }


    }
}//package kabam.rotmg.messaging.impl

