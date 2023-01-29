﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.web.view.WebVerifyEmailMediator

package kabam.rotmg.account.web.view{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.core.signals.TrackEventSignal;
    import kabam.rotmg.account.core.signals.SendConfirmEmailSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.account.core.signals.UpdateAccountInfoSignal;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.appengine.api.AppEngineClient;

    public class WebVerifyEmailMediator extends Mediator {

        [Inject]
        public var view:WebVerifyEmailDialog;
        [Inject]
        public var account:Account;
        [Inject]
        public var verify:SendConfirmEmailSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var closeDialog:CloseDialogsSignal;
        [Inject]
        public var updateAccount:UpdateAccountInfoSignal;


        override public function initialize():void{
            this.view.setUserInfo(this.account.getUserName(), this.account.isVerified());
            this.view.verify.add(this.onVerify);
            this.view.logout.add(this.onLogout);
        }

        override public function destroy():void{
            this.view.verify.remove(this.onVerify);
            this.view.logout.remove(this.onLogout);
        }

        private function onVerify():void{
            var _local1:AppEngineClient = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
            _local1.complete.addOnce(this.onComplete);
            _local1.sendRequest("/account/sendVerifyEmail", this.account.getCredentials());
        }

        private function onLogout():void{
            this.account.clear();
            this.updateAccount.dispatch();
            this.openDialog.dispatch(new WebLoginDialog());
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            if (_arg1){
                this.onSent();
            }
            else {
                this.onError(_arg2);
            };
        }

        private function onSent():void{
        }

        private function onError(_arg1:String):void{
            this.account.clear();
        }
    }
}//package kabam.rotmg.account.web.view

