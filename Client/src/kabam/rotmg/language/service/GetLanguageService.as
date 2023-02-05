﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.language.service.GetLanguageService

package kabam.rotmg.language.service{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.language.model.LanguageModel;
    import kabam.rotmg.language.model.StringMap;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
    import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

    public class GetLanguageService extends BaseTask {

        private static const LANGUAGE:String = "LANGUAGE";

        [Inject]
        public var model:LanguageModel;
        [Inject]
        public var strings:StringMap;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var client:AppEngineClient;
        private var language:String;


        override protected function startTask():void{
            this.language = this.model.getLanguageFamily();
            this.client.complete.addOnce(this.onComplete);
            this.client.setMaxRetries(3);
            this.client.sendRequest("/app/getLanguageStrings", {languageType:this.language});
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            if (_arg1){
                this.onLanguageResponse(_arg2);
            }
            else {
                this.onLanguageError();
            }
            completeTask(_arg1, _arg2);
        }

        private function onLanguageResponse(_arg1:String):void{
            var _local3:Array;
            this.strings.clear();
            var _local2:Object = JSON.parse(_arg1);
            for each (_local3 in _local2) {
                this.strings.setValue(_local3[0], _local3[1], _local3[2]);
            }
            PetRarityEnum.parseNames();
        }

        private function onLanguageError():void{
            this.strings.setValue("ErrorWindow.buttonOK", "OK", this.model.getLanguageFamily());
            var _local1:ErrorDialog = new ErrorDialog((("Unable to load language [" + this.language) + "]"));
            this.openDialog.dispatch(_local1);
            completeTask(false);
        }
    }
}//package kabam.rotmg.language.service

