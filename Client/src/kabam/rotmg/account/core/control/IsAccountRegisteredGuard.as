// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.core.control.IsAccountRegisteredGuard

package kabam.rotmg.account.core.control{
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.account.core.view.RegisterPromptDialog;
    import robotlegs.bender.framework.api.*;

    public class IsAccountRegisteredGuard implements IGuard {

        [Inject]
        public var account:Account;
        [Inject]
        public var openDialog:OpenDialogSignal;


        public function approve():Boolean{
            var _local1:Boolean = this.account.isRegistered();
            ((_local1) || (this.enterRegisterFlow()));
            return (_local1);
        }

        protected function getString():String{
            return ("");
        }

        private function enterRegisterFlow():void{
            this.openDialog.dispatch(new RegisterPromptDialog(this.getString()));
        }


    }
}//package kabam.rotmg.account.core.control

