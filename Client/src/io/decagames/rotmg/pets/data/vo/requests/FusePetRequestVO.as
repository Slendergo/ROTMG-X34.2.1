// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.data.vo.requests.FusePetRequestVO

package io.decagames.rotmg.pets.data.vo.requests{
    public class FusePetRequestVO implements IUpgradePetRequestVO {

        public var petInstanceIdOne:int;
        public var petInstanceIdTwo:int;
        public var paymentTransType:int;

        public function FusePetRequestVO(_arg1:int, _arg2:int, _arg3:int){
            this.petInstanceIdOne = _arg1;
            this.petInstanceIdTwo = _arg2;
            this.paymentTransType = _arg3;
        }

    }
}//package io.decagames.rotmg.pets.data.vo.requests

