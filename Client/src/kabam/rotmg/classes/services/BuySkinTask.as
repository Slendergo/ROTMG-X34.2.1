﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.classes.services.BuySkinTask

package kabam.rotmg.classes.services{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.classes.model.CharacterSkin;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.classes.model.CharacterSkinState;
    import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

    public class BuySkinTask extends BaseTask {

        [Inject]
        public var skin:CharacterSkin;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var player:PlayerModel;
        [Inject]
        public var openDialog:OpenDialogSignal;


        override protected function startTask():void{
            this.skin.setState(CharacterSkinState.PURCHASING);
            this.player.changeCredits(-(this.skin.cost));
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("account/purchaseSkin", this.makeCredentials());
        }

        private function makeCredentials():Object{
            var _local1:Object = this.account.getCredentials();
            _local1.skinType = this.skin.id;
            return (_local1);
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            if (_arg1){
                this.completePurchase();
            }
            else {
                this.abandonPurchase(_arg2);
            };
            completeTask(_arg1, _arg2);
        }

        private function completePurchase():void{
            this.skin.setState(CharacterSkinState.OWNED);
            this.skin.setIsSelected(true);
        }

        private function abandonPurchase(_arg1:String):void{
            var _local2:ErrorDialog = new ErrorDialog(_arg1);
            this.openDialog.dispatch(_local2);
            this.skin.setState(CharacterSkinState.PURCHASABLE);
            this.player.changeCredits(this.skin.cost);
        }


    }
}//package kabam.rotmg.classes.services

