// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.servers.model.LiveServerModel

package kabam.rotmg.servers.model{
    import kabam.rotmg.servers.api.Server;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.servers.api.LatLong;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.servers.api.*;

    public class LiveServerModel implements ServerModel {

        private const servers:Vector.<Server> = new <Server>[];

        [Inject]
        public var model:PlayerModel;
        private var _descendingFlag:Boolean;
        private var availableServers:Vector.<Server>;

        public function setServers(_arg1:Vector.<Server>):void{
            var _local2:Server;
            this.servers.length = 0;
            for each (_local2 in _arg1) {
                this.servers.push(_local2);
            };
            this._descendingFlag = false;
            this.servers.sort(this.compareServerName);
        }

        public function getServers():Vector.<Server>{
            return (this.servers);
        }

        public function getServer():Server{
            var _local10:Server;
            var _local11:int;
            var _local12:Number;
            var _local1:Boolean = this.model.isAdmin();
            this.setAvailableServers();
            var _local5:LatLong = this.model.getMyPos();
            var _local6:Server;
            var _local7:Number = Number.MAX_VALUE;
            var _local8:int = int.MAX_VALUE;
            for each (_local10 in this.availableServers) {
                if (!((_local10.isFull()) && (!(_local1)))){
                    if (_local10.name == Parameters.data_.preferredServer){
                        return (_local10);
                    };
                    _local11 = _local10.priority();
                    _local12 = LatLong.distance(_local5, _local10.latLong);
                    if ((((_local11 < _local8)) || ((((_local11 == _local8)) && ((_local12 < _local7)))))){
                        _local6 = _local10;
                        _local7 = _local12;
                        _local8 = _local11;
                        Parameters.data_.bestServer = _local6.name;
                        Parameters.save();
                    };
                };
            };
            return (_local6);
        }

        public function getServerNameByAddress(_arg1:String):String{
            var _local2:Server;
            for each (_local2 in this.servers) {
                if (_local2.address == _arg1){
                    return (_local2.name);
                };
            };
            return ("");
        }

        public function isServerAvailable():Boolean{
            return ((this.servers.length > 0));
        }

        private function compareServerName(_arg1:Server, _arg2:Server):int{
            if (_arg1.name < _arg2.name){
                return (((this._descendingFlag) ? -1 : 1));
            };
            if (_arg1.name > _arg2.name){
                return (((this._descendingFlag) ? 1 : -1));
            };
            return (0);
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


    }
}//package kabam.rotmg.servers.model

