// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.unity.popup.UnitySignUpPopupMediator

package io.decagames.rotmg.unity.popup{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.Account;
    import robotlegs.bender.framework.api.ILogger;
    import flash.events.MouseEvent;
    import com.company.util.EmailValidator;

    public class UnitySignUpPopupMediator extends Mediator {

        [Inject]
        public var view:UnitySignUpPopup;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var logger:ILogger;
        private var steamSignupConfirmation:UnitySignupConfirmation;


        override public function initialize():void{
            this.view.submitButton.addEventListener(MouseEvent.CLICK, this.onOK);
            this.view.cancelButton.addEventListener(MouseEvent.CLICK, this.onCancel);
            this.view.emailInputField.setSelection(0, this.view.emailInputField.text.length);
            this.view.stage.focus = this.view.emailInputField;
        }

        override public function destroy():void{
            this.view.submitButton.removeEventListener(MouseEvent.CLICK, this.onOK);
            this.view.cancelButton.removeEventListener(MouseEvent.CLICK, this.onCancel);
        }

        private function onOK(_arg1:MouseEvent):void{
            this.view.submitButton.removeEventListener(MouseEvent.CLICK, this.onOK);
            this.view.errorText.text = "";
            var _local2:Boolean = this.view.checkBox.isChecked();
            var _local3:String = this.view.emailInputField.text;
            if (!this.checkEmail(_local3)){
                this.view.emailInputField.setSelection(0, this.view.emailInputField.text.length);
                this.view.errorText.text = "Invalid email address - please check.";
                this.view.submitButton.addEventListener(MouseEvent.CLICK, this.onOK);
                this.view.stage.focus = this.view.emailInputField;
            }
            else {
                if (!_local2){
                    this.view.errorText.text = "Please check the checkbox allowing us to contact you.";
                    this.view.submitButton.addEventListener(MouseEvent.CLICK, this.onOK);
                }
                else {
                    this.submit();
                };
            };
        }

        private function submit():void{
            this.logger.info("SteamUnityTask start");
            var _local1:Object = this.account.getCredentials();
            _local1.email = this.view.emailInputField.text;
            _local1.notifyMe = ((this.view.checkBox.isChecked()) ? "1" : "0");
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/account/signupDecaEmail", _local1);
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            if (_arg1){
                this.closePopUp();
                this.showSignUpResult("Thank you for signing up!");
            }
            else {
                this.logger.error(_arg2);
                this.showSignUpResult(_arg2);
            };
        }

        private function checkEmail(_arg1:String):Boolean{
            return (EmailValidator.isValidEmail(_arg1));
        }

        private function onCancel(_arg1:MouseEvent):void{
            this.view.cancelButton.removeEventListener(MouseEvent.CLICK, this.onCancel);
            this.closePopUp();
        }

        private function closePopUp():void{
            this.closePopupSignal.dispatch(this.view);
        }

        private function showSignUpResult(_arg1:String):void{
            this.steamSignupConfirmation = new UnitySignupConfirmation(_arg1);
            this.steamSignupConfirmation.okButton.addEventListener(MouseEvent.CLICK, this.onSignUpResultClose);
            this.showPopupSignal.dispatch(this.steamSignupConfirmation);
        }

        private function onSignUpResultClose(_arg1:MouseEvent):void{
            this.steamSignupConfirmation.okButton.removeEventListener(MouseEvent.CLICK, this.onSignUpResultClose);
            this.closePopupSignal.dispatch(this.steamSignupConfirmation);
        }


    }
}//package io.decagames.rotmg.unity.popup

