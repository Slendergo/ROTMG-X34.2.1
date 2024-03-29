﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.core.services.BuyCharacterSlotTask

package kabam.rotmg.account.core.services{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.core.model.PlayerModel;

    public class BuyCharacterSlotTask extends BaseTask {

        [Inject]
        public var account:Account;
        [Inject]
        public var price:int;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var model:PlayerModel;

        override protected function startTask():void{
            var _local1:Object = this.account.getCredentials();
            this.client.setMaxRetries(2);
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/account/purchaseCharSlot", _local1);
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            ((_arg1) && (this.updatePlayerData()));
            completeTask(_arg1, _arg2);
        }

        private function updatePlayerData():void{
            this.model.setMaxCharacters((this.model.getMaxCharacters() + 1));
            this.model.changeCredits(-(this.price));
        }


    }
}//package kabam.rotmg.account.core.services

