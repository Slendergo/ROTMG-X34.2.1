// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.data.vo.requests.FeedPetRequestVO

package io.decagames.rotmg.pets.data.vo.requests{
    import kabam.rotmg.messaging.impl.data.SlotObjectData;

    public class FeedPetRequestVO implements IUpgradePetRequestVO {

        public var petInstanceId:int;
        public var slotObjects:Vector.<SlotObjectData>;
        public var paymentTransType:int;

        public function FeedPetRequestVO(_arg1:int, _arg2:Vector.<SlotObjectData>, _arg3:int){
            this.petInstanceId = _arg1;
            this.slotObjects = _arg2;
            this.paymentTransType = _arg3;
        }

    }
}//package io.decagames.rotmg.pets.data.vo.requests

