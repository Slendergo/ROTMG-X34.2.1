﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.fame.model.SimpleFameVO

package kabam.rotmg.fame.model{
    public class SimpleFameVO implements FameVO {

        private var accountId:String;
        private var characterId:int;

        public function SimpleFameVO(_arg1:String, _arg2:int){
            this.accountId = _arg1;
            this.characterId = _arg2;
        }

        public function getAccountId():String{
            return (this.accountId);
        }

        public function getCharacterId():int{
            return (this.characterId);
        }


    }
}//package kabam.rotmg.fame.model

