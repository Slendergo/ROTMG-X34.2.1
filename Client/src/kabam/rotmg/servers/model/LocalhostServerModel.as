// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.servers.model.LocalhostServerModel

package kabam.rotmg.servers.model{
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.servers.api.Server;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.assembleegameclient.appengine.SavedCharacter;
    import kabam.rotmg.servers.api.*;

    public class LocalhostServerModel implements ServerModel {

        [Inject]
        public var playerModel:PlayerModel;
        private var localhost:Server;
        private var servers:Vector.<Server>;
        private var availableServers:Vector.<Server>;

        public function LocalhostServerModel(){
            var _local3:Server;
            super();
            this.servers = new <Server>[];
            var _local1:int;
            while (_local1 < 40) {
                _local3 = new Server().setName("localhost").setAddress("localhost").setPort(Parameters.PORT);
                this.servers.push(_local3);
                _local1++;
            }
        }

        public function setAvailableServers():void{
            var _local2:Server;
            if (!this.availableServers){
                this.availableServers = new <Server>[];
            }
            else {
                this.availableServers.length = 0;
            }

            for each (_local2 in this.servers) {
                this.availableServers.push(_local2);
            }
        }

        public function getAvailableServers():Vector.<Server>{
            return (this.availableServers);
        }

        public function getServer():Server{
            var _local6:Server;
            var _local1:Boolean = this.playerModel.isAdmin();
            this.setAvailableServers();
            var _local5:Server;
            for each (_local6 in this.availableServers) {
                if (!((_local6.isFull()) && (!(_local1)))){
                    if (_local6.name == Parameters.data_.preferredServer){
                        return (_local6);
                    }
                    _local5 = this.availableServers[0];
                    Parameters.data_.bestServer = _local5.name;
                    Parameters.save();
                }
            }
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

