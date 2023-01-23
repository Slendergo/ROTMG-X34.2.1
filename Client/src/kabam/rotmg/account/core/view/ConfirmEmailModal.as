﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.core.view.ConfirmEmailModal

package kabam.rotmg.account.core.view{
    import com.company.assembleegameclient.account.ui.Frame;
    import org.osflash.signals.Signal;
    import com.company.assembleegameclient.account.ui.TextInputField;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.pets.view.components.DialogCloseButton;
    import kabam.rotmg.account.web.model.AccountData;
    import kabam.rotmg.text.model.TextKey;
    import kabam.rotmg.core.StaticInjectorContext;
    import flash.events.MouseEvent;
    import com.company.util.EmailValidator;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import com.company.util.MoreObjectUtil;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import flash.filters.DropShadowFilter;

    public class ConfirmEmailModal extends Frame {

        public var register:Signal;
        public var cancel:Signal;
        private var emailInput:TextInputField;
        private var account:Account;
        private var closeButton:DialogCloseButton;
        private var isKabam:Boolean = false;

        public function ConfirmEmailModal(){
            this.register = new Signal(AccountData);
            super(TextKey.VERIFY_WEB_ACCOUNT_DIALOG_TITLE, TextKey.REGISTER_WEB_ACCOUNT_DIALOG_LEFTBUTTON, TextKey.VERIFY_WEB_ACCOUNT_DIALOG_BUTTON);
            this.positionAndStuff();
            removeChild(leftButton_);
            this.account = StaticInjectorContext.getInjector().getInstance(Account);
            this.createAssets();
            this.enableForTabBehavior();
            this.addEventListeners();
        }

        private function addEventListeners():void{
            rightButton_.addEventListener(MouseEvent.CLICK, this.onVerify);
            this.closeButton.addEventListener(MouseEvent.CLICK, this.onCancel);
        }

        private function createAssets():void{
            this.emailInput = new TextInputField(TextKey.REGISTER_WEB_ACCOUNT_EMAIL, false);
            if (EmailValidator.isValidEmail(this.account.getUserId())){
                this.emailInput.inputText_.setText(this.account.getUserId());
            }
            else {
                this.emailInput.inputText_.setText("");
                this.isKabam = true;
            };
            addTextInputField(this.emailInput);
            this.closeButton = new DialogCloseButton();
            this.closeButton.y = -2;
            this.closeButton.x = ((w_ - this.closeButton.width) - 8);
            addChild(this.closeButton);
        }

        private function enableForTabBehavior():void{
            this.emailInput.tabIndex = 1;
            rightButton_.tabIndex = 2;
            this.emailInput.tabEnabled = true;
            rightButton_.tabEnabled = true;
        }

        private function onCancel(_arg1:MouseEvent):void{
            this.close();
        }

        private function close():void{
            if (((parent) && (parent.contains(this)))){
                parent.removeChild(this);
            };
        }

        private function onVerify(_arg1:MouseEvent):void{
            var _local2:AppEngineClient;
            var _local3:Object;
            if (this.isEmailValid()){
                _local2 = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
                _local2.complete.addOnce(this.onComplete);
                _local3 = {newGuid:this.emailInput.text()};
                MoreObjectUtil.addToObject(_local3, this.account.getCredentials());
                _local2.sendRequest("account/changeEmail", _local3);
                rightButton_.removeEventListener(MouseEvent.CLICK, this.onVerify);
            };
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            if (_arg1){
                this.onSent();
            }
            else {
                this.onError(_arg2);
            };
            rightButton_.addEventListener(MouseEvent.CLICK, this.onVerify);
        }

        private function onSent():void{
            var _local1:Account = StaticInjectorContext.getInjector().getInstance(Account);
            if (!this.isKabam){
                _local1.updateUser(this.emailInput.text(), _local1.getPassword(), _local1.getToken());
            };
            removeChild(titleText_);
            titleText_ = new TextFieldDisplayConcrete().setSize(12).setColor(0xB3B3B3);
            titleText_.setStringBuilder(new LineBuilder().setParams("WebAccountDetailDialog.sent"));
            titleText_.filters = [new DropShadowFilter(0, 0, 0)];
            titleText_.x = 5;
            titleText_.y = 3;
            titleText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
            addChild(titleText_);
        }

        private function onError(_arg1:String):void{
            removeChild(titleText_);
            titleText_ = new TextFieldDisplayConcrete().setSize(12).setColor(16549442);
            titleText_.setStringBuilder(new LineBuilder().setParams(_arg1));
            titleText_.filters = [new DropShadowFilter(0, 0, 0)];
            titleText_.x = 5;
            titleText_.y = 3;
            titleText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
            addChild(titleText_);
        }

        private function isEmailValid():Boolean{
            var _local1:Boolean = EmailValidator.isValidEmail(this.emailInput.text());
            if (!_local1){
                this.emailInput.setError(TextKey.INVALID_EMAIL_ADDRESS);
            };
            return (_local1);
        }

        private function positionAndStuff():void{
            this.x = ((WebMain.STAGE.stageWidth / 2) - (this.w_ / 2));
            this.y = ((WebMain.STAGE.stageHeight / 2) - (this.h_ / 2));
        }


    }
}//package kabam.rotmg.account.core.view

