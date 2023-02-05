// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.social.SocialPopupMediator

package io.decagames.rotmg.social{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import kabam.rotmg.ui.model.HUDModel;
    import io.decagames.rotmg.social.model.SocialModel;
    import io.decagames.rotmg.social.signals.RefreshListSignal;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.popups.header.PopupHeader;
    import flash.events.KeyboardEvent;
    import io.decagames.rotmg.social.signals.SocialDataSignal;
    import io.decagames.rotmg.social.popups.InviteFriendPopup;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.social.model.FriendVO;
    import io.decagames.rotmg.social.widgets.FriendListItem;
    import io.decagames.rotmg.social.data.SocialItemState;
    import io.decagames.rotmg.social.config.SocialConfig;
    import io.decagames.rotmg.social.model.GuildMemberVO;
    import io.decagames.rotmg.social.model.GuildVO;
    import io.decagames.rotmg.social.widgets.GuildInfoItem;
    import io.decagames.rotmg.social.widgets.GuildListItem;
    import io.decagames.rotmg.social.widgets.*;

    public class SocialPopupMediator extends Mediator {

        [Inject]
        public var view:SocialPopupView;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var socialModel:SocialModel;
        [Inject]
        public var refreshSignal:RefreshListSignal;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        private var _isFriendsListLoaded:Boolean;
        private var _isGuildListLoaded:Boolean;
        private var closeButton:SliceScalingButton;
        private var addFriendToolTip:TextToolTip;
        private var hoverTooltipDelegate:HoverTooltipDelegate;


        override public function initialize():void{
            this.socialModel.socialDataSignal.add(this.onDataLoaded);
            this.view.tabs.tabSelectedSignal.add(this.onTabSelected);
            this.refreshSignal.add(this.refreshListHandler);
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.view.addButton.clickSignal.add(this.addButtonHandler);
            this.createAddButtonTooltip();
            this.view.search.addEventListener(KeyboardEvent.KEY_UP, this.onSearchHandler);
        }

        private function onTabSelected(_arg1:String):void{
            if (_arg1 == SocialPopupView.FRIEND_TAB_LABEL){
                if (!this._isFriendsListLoaded){
                    this.socialModel.loadFriendsData();
                }
            }
            else {
                if (_arg1 == SocialPopupView.GUILD_TAB_LABEL){
                    if (!this._isGuildListLoaded){
                        this.socialModel.loadGuildData();
                    }
                }
            }
        }

        private function onDataLoaded(_arg1:String, _arg2:Boolean, _arg3:String):void{
            switch (_arg1){
                case SocialDataSignal.FRIENDS_DATA_LOADED:
                    this.view.clearFriendsList();
                    if (_arg2){
                        this.showFriends();
                        this._isFriendsListLoaded = true;
                    }
                    else {
                        this._isFriendsListLoaded = false;
                        this.showError(_arg1, _arg3);
                    }
                    return;
                case SocialDataSignal.GUILD_DATA_LOADED:
                    this.view.clearGuildList();
                    this.showGuild();
                    this._isGuildListLoaded = true;
                    return;
            }
        }

        private function createAddButtonTooltip():void{
            this.addFriendToolTip = new TextToolTip(0x363636, 0x9B9B9B, "Add a friend", "Click to add a friend", 200);
            this.hoverTooltipDelegate = new HoverTooltipDelegate();
            this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
            this.hoverTooltipDelegate.setDisplayObject(this.view.addButton);
            this.hoverTooltipDelegate.tooltip = this.addFriendToolTip;
        }

        private function addButtonHandler(_arg1:BaseButton):void{
            this.showPopupSignal.dispatch(new InviteFriendPopup());
        }

        private function refreshListHandler(_arg1:String, _arg2:Boolean):void{
            if (_arg1 == RefreshListSignal.CONTEXT_FRIENDS_LIST){
                this.view.search.reset();
                this.view.clearFriendsList();
                this.showFriends();
            }
            else {
                if (_arg1 == RefreshListSignal.CONTEXT_GUILD_LIST){
                    this.view.clearGuildList();
                    this.showGuild();
                }
            }
        }

        private function onSearchHandler(_arg1:KeyboardEvent):void{
            this.view.clearFriendsList();
            this.showFriends(this.view.search.text);
        }

        override public function destroy():void{
            this.closeButton.dispose();
            this.refreshSignal.remove(this.refreshListHandler);
            this.view.addButton.clickSignal.remove(this.addButtonHandler);
            this.view.search.removeEventListener(KeyboardEvent.KEY_UP, this.onSearchHandler);
            this.addFriendToolTip = null;
            this.hoverTooltipDelegate.removeDisplayObject();
            this.hoverTooltipDelegate = null;
        }

        private function onClose(_arg1:BaseButton):void{
            this.closePopupSignal.dispatch(this.view);
        }

        private function showFriends(_arg1:String=""):void{
            var _local3:Vector.<FriendVO>;
            var _local4:FriendVO;
            var _local5:Vector.<FriendVO>;
            var _local6:int;
            var _local7:int;
            var _local8:int;
            var _local2 = !((_arg1 == ""));
            if (this.socialModel.hasInvitations){
                _local5 = this.socialModel.getAllInvitations();
                this.view.addFriendCategory((("Invitations (" + _local5.length) + ")"));
                _local6 = (((_local5.length > SocialPopupView.MAX_VISIBLE_INVITATIONS)) ? SocialPopupView.MAX_VISIBLE_INVITATIONS : _local5.length);
                _local7 = 0;
                while (_local7 < _local6) {
                    this.view.addInvites(new FriendListItem(_local5[_local7], SocialItemState.INVITE));
                    _local7++;
                }
                this.view.showInviteIndicator(true, SocialPopupView.FRIEND_TAB_LABEL);
            }
            else {
                this.view.showInviteIndicator(false, SocialPopupView.FRIEND_TAB_LABEL);
            }
            _local3 = ((_local2) ? this.socialModel.getFilterFriends(_arg1) : this.socialModel.friendsList);
            this.view.addFriendCategory((((("Friends (" + this.socialModel.numberOfFriends) + "/") + SocialConfig.MAX_FRIENDS) + ")"));
            for each (_local4 in _local3) {
                _local8 = ((_local4.isOnline) ? SocialItemState.ONLINE : SocialItemState.OFFLINE);
                this.view.addFriend(new FriendListItem(_local4, _local8));
            }
            this.view.addFriendCategory("");
        }

        private function showError(_arg1:String, _arg2:String):void{
            switch (_arg1){
                case SocialDataSignal.FRIENDS_DATA_LOADED:
                    this.view.addFriendCategory(("Error: " + _arg2));
                    return;
                case SocialDataSignal.FRIEND_INVITATIONS_LOADED:
                    this.view.addFriendCategory(("Invitation Error: " + _arg2));
                    return;
            }
        }

        private function showGuild():void{
            var _local4:Vector.<GuildMemberVO>;
            var _local5:int;
            var _local6:int;
            var _local7:GuildMemberVO;
            var _local8:int;
            var _local1:GuildVO = this.socialModel.guildVO;
            var _local2:String = ((_local1) ? _local1.guildName : "No Guild");
            var _local3:int = ((_local1) ? _local1.guildTotalFame : 0);
            this.view.addGuildInfo(new GuildInfoItem(_local2, _local3));
            if (((_local1) && ((this.socialModel.numberOfGuildMembers > 0)))){
                this.view.addGuildCategory((((("Guild Members (" + this.socialModel.numberOfGuildMembers) + "/") + 50) + ")"));
                _local4 = _local1.guildMembers;
                _local5 = _local4.length;
                _local6 = 0;
                while (_local6 < _local5) {
                    _local7 = _local4[_local6];
                    _local8 = ((_local7.isOnline) ? SocialItemState.ONLINE : SocialItemState.OFFLINE);
                    this.view.addGuildMember(new GuildListItem(_local7, _local8, _local1.myRank));
                    _local6++;
                }
                this.view.addGuildCategory("");
            }
            else {
                this.view.addGuildDefaultMessage(SocialPopupView.DEFAULT_NO_GUILD_MESSAGE);
            }
        }


    }
}//package io.decagames.rotmg.social

