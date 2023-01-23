﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.fame.service.RequestCharacterFameTask

package kabam.rotmg.fame.service{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.classes.model.ClassesModel;
    import kabam.rotmg.assets.model.CharacterTemplate;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import kabam.rotmg.classes.model.CharacterClass;
    import kabam.rotmg.classes.model.CharacterSkin;
    import com.company.util.DateFormatterReplacement;
    import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

    public class RequestCharacterFameTask extends BaseTask {

        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var classes:ClassesModel;
        public var accountId:String;
        public var charId:int;
        public var xml:XML;
        public var name:String;
        public var level:int;
        public var type:int;
        public var deathDate:String;
        public var killer:String;
        public var totalFame:int;
        public var template:CharacterTemplate;
        public var texture1:int;
        public var texture2:int;
        public var size:int;
        public var timer:Timer;
        private var errorRetry:Boolean = false;

        public function RequestCharacterFameTask(){
            this.timer = new Timer(150);
            super();
        }

        override protected function startTask():void{
            this.timer.addEventListener(TimerEvent.TIMER, this.sendFameRequest);
            this.timer.start();
        }

        private function sendFameRequest(_arg1:TimerEvent):void{
            this.client.setMaxRetries(8);
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("char/fame", this.getDataPacket());
            this.timer.removeEventListener(TimerEvent.TIMER, this.sendFameRequest);
            this.timer.stop();
            this.timer = null;
        }

        private function getDataPacket():Object{
            var _local1:Object = {};
            _local1.accountId = this.accountId;
            _local1.charId = (((this.accountId == "")) ? -1 : this.charId);
            return (_local1);
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            if (_arg1){
                this.parseFameData(_arg2);
            }
            else {
                this.onFameError(_arg2);
            };
        }

        private function parseFameData(_arg1:String):void{
            this.xml = new XML(_arg1);
            this.parseXML();
            completeTask(true);
        }

        private function parseXML():void{
            var charXml:XML;
            var char:CharacterClass;
            var skin:CharacterSkin;
            charXml = this.xml.Char.(@id == charId)[0];
            this.name = charXml.Account.Name;
            this.level = charXml.Level;
            this.type = charXml.ObjectType;
            this.deathDate = this.getDeathDate();
            this.killer = ((this.xml.KilledBy) || (""));
            this.totalFame = this.xml.TotalFame;
            char = this.classes.getCharacterClass(charXml.ObjectType);
            skin = ((charXml.hasOwnProperty("Texture")) ? char.skins.getSkin(charXml.Texture) : char.skins.getDefaultSkin());
            this.template = skin.template;
            this.texture1 = ((charXml.hasOwnProperty("Tex1")) ? charXml.Tex1 : 0);
            this.texture2 = ((charXml.hasOwnProperty("Tex2")) ? charXml.Tex2 : 0);
            this.size = ((skin.is16x16) ? 140 : 250);
        }

        private function getDeathDate():String{
            var _local1:Number = (Number(this.xml.CreatedOn) * 1000);
            var _local2:Date = new Date(_local1);
            var _local3:DateFormatterReplacement = new DateFormatterReplacement();
            _local3.formatString = "MMMM D, YYYY";
            return (_local3.format(_local2));
        }

        private function onFameError(_arg1:String):void{
            if (this.errorRetry == false){
                this.errorRetry = true;
                this.timer = new Timer(600);
                this.timer.addEventListener(TimerEvent.TIMER, this.sendFameRequest);
                this.timer.start();
            }
            else {
                this.errorRetry = false;
                this.openDialog.dispatch(new ErrorDialog(_arg1));
            };
        }


    }
}//package kabam.rotmg.fame.service

