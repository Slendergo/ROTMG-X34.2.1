﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.game.view.NameChangerPanelMediator

package kabam.rotmg.game.view{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.ui.signals.NameChangedSignal;
    import com.company.assembleegameclient.account.ui.ChooseNameFrame;
    import kabam.rotmg.account.core.view.RegisterPromptDialog;
    import kabam.rotmg.text.model.TextKey;
    import kabam.rotmg.account.web.WebAccount;

    public class NameChangerPanelMediator extends Mediator {

        [Inject]
        public var account:Account;
        [Inject]
        public var view:NameChangerPanel;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var nameChanged:NameChangedSignal;


        override public function initialize():void{
            this.view.chooseName.add(this.onChooseName);
            this.nameChanged.add(this.onNameChanged);
        }

        override public function destroy():void{
            this.view.chooseName.remove(this.onChooseName);
            this.nameChanged.remove(this.onNameChanged);
        }

        private function onChooseName():void{
            if (this.account.isRegistered()){
                this.openDialog.dispatch(new ChooseNameFrame(this.view.gs_, this.view.buy_));
            }
            else {
                this.openDialog.dispatch(new RegisterPromptDialog(TextKey.NAME_CHANGER_PANEL_MEDIATOR_TEXT));
            };
        }

        private function onNameChanged(_arg1:String):void{
            if ((this.account is WebAccount)){
                WebAccount(this.account).userDisplayName = _arg1;
            };
            this.view.updateName(_arg1);
        }


    }
}//package kabam.rotmg.game.view

