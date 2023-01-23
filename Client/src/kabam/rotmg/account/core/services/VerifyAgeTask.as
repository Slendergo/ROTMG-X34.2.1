﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.core.services.VerifyAgeTask

package kabam.rotmg.account.core.services{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.appengine.api.AppEngineClient;

    public class VerifyAgeTask extends BaseTask {

        [Inject]
        public var account:Account;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var client:AppEngineClient;


        override protected function startTask():void{
            if (this.account.isRegistered()){
                this.sendVerifyToServer();
            }
            else {
                this.verifyUserAge();
            };
        }

        private function sendVerifyToServer():void{
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/account/verifyage", this.makeDataPacket());
        }

        private function makeDataPacket():Object{
            var _local1:Object = this.account.getCredentials();
            _local1.isAgeVerified = 1;
            return (_local1);
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            ((_arg1) && (this.verifyUserAge()));
            completeTask(_arg1, _arg2);
        }

        private function verifyUserAge():void{
            this.playerModel.setIsAgeVerified(true);
            completeTask(true);
        }


    }
}//package kabam.rotmg.account.core.services

