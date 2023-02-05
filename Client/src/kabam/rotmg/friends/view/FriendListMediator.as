// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.friends.view.FriendListMediator

package kabam.rotmg.friends.view{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.social.model.SocialModel;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import io.decagames.rotmg.social.signals.FriendActionSignal;
    import kabam.rotmg.chat.control.ShowChatInputSignal;
    import kabam.rotmg.ui.signals.EnterGameSignal;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.game.signals.PlayGameSignal;
    import com.company.assembleegameclient.ui.dialogs.ErrorDialog;
    import io.decagames.rotmg.social.config.FriendsActions;
    import io.decagames.rotmg.social.model.FriendRequestVO;
    import kabam.rotmg.text.model.TextKey;
    import com.company.assembleegameclient.appengine.SavedCharacter;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.game.model.GameInitData;

    public class FriendListMediator extends Mediator {

        [Inject]
        public var view:FriendListView;
        [Inject]
        public var model:SocialModel;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var closeDialog:CloseDialogsSignal;
        [Inject]
        public var actionSignal:FriendActionSignal;
        [Inject]
        public var chatSignal:ShowChatInputSignal;
        [Inject]
        public var enterGame:EnterGameSignal;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var playGame:PlayGameSignal;


        override public function initialize():void{
            this.view.actionSignal.add(this.onFriendActed);
            this.view.tabSignal.add(this.onTabSwitched);
            this.model.socialDataSignal.add(this.initView);
            this.model.loadFriendsData();
        }

        override public function destroy():void{
            this.view.actionSignal.removeAll();
            this.view.tabSignal.removeAll();
        }

        private function initView(_arg1:Boolean=false):void{
            if (_arg1){
                this.view.init(this.model.friendsList, this.model.getAllInvitations(), this.model.getCurrentServerName());
            }
        }

        private function reportError(_arg1:String):void{
            this.openDialog.dispatch(new ErrorDialog(_arg1));
        }

        private function onTabSwitched(_arg1:String):void{
            switch (_arg1){
                case FriendsActions.FRIEND_TAB:
                    this.view.updateFriendTab(this.model.friendsList, this.model.getCurrentServerName());
                    return;
                case FriendsActions.INVITE_TAB:
                    this.view.updateInvitationTab(this.model.getAllInvitations());
                    return;
            }
        }

        private function onFriendActed(_arg1:String, _arg2:String):void{
            var _local4:String;
            var _local5:String;
            var _local3:FriendRequestVO = new FriendRequestVO(_arg1, _arg2);
            switch (_arg1){
                case FriendsActions.SEARCH:
                    if (((!((_arg2 == null))) && (!((_arg2 == ""))))){
                        this.view.updateFriendTab(this.model.getFilterFriends(_arg2), this.model.getCurrentServerName());
                    }
                    else {
                        if (_arg2 == ""){
                            this.view.updateFriendTab(this.model.friendsList, this.model.getCurrentServerName());
                        }
                    }
                    return;
                case FriendsActions.INVITE:
                    if (this.model.ifReachMax()){
                        this.view.updateInput(TextKey.FRIEND_REACH_CAPACITY);
                        return;
                    }
                    _local3.callback = this.inviteFriendCallback;
                    break;
                case FriendsActions.REMOVE:
                    _local3.callback = this.removeFriendCallback;
                    _local4 = TextKey.FRIEND_REMOVE_TITLE;
                    _local5 = TextKey.FRIEND_REMOVE_TEXT;
                    this.openDialog.dispatch(new FriendUpdateConfirmDialog(_local4, _local5, TextKey.FRAME_CANCEL, TextKey.FRIEND_REMOVE_BUTTON, _local3, {name:_local3.target}));
                    return;
                case FriendsActions.ACCEPT:
                    _local3.callback = this.acceptInvitationCallback;
                    break;
                case FriendsActions.REJECT:
                    _local3.callback = this.rejectInvitationCallback;
                    break;
                case FriendsActions.BLOCK:
                    _local3.callback = this.blockInvitationCallback;
                    _local4 = TextKey.FRIEND_BLOCK_TITLE;
                    _local5 = TextKey.FRIEND_BLOCK_TEXT;
                    this.openDialog.dispatch(new FriendUpdateConfirmDialog(_local4, _local5, TextKey.FRAME_CANCEL, TextKey.FRIEND_BLOCK_BUTTON, _local3, {name:_local3.target}));
                    return;
                case FriendsActions.WHISPER:
                    this.whisperCallback(_arg2);
                    return;
                case FriendsActions.JUMP:
                    this.jumpCallback(_arg2);
                    return;
            }
            this.actionSignal.dispatch(_local3);
        }

        private function inviteFriendCallback(_arg1:Boolean, _arg2:String, _arg3:String):void{
            if (_arg1){
                this.view.updateInput(TextKey.FRIEND_SENT_INVITATION_TEXT, {name:_arg3});
            }
            else {
                if (_arg2 == "Blocked"){
                    this.view.updateInput(TextKey.FRIEND_SENT_INVITATION_TEXT, {name:_arg3});
                }
                else {
                    this.view.updateInput(_arg2);
                }
            }
        }

        private function removeFriendCallback(_arg1:Boolean, _arg2:String, _arg3:String):void{
            if (_arg1){
                this.model.removeFriend(_arg3);
            }
            else {
                this.reportError(_arg2);
            }
        }

        private function acceptInvitationCallback(_arg1:Boolean, _arg2:String, _arg3:String):void{
            if (_arg1){
                this.model.seedFriends(XML(_arg2));
                if (this.model.removeInvitation(_arg3)){
                    this.view.updateInvitationTab(this.model.getAllInvitations());
                }
            }
            else {
                this.reportError(_arg2);
            }
        }

        private function rejectInvitationCallback(_arg1:Boolean, _arg2:String, _arg3:String):void{
            if (_arg1){
                if (this.model.removeInvitation(_arg3)){
                    this.view.updateInvitationTab(this.model.getAllInvitations());
                }
            }
            else {
                this.reportError(_arg2);
            }
        }

        private function blockInvitationCallback(_arg1:String):void{
            this.model.removeInvitation(_arg1);
        }

        private function whisperCallback(_arg1:String):void{
            this.chatSignal.dispatch(true, (("/tell " + _arg1) + " "));
            this.view.getCloseSignal().dispatch();
        }

        private function jumpCallback(_arg1:String):void{
            var _local3:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
            Parameters.data_.preferredServer = _arg1;
            Parameters.save();
            this.enterGame.dispatch();
            var _local4:GameInitData = new GameInitData();
            _local4.createCharacter = false;
            _local4.charId = _local3.charId();
            _local4.isNewGame = true;
            this.playGame.dispatch(_local4);
            this.closeDialog.dispatch();
        }


    }
}//package kabam.rotmg.friends.view

