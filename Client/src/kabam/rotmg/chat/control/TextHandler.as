﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.chat.control.TextHandler

package kabam.rotmg.chat.control{
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.game.model.GameModel;
    import kabam.rotmg.game.signals.AddTextLineSignal;
    import kabam.rotmg.game.signals.AddSpeechBalloonSignal;
    import kabam.rotmg.language.model.StringMap;
    import kabam.rotmg.chat.model.TellModel;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.ui.model.HUDModel;
    import io.decagames.rotmg.social.model.SocialModel;
    import kabam.rotmg.application.api.ApplicationSetup;
    import kabam.rotmg.ui.signals.RealmServerNameSignal;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.chat.model.ChatMessage;
    import com.company.assembleegameclient.objects.TextureDataConcrete;
    import kabam.rotmg.account.core.view.ConfirmEmailModal;
    import kabam.rotmg.news.view.NewsTicker;
    import kabam.rotmg.fortune.services.FortuneModel;
    import kabam.rotmg.messaging.impl.incoming.Text;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.servers.api.ServerModel;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.game.model.AddSpeechBalloonVO;
    import com.company.assembleegameclient.objects.GameObject;
    import kabam.rotmg.chat.view.ChatListItemFactory;

    public class TextHandler {

        private const NORMAL_SPEECH_COLORS:TextColors = new TextColors(14802908, 0xFFFFFF, 0x545454);
        private const ENEMY_SPEECH_COLORS:TextColors = new TextColors(5644060, 16549442, 13484223);
        private const TELL_SPEECH_COLORS:TextColors = new TextColors(2493110, 61695, 13880567);
        private const GUILD_SPEECH_COLORS:TextColors = new TextColors(0x3E8A00, 10944349, 13891532);

        [Inject]
        public var account:Account;
        [Inject]
        public var model:GameModel;
        [Inject]
        public var addTextLine:AddTextLineSignal;
        [Inject]
        public var addSpeechBalloon:AddSpeechBalloonSignal;
        [Inject]
        public var stringMap:StringMap;
        [Inject]
        public var tellModel:TellModel;
        [Inject]
        public var spamFilter:SpamFilter;
        [Inject]
        public var openDialogSignal:OpenDialogSignal;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var socialModel:SocialModel;
        [Inject]
        public var setup:ApplicationSetup;
        [Inject]
        public var realmServerNameSignal:RealmServerNameSignal;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;


        public function execute(_arg1:Text):void{
            var _local5:String;
            var _local6:String;
            var _local7:String;
            var _local2 = (_arg1.numStars_ == -1);
            var _local3:Boolean = ((((!((_arg1.name_ == this.model.player.name_))) && (!(_local2)))) && (!(this.isSpecialRecipientChat(_arg1.recipient_))));
            var _local4:Boolean = Boolean(this.seasonalEventModel.isChallenger);
            if (((((!(_local4)) && ((_arg1.numStars_ < Parameters.data_.chatStarRequirement)))) && (_local3))){
                return;
            };
            if (((((!((_arg1.recipient_ == ""))) && (Parameters.data_.chatFriend))) && (!(this.socialModel.isMyFriend(_arg1.recipient_))))){
                return;
            };
            if (((!(Parameters.data_.chatAll)) && (_local3))){
                if (!(((_arg1.recipient_ == Parameters.GUILD_CHAT_NAME)) && (Parameters.data_.chatGuild))){
                    if (!((((((!(_local4)) && ((_arg1.numStars_ < Parameters.data_.chatStarRequirement)))) && (!((_arg1.recipient_ == ""))))) && (Parameters.data_.chatWhisper))){
                        if (!((((_local4) && (!((_arg1.recipient_ == ""))))) && (Parameters.data_.chatWhisper))){
                            return;
                        };
                    };
                };
            };
            if (this.useCleanString(_arg1)){
                _local5 = _arg1.cleanText_;
                _arg1.cleanText_ = this.replaceIfSlashServerCommand(_arg1.cleanText_);
            }
            else {
                _local5 = _arg1.text_;
                _arg1.text_ = this.replaceIfSlashServerCommand(_arg1.text_);
            };
            if (((_local2) && (this.isToBeLocalized(_local5)))){
                _local5 = this.getLocalizedString(_local5);
            };
            if (((!(_local2)) && (this.spamFilter.isSpam(_local5)))){
                if (_arg1.name_ == this.model.player.name_){
                    this.addTextLine.dispatch(ChatMessage.make(Parameters.ERROR_CHAT_NAME, "This message has been flagged as spam."));
                };
                return;
            };
            if (_arg1.recipient_){
                if (((!((_arg1.recipient_ == this.model.player.name_))) && (!(this.isSpecialRecipientChat(_arg1.recipient_))))){
                    this.tellModel.push(_arg1.recipient_);
                    this.tellModel.resetRecipients();
                }
                else {
                    if (_arg1.recipient_ == this.model.player.name_){
                        this.tellModel.push(_arg1.name_);
                        this.tellModel.resetRecipients();
                    };
                };
            };
            if (((_local2) && ((TextureDataConcrete.remoteTexturesUsed == true)))){
                TextureDataConcrete.remoteTexturesUsed = false;
                if (this.setup.isServerLocal()){
                    _local6 = _arg1.name_;
                    _local7 = _arg1.text_;
                    _arg1.name_ = "";
                    _arg1.text_ = "Remote Textures used in this build";
                    this.addTextAsTextLine(_arg1);
                    _arg1.name_ = _local6;
                    _arg1.text_ = _local7;
                };
            };
            if (_local2){
                if ((((((((_arg1.text_ == "Please verify your email before chat")) && (!((this.hudModel == null))))) && ((this.hudModel.gameSprite.map.name_ == "Nexus")))) && (!((this.openDialogSignal == null))))){
                    this.openDialogSignal.dispatch(new ConfirmEmailModal());
                }
                else {
                    if (_arg1.name_ == "@ANNOUNCEMENT"){
                        if (((((!((this.hudModel == null))) && (!((this.hudModel.gameSprite == null))))) && (!((this.hudModel.gameSprite.newsTicker == null))))){
                            this.hudModel.gameSprite.newsTicker.activateNewScrollText(_arg1.text_);
                        }
                        else {
                            NewsTicker.setPendingScrollText(_arg1.text_);
                        };
                    }
                    else {
                        if ((((_arg1.name_ == "#{objects.ft_shopkeep}")) && (!(FortuneModel.HAS_FORTUNES)))){
                            return;
                        };
                    };
                };
            };
            if (_arg1.objectId_ >= 0){
                this.showSpeechBaloon(_arg1, _local5);
            };
            if (((_local2) || (((this.account.isRegistered()) && (((!(Parameters.data_["hidePlayerChat"])) || (this.isSpecialRecipientChat(_arg1.name_)))))))){
                if (((_local2) && (!((_arg1.text_.search("NexusPortal.") == -1))))){
                    this.dispatchServerName(_arg1.text_);
                };
                this.addTextAsTextLine(_arg1);
            };
        }

        private function isSpecialRecipientChat(_arg1:String):Boolean{
            return ((((_arg1.length > 0)) && ((((_arg1.charAt(0) == "#")) || ((_arg1.charAt(0) == "*"))))));
        }

        public function addTextAsTextLine(_arg1:Text):void{
            var _local2:ChatMessage = new ChatMessage();
            _local2.name = _arg1.name_;
            _local2.objectId = _arg1.objectId_;
            _local2.numStars = _arg1.numStars_;
            _local2.recipient = _arg1.recipient_;
            _local2.isWhisper = ((_arg1.recipient_) && (!(this.isSpecialRecipientChat(_arg1.recipient_))));
            _local2.isToMe = (_arg1.recipient_ == this.model.player.name_);
            _local2.isFromSupporter = _arg1.isSupporter;
            _local2.starBg = _arg1.starBg;
            this.addMessageText(_arg1, _local2);
            this.addTextLine.dispatch(_local2);
        }

        public function addMessageText(_arg1:Text, _arg2:ChatMessage):void{
            var lb:LineBuilder;
            var text:Text = _arg1;
            var message:ChatMessage = _arg2;
            try {
                lb = LineBuilder.fromJSON(text.text_);
                message.text = lb.key;
                message.tokens = lb.tokens;
            }
            catch(error:Error) {
                message.text = ((useCleanString(text)) ? text.cleanText_ : text.text_);
            };
        }

        private function dispatchServerName(_arg1:String):void{
            var _local2:String = _arg1.substring((_arg1.indexOf(".") + 1));
            this.realmServerNameSignal.dispatch(_local2);
        }

        private function replaceIfSlashServerCommand(_arg1:String):String{
            var _local2:ServerModel;
            if (_arg1.substr(0, 7) == "74026S9"){
                _local2 = StaticInjectorContext.getInjector().getInstance(ServerModel);
                if (((_local2) && (_local2.getServer()))){
                    return (_arg1.replace("74026S9", (_local2.getServer().name + ", ")));
                };
            };
            return (_arg1);
        }

        private function isToBeLocalized(_arg1:String):Boolean{
            return ((((_arg1.charAt(0) == "{")) && ((_arg1.charAt((_arg1.length - 1)) == "}"))));
        }

        private function getLocalizedString(_arg1:String):String{
            var _local2:LineBuilder = LineBuilder.fromJSON(_arg1);
            _local2.setStringMap(this.stringMap);
            return (_local2.getString());
        }

        private function showSpeechBaloon(_arg1:Text, _arg2:String):void{
            var _local4:TextColors;
            var _local5:Boolean;
            var _local6:Boolean;
            var _local7:AddSpeechBalloonVO;
            var _local3:GameObject = this.model.getGameObject(_arg1.objectId_);
            if (_local3 != null){
                _local4 = this.getColors(_arg1, _local3);
                _local5 = ChatListItemFactory.isTradeMessage(_arg1.numStars_, _arg1.objectId_, _arg2);
                _local6 = ChatListItemFactory.isGuildMessage(_arg1.name_);
                _local7 = new AddSpeechBalloonVO(_local3, _arg2, _arg1.name_, _local5, _local6, _local4.back, 1, _local4.outline, 1, _local4.text, _arg1.bubbleTime_, false, true);
                this.addSpeechBalloon.dispatch(_local7);
            };
        }

        private function getColors(_arg1:Text, _arg2:GameObject):TextColors{
            if (_arg2.props_.isEnemy_){
                return (this.ENEMY_SPEECH_COLORS);
            };
            if (_arg1.recipient_ == Parameters.GUILD_CHAT_NAME){
                return (this.GUILD_SPEECH_COLORS);
            };
            if (_arg1.recipient_ != ""){
                return (this.TELL_SPEECH_COLORS);
            };
            return (this.NORMAL_SPEECH_COLORS);
        }

        private function useCleanString(_arg1:Text):Boolean{
            return (((((Parameters.data_.filterLanguage) && ((_arg1.cleanText_.length > 0)))) && (!((_arg1.objectId_ == this.model.player.objectId_)))));
        }


    }
}//package kabam.rotmg.chat.control

