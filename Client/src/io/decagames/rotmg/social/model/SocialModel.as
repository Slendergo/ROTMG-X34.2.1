// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.social.model.SocialModel

package io.decagames.rotmg.social.model{
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.servers.api.ServerModel;
    import io.decagames.rotmg.social.tasks.FriendDataRequestTask;
    import io.decagames.rotmg.social.tasks.GuildDataRequestTask;
    import io.decagames.rotmg.social.signals.SocialDataSignal;
    import org.osflash.signals.Signal;
    import flash.utils.Dictionary;
    import kabam.rotmg.servers.api.Server;
    import io.decagames.rotmg.social.config.FriendsActions;
    import io.decagames.rotmg.social.config.GuildActions;
    import com.company.assembleegameclient.objects.Player;
    import io.decagames.rotmg.social.config.SocialConfig;
    import kabam.lib.tasks.BaseTask;
    import io.decagames.rotmg.social.tasks.ISocialTask;
    import com.company.assembleegameclient.util.TimeUtil;
    import com.company.assembleegameclient.util.FameUtil;
    import com.company.assembleegameclient.parameters.Parameters;

    public class SocialModel {

        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var serverModel:ServerModel;
        [Inject]
        public var friendsDataRequest:FriendDataRequestTask;
        [Inject]
        public var guildDataRequest:GuildDataRequestTask;
        public var socialDataSignal:SocialDataSignal;
        public var noInvitationSignal:Signal;
        private var _friendsList:Vector.<FriendVO>;
        private var _onlineFriends:Vector.<FriendVO>;
        private var _offlineFriends:Vector.<FriendVO>;
        private var _onlineFilteredFriends:Vector.<FriendVO>;
        private var _offlineFilteredFriends:Vector.<FriendVO>;
        private var _onlineGuildMembers:Vector.<GuildMemberVO>;
        private var _offlineGuildMembers:Vector.<GuildMemberVO>;
        private var _guildMembers:Vector.<GuildMemberVO>;
        private var _friends:Dictionary;
        private var _invitations:Dictionary;
        private var _friendsLoadInProcess:Boolean;
        private var _invitationsLoadInProgress:Boolean;
        private var _guildLoadInProgress:Boolean;
        private var _numberOfFriends:int;
        private var _numberOfGuildMembers:int;
        private var _numberOfInvitation:int;
        private var _isFriDataOK:Boolean;
        private var _serverDict:Dictionary;
        private var _currentServer:Server;
        private var _guildVO:GuildVO;

        public function SocialModel(){
            this.socialDataSignal = new SocialDataSignal();
            this.noInvitationSignal = new Signal();
            super();
            this._initSocialModel();
        }

        public function setCurrentServer(_arg1:Server):void{
            this._currentServer = _arg1;
        }

        public function getCurrentServerName():String{
            var _local1:String = ((this._currentServer) ? this._currentServer.name : "");
            return (_local1);
        }

        public function loadFriendsData():void{
            if (((this._friendsLoadInProcess) || (this._invitationsLoadInProgress))){
                return;
            }
            this._friendsLoadInProcess = true;
            this._invitationsLoadInProgress = true;
            this.loadList(this.friendsDataRequest, FriendsActions.getURL(FriendsActions.FRIEND_LIST), this.onFriendListResponse);
        }

        public function loadInvitations():void{
            if (((this._friendsLoadInProcess) || (this._invitationsLoadInProgress))){
                return;
            }
            this._invitationsLoadInProgress = true;
            this.loadList(this.friendsDataRequest, FriendsActions.getURL(FriendsActions.INVITE_LIST), this.onInvitationListResponse);
        }

        public function loadGuildData():void{
            if (this._guildLoadInProgress){
                return;
            }
            this._guildLoadInProgress = true;
            this.loadList(this.guildDataRequest, GuildActions.getURL(GuildActions.GUILD_LIST), this.onGuildListResponse);
        }

        public function seedFriends(_arg1:XML):void{
            var _local2:String;
            var _local3:String;
            var _local4:String;
            var _local5:FriendVO;
            var _local6:XML;
            this._onlineFriends.length = 0;
            this._offlineFriends.length = 0;
            for each (_local6 in _arg1.Account) {
                try {
                    _local2 = _local6.Name;
                    _local5 = (((this._friends[_local2])!=null) ? (this._friends[_local2].vo as FriendVO) : new FriendVO(Player.fromPlayerXML(_local2, _local6.Character[0])));
                    if (_local6.hasOwnProperty("Online")){
                        _local4 = String(_local6.Online);
                        _local3 = this.serverNameDictionary()[_local4];
                        _local5.online(_local3, _local4);
                        this._onlineFriends.push(_local5);
                        this._friends[_local5.getName()] = {
                            vo:_local5,
                            list:this._onlineFriends
                        }
                    }
                    else {
                        _local5.offline();
                        _local5.lastLogin = this.getLastLoginInSeconds(_local6.LastLogin);
                        this._offlineFriends.push(_local5);
                        this._friends[_local5.getName()] = {
                            vo:_local5,
                            list:this._offlineFriends
                        }
                    }
                }
                catch(error:Error) {
                }
            }
            this._onlineFriends.sort(this.sortFriend);
            this._offlineFriends.sort(this.sortFriend);
            this.updateFriendsList();
        }

        public function isMyFriend(_arg1:String):Boolean{
            return (!((this._friends[_arg1] == null)));
        }

        public function updateFriendVO(_arg1:String, _arg2:Player):void{
            var _local3:Object;
            var _local4:FriendVO;
            if (this.isMyFriend(_arg1)){
                _local3 = this._friends[_arg1];
                _local4 = (_local3.vo as FriendVO);
                _local4.updatePlayer(_arg2);
            }
        }

        public function getFilterFriends(_arg1:String):Vector.<FriendVO>{
            var _local3:FriendVO;
            var _local2:RegExp = new RegExp(_arg1, "gix");
            this._onlineFilteredFriends.length = 0;
            this._offlineFilteredFriends.length = 0;
            var _local4:int;
            while (_local4 < this._onlineFriends.length) {
                _local3 = this._onlineFriends[_local4];
                if (_local3.getName().search(_local2) >= 0){
                    this._onlineFilteredFriends.push(_local3);
                }
                _local4++;
            }
            _local4 = 0;
            while (_local4 < this._offlineFriends.length) {
                _local3 = this._offlineFriends[_local4];
                if (_local3.getName().search(_local2) >= 0){
                    this._offlineFilteredFriends.push(_local3);
                }
                _local4++;
            }
            this._onlineFilteredFriends.sort(this.sortFriend);
            this._offlineFilteredFriends.sort(this.sortFriend);
            return (this._onlineFilteredFriends.concat(this._offlineFilteredFriends));
        }

        public function ifReachMax():Boolean{
            return ((this._numberOfFriends >= SocialConfig.MAX_FRIENDS));
        }

        public function getAllInvitations():Vector.<FriendVO>{
            var _local2:FriendVO;
            var _local1:Vector.<FriendVO> = new Vector.<FriendVO>();
            for each (_local2 in this._invitations) {
                _local1.push(_local2);
            }
            _local1.sort(this.sortFriend);
            return (_local1);
        }

        public function removeFriend(_arg1:String):Boolean{
            var _local2:Object = this._friends[_arg1];
            if (_local2){
                this.removeFriendFromList(_arg1);
                this.removeFromList(_local2.list, _arg1);
                this._friends[_arg1] = null;
                delete this._friends[_arg1];
                return true;
            }
            return false;
        }

        public function removeInvitation(_arg1:String):Boolean{
            if (this._invitations[_arg1] != null){
                this._invitations[_arg1] = null;
                delete this._invitations[_arg1];
                this._numberOfInvitation--;
                if (this._numberOfInvitation == 0){
                    this.noInvitationSignal.dispatch();
                }
                return true;
            }
            return false;
        }

        public function removeGuildMember(_arg1:String):void{
            var _local2:GuildMemberVO;
            for each (_local2 in this._onlineGuildMembers) {
                if (_local2.name == _arg1){
                    this._onlineGuildMembers.splice(this._onlineGuildMembers.indexOf(_local2), 1);
                    break;
                }
            }
            for each (_local2 in this._offlineGuildMembers) {
                if (_local2.name == _arg1){
                    this._offlineGuildMembers.splice(this._offlineGuildMembers.indexOf(_local2), 1);
                    break;
                }
            }
            this.updateGuildData();
        }

        private function _initSocialModel():void{
            this._numberOfFriends = 0;
            this._numberOfInvitation = 0;
            this._friends = new Dictionary(true);
            this._onlineFriends = new <FriendVO>[];
            this._offlineFriends = new <FriendVO>[];
            this._onlineFilteredFriends = new <FriendVO>[];
            this._offlineFilteredFriends = new <FriendVO>[];
            this._onlineGuildMembers = new <GuildMemberVO>[];
            this._offlineGuildMembers = new <GuildMemberVO>[];
            this._friendsLoadInProcess = false;
            this._invitationsLoadInProgress = false;
            this._guildLoadInProgress = false;
        }

        private function loadList(_arg1:ISocialTask, _arg2:String, _arg3:Function):void{
            _arg1.requestURL = _arg2;
            (_arg1 as BaseTask).finished.addOnce(_arg3);
            (_arg1 as BaseTask).start();
        }

        private function onFriendListResponse(_arg1:FriendDataRequestTask, _arg2:Boolean, _arg3:String=""):void{
            this._isFriDataOK = _arg2;
            if (this._isFriDataOK){
                this.seedFriends(_arg1.xml);
                _arg1.reset();
                this._friendsLoadInProcess = false;
                this.loadList(this.friendsDataRequest, FriendsActions.getURL(FriendsActions.INVITE_LIST), this.onInvitationListResponse);
            }
            else {
                this.socialDataSignal.dispatch(SocialDataSignal.FRIENDS_DATA_LOADED, this._isFriDataOK, _arg3);
            }
        }

        private function onInvitationListResponse(_arg1:FriendDataRequestTask, _arg2:Boolean, _arg3:String=""):void{
            if (_arg2){
                this.seedInvitations(_arg1.xml);
                this.socialDataSignal.dispatch(SocialDataSignal.FRIENDS_DATA_LOADED, this._isFriDataOK, _arg3);
            }
            else {
                this.socialDataSignal.dispatch(SocialDataSignal.FRIEND_INVITATIONS_LOADED, _arg2, _arg3);
            }
            _arg1.reset();
            this._invitationsLoadInProgress = false;
        }

        private function onGuildListResponse(_arg1:GuildDataRequestTask, _arg2:Boolean, _arg3:String=""):void{
            if (_arg2){
                this.seedGuild(_arg1.xml);
            }
            else {
                this.clearGuildData();
            }
            _arg1.reset();
            this._guildLoadInProgress = false;
            this.socialDataSignal.dispatch(SocialDataSignal.GUILD_DATA_LOADED, _arg2, _arg3);
        }

        private function seedInvitations(_arg1:XML):void{
            var _local2:String;
            var _local3:XML;
            var _local4:Player;
            this._invitations = new Dictionary(true);
            this._numberOfInvitation = 0;
            for each (_local3 in _arg1.Account) {
                try {
                    if (((_local3.Character[0]) && (!((int(_local3.Character[0].ObjectType) == 0))))){
                        if (this.starFilter(int(_local3.Character[0].ObjectType), int(_local3.Character[0].CurrentFame), _local3.Stats[0])){
                            _local2 = _local3.Name;
                            _local4 = Player.fromPlayerXML(_local2, _local3.Character[0]);
                            this._invitations[_local2] = new FriendVO(_local4);
                            this._numberOfInvitation++;
                        }
                    }
                }
                catch(error:Error) {
                }
            }
        }

        private function seedGuild(_arg1:XML):void{
            var _local3:XML;
            var _local4:GuildMemberVO;
            var _local5:String;
            var _local6:String;
            this.clearGuildData();
            this._guildVO = new GuildVO();
            this._guildVO.guildName = _arg1.@name;
            this._guildVO.guildId = _arg1.@id;
            this._guildVO.guildTotalFame = _arg1.TotalFame;
            this._guildVO.guildCurrentFame = _arg1.CurrentFame.value;
            this._guildVO.guildHallType = _arg1.HallType;
            var _local2:XMLList = _arg1.child("Member");
            if (_local2.length() > 0){
                for each (_local3 in _local2) {
                    _local4 = new GuildMemberVO();
                    _local5 = _local3.Name;
                    if (_local5 == this.hudModel.getPlayerName()){
                        _local4.isMe = true;
                        this._guildVO.myRank = _local3.Rank;
                    }
                    _local4.name = _local5;
                    _local4.rank = _local3.Rank;
                    _local4.fame = _local3.Fame;
                    _local4.player = this.getPlayerObject(_local5, _local3);
                    if (_local3.hasOwnProperty("Online")){
                        _local4.isOnline = true;
                        _local6 = String(_local3.Online);
                        _local4.serverAddress = _local6;
                        _local4.serverName = this.serverNameDictionary()[_local6];
                        this._onlineGuildMembers.push(_local4);
                    }
                    else {
                        _local4.lastLogin = this.getLastLoginInSeconds(_local3.LastLogin);
                        this._offlineGuildMembers.push(_local4);
                    }
                }
            }
            this.updateGuildData();
        }

        private function getPlayerObject(_arg1:String, _arg2:XML):Player{
            var _local3:XML = _arg2.Character[0];
            if (int(_local3.ObjectType) == 0){
                _local3.ObjectType = "782";
            }
            return (Player.fromPlayerXML(_arg1, _local3));
        }

        private function getLastLoginInSeconds(_arg1:String):Number{
            var _local2:Date = new Date();
            return (((_local2.getTime() - TimeUtil.parseUTCDate(_arg1).getTime()) / 1000));
        }

        private function updateGuildData():void{
            this._onlineGuildMembers.sort(this.sortGuildMemberByRank);
            this._offlineGuildMembers.sort(this.sortGuildMemberByRank);
            this._onlineGuildMembers.sort(this.sortGuildMemberByAlphabet);
            this._offlineGuildMembers.sort(this.sortGuildMemberByAlphabet);
            this._guildMembers = this._onlineGuildMembers.concat(this._offlineGuildMembers);
            this._numberOfGuildMembers = this._guildMembers.length;
            this._guildVO.guildMembers = this._guildMembers;
        }

        private function clearGuildData():void{
            this._onlineGuildMembers.length = 0;
            this._offlineGuildMembers.length = 0;
            this._guildVO = null;
        }

        private function removeFriendFromList(_arg1:String):void{
            var _local2:FriendVO;
            for each (_local2 in this._onlineFriends) {
                if (_local2.getName() == _arg1){
                    this._onlineFriends.splice(this._onlineFriends.indexOf(_local2), 1);
                    break;
                }
            }
            for each (_local2 in this._offlineFriends) {
                if (_local2.getName() == _arg1){
                    this._offlineFriends.splice(this._offlineFriends.indexOf(_local2), 1);
                    break;
                }
            }
            this.updateFriendsList();
        }

        private function removeFromList(_arg1:Vector.<FriendVO>, _arg2:String):void{
            var _local3:FriendVO;
            var _local4:int;
            while (_local4 < _arg1.length) {
                _local3 = _arg1[_local4];
                if (_local3.getName() == _arg2){
                    _arg1.slice(_local4, 1);
                    return;
                }
                _local4++;
            }
        }

        private function sortFriend(_arg1:FriendVO, _arg2:FriendVO):Number{
            if (_arg1.getName() < _arg2.getName()){
                return (-1);
            }
            if (_arg1.getName() > _arg2.getName()){
                return (1);
            }
            return (0);
        }

        private function sortGuildMemberByRank(_arg1:GuildMemberVO, _arg2:GuildMemberVO):Number{
            if (_arg1.rank > _arg2.rank){
                return (-1);
            }
            if (_arg1.rank < _arg2.rank){
                return (1);
            }
            return (0);
        }

        private function sortGuildMemberByAlphabet(_arg1:GuildMemberVO, _arg2:GuildMemberVO):Number{
            if (_arg1.rank == _arg2.rank){
                if (_arg1.name < _arg2.name){
                    return (-1);
                }
                if (_arg1.name > _arg2.name){
                    return (1);
                }
                return (0);
            }
            return (0);
        }

        private function serverNameDictionary():Dictionary{
            var _local2:Server;
            if (this._serverDict){
                return (this._serverDict);
            }
            var _local1:Vector.<Server> = this.serverModel.getServers();
            this._serverDict = new Dictionary(true);
            for each (_local2 in _local1) {
                this._serverDict[_local2.address] = _local2.name;
            }
            return (this._serverDict);
        }

        private function starFilter(_arg1:int, _arg2:int, _arg3:XML):Boolean{
            return ((FameUtil.numAllTimeStars(_arg1, _arg2, _arg3) >= Parameters.data_.friendStarRequirement));
        }

        private function updateFriendsList():void{
            this._friendsList = this._onlineFriends.concat(this._offlineFriends);
            this._numberOfFriends = this._friendsList.length;
        }

        public function get hasInvitations():Boolean{
            return ((this._numberOfInvitation > 0));
        }

        public function get guildVO():GuildVO{
            return (this._guildVO);
        }

        public function get numberOfFriends():int{
            return (this._numberOfFriends);
        }

        public function get friendsList():Vector.<FriendVO>{
            return (this._friendsList);
        }

        public function get numberOfGuildMembers():int{
            return (this._numberOfGuildMembers);
        }


    }
}//package io.decagames.rotmg.social.model

