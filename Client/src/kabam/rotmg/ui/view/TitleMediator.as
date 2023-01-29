// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.ui.view.TitleMediator

package kabam.rotmg.ui.view{
import com.company.assembleegameclient.ui.language.LanguageOptionOverlay;

import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.core.signals.SetScreenSignal;
    import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
    import kabam.rotmg.ui.signals.EnterGameSignal;
    import kabam.rotmg.account.core.signals.OpenAccountInfoSignal;
    import kabam.rotmg.account.core.signals.OpenVerifyEmailSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.application.api.ApplicationSetup;
    import kabam.rotmg.core.view.Layers;
    import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsModel;
    import robotlegs.bender.framework.api.ILogger;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.build.api.BuildData;
    import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsInfoDialog;
    import com.company.assembleegameclient.parameters.Parameters;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    import flash.net.URLVariables;
    import kabam.rotmg.application.DynamicSettings;
    import flash.net.URLRequestMethod;
    import flash.system.Capabilities;
    import flash.external.ExternalInterface;
    import kabam.rotmg.ui.model.EnvironmentData;
    import kabam.rotmg.legends.view.LegendsView;
    import com.company.assembleegameclient.mapeditor.MapEditor;
    import flash.events.Event;

    public class TitleMediator extends Mediator {

        private static var supportCalledBefore:Boolean = false;

        [Inject]
        public var view:TitleView;
        [Inject]
        public var account:Account;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var setScreen:SetScreenSignal;
        [Inject]
        public var setScreenWithValidData:SetScreenWithValidDataSignal;
        [Inject]
        public var enterGame:EnterGameSignal;
        [Inject]
        public var openAccountInfo:OpenAccountInfoSignal;
        [Inject]
        public var openVerifyEmailSignal:OpenVerifyEmailSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var setup:ApplicationSetup;
        [Inject]
        public var layers:Layers;
        [Inject]
        public var securityQuestionsModel:SecurityQuestionsModel;
        [Inject]
        public var logger:ILogger;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var buildData:BuildData;

        override public function initialize():void{
            this.view.optionalButtonsAdded.add(this.onOptionalButtonsAdded);
            this.view.initialize(this.makeEnvironmentData());
            this.view.playClicked.add(this.handleIntentionToPlay);
            this.view.accountClicked.add(this.handleIntentionToReviewAccount);
            this.view.legendsClicked.add(this.showLegendsScreen);
            this.view.supportClicked.add(this.openSupportPage);
            this.view.languagesClicked.add(this.openLanguages);
            if (this.playerModel.isNewToEditing()){
                this.view.putNoticeTagToOption(this.view.buttonFactory.getEditorButton(), "new");
            };
            if (this.securityQuestionsModel.showSecurityQuestionsOnStartup){
                this.openDialog.dispatch(new SecurityQuestionsInfoDialog());
            };
            if (!Parameters.sessionStarted){
                Parameters.sessionStarted = true;
            };
            if (((this.account.isRegistered()) && (!(this.account.isVerified())))){
                this.openVerifyEmailSignal.dispatch(false);
            };
        }

        private function openSupportPage():void{
            var _local1:URLRequest = new URLRequest();
            _local1.url = "https://support.decagames.com";
            navigateToURL(_local1, "_blank");
        }

        private function openLanguages():void {
            this.setScreen.dispatch(new LanguageOptionOverlay());
        }

        private function onSupportVerifyComplete(_arg1:Boolean, _arg2):void{
            var _local3:XML;
            if (_arg1){
                _local3 = new XML(_arg2);
                if (((_local3.hasOwnProperty("mp")) && (_local3.hasOwnProperty("sg")))){
                    this.toSupportPage(_local3.mp, _local3.sg);
                };
            };
        }

        private function toSupportPage(_arg1:String, _arg2:String):void{
            var _local3:URLVariables = new URLVariables();
            var _local4:URLRequest = new URLRequest();
            var _local5:Boolean;
            _local3.mp = _arg1;
            _local3.sg = _arg2;
            if (((DynamicSettings.settingExists("SalesforceMobile")) && ((DynamicSettings.getSettingValue("SalesforceMobile") == 1)))){
                _local5 = true;
            };
            var _local6:String = this.playerModel.getSalesForceData();
            if ((((_local6 == "unavailable")) || (!(_local5)))){
                _local4.url = "https://decagames.desk.com/customer/authentication/multipass/callback";
                _local4.method = URLRequestMethod.GET;
                _local4.data = _local3;
                navigateToURL(_local4, "_blank");
            }
            else {
                if ((((Capabilities.playerType == "PlugIn")) || ((Capabilities.playerType == "ActiveX")))){
                    if (!supportCalledBefore){
                        ExternalInterface.call("openSalesForceFirstTime", _local6);
                        supportCalledBefore = true;
                    }
                    else {
                        ExternalInterface.call("reopenSalesForce");
                    };
                }
                else {
                    _local3.data = _local6;
                    _local4.url = "https://decagames.desk.com/customer/authentication/multipass/callback";
                    _local4.method = URLRequestMethod.GET;
                    _local4.data = _local3;
                    navigateToURL(_local4, "_blank");
                };
            };
        }

        private function onOptionalButtonsAdded():void{
            ((this.view.editorClicked) && (this.view.editorClicked.add(this.showMapEditor)));
            ((this.view.quitClicked) && (this.view.quitClicked.add(this.attemptToCloseClient)));
        }

        private function makeEnvironmentData():EnvironmentData{
            var _local1:EnvironmentData = new EnvironmentData();
            _local1.isDesktop = (Capabilities.playerType == "Desktop");
            _local1.canMapEdit = ((this.playerModel.isAdmin()) || (this.playerModel.mapEditor()));
            _local1.buildLabel = this.setup.getBuildLabel();
            return (_local1);
        }

        override public function destroy():void{
            this.view.playClicked.remove(this.handleIntentionToPlay);
            this.view.accountClicked.remove(this.handleIntentionToReviewAccount);
            this.view.legendsClicked.remove(this.showLegendsScreen);
            this.view.supportClicked.remove(this.openSupportPage);
            this.view.languagesClicked.remove(this.openLanguages)
            this.view.optionalButtonsAdded.remove(this.onOptionalButtonsAdded);
            ((this.view.editorClicked) && (this.view.editorClicked.remove(this.showMapEditor)));
            ((this.view.quitClicked) && (this.view.quitClicked.remove(this.attemptToCloseClient)));
        }

        private function handleIntentionToPlay():void{
            if (this.account.isRegistered()){
                this.enterGame.dispatch();
            }
            else {
                this.openAccountInfo.dispatch(false);
            };
        }

        private function handleIntentionToReviewAccount():void{
            this.openAccountInfo.dispatch(false);
        }

        private function showLegendsScreen():void{
            this.setScreen.dispatch(new LegendsView());
        }

        private function showMapEditor():void{
            this.setScreen.dispatch(new MapEditor());
        }

        private function attemptToCloseClient():void{
            dispatch(new Event("APP_CLOSE_EVENT"));
        }


    }
}//package kabam.rotmg.ui.view

