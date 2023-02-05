// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.game.commands.PlayGameCommand

package kabam.rotmg.game.commands{
    import kabam.rotmg.core.signals.SetScreenSignal;
    import kabam.rotmg.game.model.GameInitData;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.pets.data.PetsModel;
    import kabam.rotmg.servers.api.ServerModel;
    import kabam.lib.tasks.TaskMonitor;
    import kabam.lib.net.impl.SocketServerModel;
    import com.company.assembleegameclient.appengine.SavedCharacter;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.servers.api.Server;
    import flash.utils.ByteArray;
    import com.company.assembleegameclient.game.GameSprite;

    public class PlayGameCommand {

        public static const RECONNECT_DELAY:int = 2000;

        [Inject]
        public var setScreen:SetScreenSignal;
        [Inject]
        public var data:GameInitData;
        [Inject]
        public var model:PlayerModel;
        [Inject]
        public var petsModel:PetsModel;
        [Inject]
        public var serverModel:ServerModel;
        [Inject]
        public var monitor:TaskMonitor;
        [Inject]
        public var socketServerModel:SocketServerModel;


        public function execute():void{
            if (!this.data.isNewGame){
                this.socketServerModel.connectDelayMS = PlayGameCommand.RECONNECT_DELAY;
            }
            this.recordCharacterUseInSharedObject();
            this.makeGameView();
            this.updatePet();
        }

        private function updatePet():void{
            var _local1:SavedCharacter = this.model.getCharacterById(this.model.currentCharId);
            if (_local1){
                this.petsModel.setActivePet(_local1.getPetVO());
            }
            else {
                if (((((this.model.currentCharId) && (this.petsModel.getActivePet()))) && (!(this.data.isNewGame)))){
                    return;
                }
                this.petsModel.setActivePet(null);
            }
        }

        private function recordCharacterUseInSharedObject():void{
            Parameters.data_.charIdUseMap[this.data.charId] = new Date().getTime();
            Parameters.save();
        }

        private function makeGameView():void{
            this.serverModel.setAvailableServers();
            var _local4:Server = ((this.data.server) || (this.serverModel.getServer()));
            var _local5:int = ((this.data.isNewGame) ? this.getInitialGameId() : this.data.gameId);
            var _local6:Boolean = this.data.createCharacter;
            var _local7:int = this.data.charId;
            var _local8:int = ((this.data.isNewGame) ? -1 : this.data.keyTime);
            var _local9:ByteArray = this.data.key;
            this.model.currentCharId = _local7;
            this.setScreen.dispatch(new GameSprite(_local4, _local5, _local6, _local7, _local8, _local9, this.model, null, this.data.isFromArena));
        }

        private function getInitialGameId():int{
            var _local1:int;
            if (Parameters.data_.needsTutorial){
                _local1 = Parameters.TUTORIAL_GAMEID;
            }
            else {
                if (Parameters.data_.needsRandomRealm){
                    _local1 = Parameters.RANDOM_REALM_GAMEID;
                }
                else {
                    _local1 = Parameters.NEXUS_GAMEID;
                }
            }
            return (_local1);
        }
    }
}//package kabam.rotmg.game.commands

