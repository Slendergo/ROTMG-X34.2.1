// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.servers.model.LocalhostServerModel

package kabam.rotmg.servers.model{
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import kabam.rotmg.servers.api.Server;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.assembleegameclient.appengine.SavedCharacter;
    import kabam.rotmg.servers.api.*;

    public class LocalhostServerModel implements ServerModel {

        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        private var localhost:Server;
        private var servers:Vector.<Server>;
        private var availableServers:Vector.<Server>;

        public function LocalhostServerModel(){
            var _local2:String;
            var _local3:Server;
            super();
            this.servers = new <Server>[];
            var _local1:int;
            while (_local1 < 40) {
                _local2 = ((((_local1 % 2) == 0)) ? "localhost" : ("C_localhost" + _local1));
                _local3 = new Server().setName(_local2).setAddress("localhost").setPort(Parameters.PORT);
                this.servers.push(_local3);
                _local1++;
            };
        }

        public function setAvailableServers(_arg1:int):void{
            var _local2:Server;
            var _local3:Server;
            if (!this.availableServers){
                this.availableServers = new <Server>[];
            }
            else {
                this.availableServers.length = 0;
            };
            if (_arg1 != 0){
                for each (_local2 in this.servers) {
                    if (_local2.name.charAt(0) == "C"){
                        this.availableServers.push(_local2);
                    };
                };
            }
            else {
                for each (_local3 in this.servers) {
                    if (_local3.name.charAt(0) != "C"){
                        this.availableServers.push(_local3);
                    };
                };
            };
        }

        public function getAvailableServers():Vector.<Server>{
            return (this.availableServers);
        }

        public function getServer():Server{
            var _local2:Boolean;
            var _local6:Server;
            var _local7:String;
            var _local1:Boolean = this.playerModel.isAdmin();
            var _local3:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
            if (_local3){
                _local2 = Boolean(int(_local3.charXML_.IsChallenger));
            }
            else {
                _local2 = Boolean(this.seasonalEventModel.isChallenger);
            };
            var _local4:int = ((_local2) ? Server.CHALLENGER_SERVER : Server.NORMAL_SERVER);
            this.setAvailableServers(_local4);
            var _local5:Server;
            for each (_local6 in this.availableServers) {
                if (!((_local6.isFull()) && (!(_local1)))){
                    _local7 = ((_local2) ? Parameters.data_.preferredChallengerServer : Parameters.data_.preferredServer);
                    if (_local6.name == _local7){
                        return (_local6);
                    };
                    _local5 = this.availableServers[0];
                    if (_local2){
                        Parameters.data_.bestChallengerServer = _local5.name;
                    }
                    else {
                        Parameters.data_.bestServer = _local5.name;
                    };
                    Parameters.save();
                };
            };
            return (_local5);
        }

        public function isServerAvailable():Boolean{
            return true;
        }

        public function setServers(_arg1:Vector.<Server>):void{
        }

        public function getServers():Vector.<Server>{
            return (this.servers);
        }


    }
}//package kabam.rotmg.servers.model

