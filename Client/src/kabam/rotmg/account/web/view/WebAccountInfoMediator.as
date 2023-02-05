﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.web.view.WebAccountInfoMediator

package kabam.rotmg.account.web.view{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.build.api.BuildEnvironment;
    import kabam.rotmg.account.core.signals.LogoutSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.signals.LoginSignal;
    import kabam.rotmg.account.web.model.AccountData;
    import com.company.assembleegameclient.ui.dialogs.ConfirmDialog;

    public class WebAccountInfoMediator extends Mediator {

        [Inject]
        public var view:WebAccountInfoView;
        [Inject]
        public var account:Account;
        [Inject]
        public var logout:LogoutSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;

        override public function initialize():void{
            this.view.login.add(this.onLoginToggle);
            this.view.register.add(this.onRegister);
        }

        override public function destroy():void{
            this.view.login.remove(this.onLoginToggle);
            this.view.register.remove(this.onRegister);
        }

        private function onRegister():void{
            this.openDialog.dispatch(new WebRegisterDialog());
        }

        private function onLoginToggle():void{
            if (this.account.isRegistered()){
                this.onLogOut();
            }
            else {
                this.openDialog.dispatch(new WebLoginDialog());
            }
        }

        private function onLogOut():void {
            this.logout.dispatch();
            this.view.setInfo("", false);
        }
    }
}//package kabam.rotmg.account.web.view

