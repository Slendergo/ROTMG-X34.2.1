﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.packages.services.BuyPackageTask

package kabam.rotmg.packages.services{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.core.model.PlayerModel;
    import com.company.assembleegameclient.map.QueueStatusTextSignal;
    import kabam.rotmg.packages.model.PackageInfo;
    import kabam.rotmg.packages.control.BuyPackageSuccessfulSignal;
    import kabam.rotmg.text.model.TextKey;

    public class BuyPackageTask extends BaseTask {

        private static const ERROR_MESSAGES_THAT_REFRESH:Array = ["Package is not Available", "Package is not Available Right Now", "Invalid PackageId"];

        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var getPackageTask:GetPackagesTask;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var queueStatusText:QueueStatusTextSignal;
        [Inject]
        public var packageInfo:PackageInfo;
        [Inject]
        public var buyPackageSuccessful:BuyPackageSuccessfulSignal;


        override protected function startTask():void{
            var _local1:Object = this.account.getCredentials();
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/account/purchasePackage", _local1);
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            var _local3:XML = new XML(_arg2);
            if (_arg1){
                this.completePurchase(_local3);
            }
            else {
                this.abandonPurchase(_local3);
            }
            completeTask(true, _arg2);
        }

        private function completePurchase(_arg1:XML):void{
            this.queueStatusText.dispatch(TextKey.BUYPACKAGETASK_NEWGIFTS, 11495650);
            this.buyPackageSuccessful.dispatch();
        }

        private function abandonPurchase(_arg1:XML):void{
            this.reportFailureAndRefreshPackages(_arg1[0]);
        }

        private function reportFailureAndRefreshPackages(_arg1:String):void{
            this.queueStatusText.dispatch(_arg1, 16744576);
            if (ERROR_MESSAGES_THAT_REFRESH.indexOf(_arg1) != -1){
                this.getPackageTask.start();
            }
        }


    }
}//package kabam.rotmg.packages.services

