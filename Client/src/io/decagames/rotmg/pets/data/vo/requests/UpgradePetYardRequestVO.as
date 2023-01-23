// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.data.vo.requests.UpgradePetYardRequestVO

package io.decagames.rotmg.pets.data.vo.requests{
    public class UpgradePetYardRequestVO implements IUpgradePetRequestVO {

        public var objectID:int;
        public var paymentTransType:int;

        public function UpgradePetYardRequestVO(_arg1:int, _arg2:int){
            this.objectID = _arg1;
            this.paymentTransType = _arg2;
        }

    }
}//package io.decagames.rotmg.pets.data.vo.requests

