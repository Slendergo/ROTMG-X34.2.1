﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.chat.view.ChatListItemFactory

package kabam.rotmg.chat.view{
    import flash.geom.Matrix;
    import com.company.assembleegameclient.parameters.Parameters;
    import flash.text.TextField;
    import kabam.rotmg.text.view.BitmapTextFactory;
    import kabam.rotmg.chat.model.ChatModel;
    import kabam.rotmg.text.model.FontModel;
    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
    import com.company.assembleegameclient.util.StageProxy;
    import kabam.rotmg.chat.model.ChatMessage;
    import flash.display.DisplayObject;
    import flash.text.TextFormat;
    import com.company.assembleegameclient.util.FameUtil;
    import kabam.rotmg.text.view.stringBuilder.StringBuilder;
    import flash.display.BitmapData;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import flash.display.Bitmap;
    import flash.display.StageQuality;

    public class ChatListItemFactory {

        private static const IDENTITY_MATRIX:Matrix = new Matrix();
        private static const SERVER:String = Parameters.SERVER_CHAT_NAME;
        private static const CLIENT:String = Parameters.CLIENT_CHAT_NAME;
        private static const HELP:String = Parameters.HELP_CHAT_NAME;
        private static const ERROR:String = Parameters.ERROR_CHAT_NAME;
        private static const GUILD:String = Parameters.GUILD_CHAT_NAME;
        private static const testField:TextField = makeTestTextField();

        [Inject]
        public var factory:BitmapTextFactory;
        [Inject]
        public var model:ChatModel;
        [Inject]
        public var fontModel:FontModel;
        [Inject]
        public var supporterCampaignModel:SupporterCampaignModel;
        [Inject]
        public var stageProxy:StageProxy;
        private var message:ChatMessage;
        private var buffer:Vector.<DisplayObject>;


        public static function isTradeMessage(_arg1:int, _arg2:int, _arg3:String):Boolean{
            return ((((((_arg1 == -1)) || ((_arg2 == -1)))) && (!((_arg3.search("/trade") == -1)))));
        }

        public static function isGuildMessage(_arg1:String):Boolean{
            return ((_arg1 == GUILD));
        }

        private static function makeTestTextField():TextField{
            var _local1:TextField = new TextField();
            var _local2:TextFormat = new TextFormat();
            _local2.size = 15;
            _local2.bold = true;
            _local1.defaultTextFormat = _local2;
            return (_local1);
        }


        public function make(_arg1:ChatMessage, _arg2:Boolean=false):ChatListItem{
            var _local5:int;
            var _local7:String;
            var _local8:int;
            this.message = _arg1;
            this.buffer = new Vector.<DisplayObject>();
            this.setTFonTestField();
            this.makeStarsIcon();
            this.makeWhisperText();
            this.makeNameText();
            this.makeMessageText();
            var _local3:Boolean = (((_arg1.numStars == -1)) || ((_arg1.objectId == -1)));
            var _local4:Boolean;
            var _local6:String = _arg1.name;
            if (((_local3) && (!(((_local5 = _arg1.text.search("/trade ")) == -1))))){
                _local5 = (_local5 + 7);
                _local7 = "";
                _local8 = _local5;
                while (_local8 < (_local5 + 10)) {
                    if (_arg1.text.charAt(_local8) == '"') break;
                    _local7 = (_local7 + _arg1.text.charAt(_local8));
                    _local8++;
                }
                _local6 = _local7;
                _local4 = true;
            }
            return (new ChatListItem(this.buffer, this.model.bounds.width, this.model.lineHeight, _arg2, _arg1.objectId, _local6, (_arg1.recipient == GUILD), _local4));
        }

        private function makeStarsIcon():void{
            var _local1:int = this.message.numStars;
            if (_local1 >= 0){
                this.buffer.push(FameUtil.numStarsToIcon(_local1));
            }
        }

        private function makeWhisperText():void{
            var _local1:StringBuilder;
            var _local2:BitmapData;
            if (((this.message.isWhisper) && (!(this.message.isToMe)))){
                _local1 = new StaticStringBuilder("To: ");
                _local2 = this.getBitmapData(_local1, 61695);
                this.buffer.push(new Bitmap(_local2));
            }
        }

        private function makeNameText():void{
            if (!this.isSpecialMessageType()){
                this.bufferNameText();
            }
        }

        private function isSpecialMessageType():Boolean{
            var _local1:String = this.message.name;
            return ((((((((((_local1 == SERVER)) || ((_local1 == CLIENT)))) || ((_local1 == HELP)))) || ((_local1 == ERROR)))) || ((_local1 == GUILD))));
        }

        private function bufferNameText():void{
            var _local1:StringBuilder = new StaticStringBuilder(this.processName());
            var _local2:BitmapData = this.getBitmapData(_local1, this.getNameColor());
            this.buffer.push(new Bitmap(_local2));
        }

        private function processName():String{
            var _local1:String = ((((this.message.isWhisper) && (!(this.message.isToMe)))) ? this.message.recipient : this.message.name);
            if ((((_local1.charAt(0) == "#")) || ((_local1.charAt(0) == "@")))){
                _local1 = _local1.substr(1);
            }
            return ((("<" + _local1) + ">"));
        }

        private function makeMessageText():void{
            var _local2:int;
            var _local1:Array = this.message.text.split("\n");
            if (_local1.length > 0){
                this.makeNewLineFreeMessageText(_local1[0], true);
                _local2 = 1;
                while (_local2 < _local1.length) {
                    this.makeNewLineFreeMessageText(_local1[_local2], false);
                    _local2++;
                }
            }
        }

        private function makeNewLineFreeMessageText(_arg1:String, _arg2:Boolean):void{
            var _local7:DisplayObject;
            var _local8:int;
            var _local9:uint;
            var _local10:int;
            var _local11:int;
            var _local3:String = _arg1;
            var _local4:int;
            var _local5:int;
            if (_arg2){
                for each (_local7 in this.buffer) {
                    _local4 = (_local4 + _local7.width);
                }
                _local5 = _local3.length;
                testField.text = _local3;
                while (testField.textWidth >= (this.model.bounds.width - _local4)) {
                    _local5 = (_local5 - 10);
                    testField.text = _local3.substr(0, _local5);
                }
                if (_local5 < _local3.length){
                    _local8 = _local3.substr(0, _local5).lastIndexOf(" ");
                    _local5 = (((((_local8 == 0)) || ((_local8 == -1)))) ? _local5 : (_local8 + 1));
                }
                this.makeMessageLine(_local3.substr(0, _local5));
            }
            var _local6:int = _local3.length;
            if (_local6 > _local5){
                _local9 = _local3.length;
                _local10 = _local5;
                while (_local10 < _local3.length) {
                    testField.text = _local3.substr(_local10, _local9);
                    while (testField.textWidth >= this.model.bounds.width) {
                        _local9 = (_local9 - 2);
                        testField.text = _local3.substr(_local10, _local9);
                    }
                    _local11 = _local9;
                    if (_local3.length > (_local10 + _local9)){
                        _local11 = _local3.substr(_local10, _local9).lastIndexOf(" ");
                        _local11 = (((((_local11 == 0)) || ((_local11 == -1)))) ? _local9 : (_local11 + 1));
                    }
                    this.makeMessageLine(_local3.substr(_local10, _local11));
                    _local10 = (_local10 + _local11);
                }
            }
        }

        private function makeMessageLine(_arg1:String):void{
            var _local2:StringBuilder = new StaticStringBuilder(_arg1);
            var _local3:BitmapData = this.getBitmapData(_local2, this.getTextColor());
            this.buffer.push(new Bitmap(_local3));
        }

        private function getNameColor():uint{
            if (this.message.name.charAt(0) == "#"){
                return (0xFFA800);
            }
            if (this.message.name.charAt(0) == "@"){
                return (0xFFFF00);
            }
            if (this.message.recipient == GUILD){
                return (10944349);
            }
            if (this.message.recipient != ""){
                return (61695);
            }
            if (this.message.isFromSupporter){
                return (SupporterCampaignModel.SUPPORT_COLOR);
            }
            return (0xFF00);
        }

        private function getTextColor():uint{
            var _local1:String = this.message.name;
            if (_local1 == SERVER){
                return (0xFFFF00);
            }
            if (_local1 == CLIENT){
                return (0xFF);
            }
            if (_local1 == HELP){
                return (16734981);
            }
            if (_local1 == ERROR){
                return (0xFF0000);
            }
            if (_local1.charAt(0) == "@"){
                return (0xFFFF00);
            }
            if (this.message.recipient == GUILD){
                return (10944349);
            }
            if (this.message.recipient != ""){
                return (61695);
            }
            return (0xFFFFFF);
        }

        private function getBitmapData(_arg1:StringBuilder, _arg2:uint):BitmapData{
            var _local3:String = this.stageProxy.getQuality();
            var _local4:Boolean = Parameters.data_["forceChatQuality"];
            ((_local4) && (this.stageProxy.setQuality(StageQuality.HIGH)));
            var _local5:BitmapData = this.factory.make(_arg1, 14, _arg2, true, IDENTITY_MATRIX, true);
            ((_local4) && (this.stageProxy.setQuality(_local3)));
            return (_local5);
        }

        private function setTFonTestField():void{
            var _local1:TextFormat = testField.getTextFormat();
            _local1.font = this.fontModel.getFont().getName();
            testField.defaultTextFormat = _local1;
        }


    }
}//package kabam.rotmg.chat.view

