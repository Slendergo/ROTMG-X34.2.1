// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.web.services.WebSendVerificationEmailTask

package kabam.rotmg.account.web.services{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.core.signals.TrackEventSignal;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.services.*;

    public class WebSendVerificationEmailTask extends BaseTask implements SendConfirmEmailAddressTask {

        [Inject]
        public var account:Account;
        [Inject]
        public var client:AppEngineClient;


        override protected function startTask():void{
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/account/sendVerifyEmail", this.account.getCredentials());
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            if (_arg1){
                this.onSent();
            }
            else {
                this.onError(_arg2);
            }
        }

        private function onSent():void{
            completeTask(true);
        }

        private function onError(_arg1:String):void{
            this.account.clear();
            completeTask(false);
        }


    }
}//package kabam.rotmg.account.web.services

