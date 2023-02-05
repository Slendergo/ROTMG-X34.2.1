// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.commands.UpgradePetCommand

package io.decagames.rotmg.pets.commands{
    import robotlegs.bender.bundles.mvcs.Command;
    import io.decagames.rotmg.pets.data.vo.requests.IUpgradePetRequestVO;
    import kabam.lib.net.api.MessageProvider;
    import kabam.lib.net.impl.SocketServer;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.messaging.impl.PetUpgradeRequest;
    import io.decagames.rotmg.pets.data.vo.requests.UpgradePetYardRequestVO;
    import kabam.rotmg.messaging.impl.GameServerConnection;
    import io.decagames.rotmg.pets.data.vo.requests.FeedPetRequestVO;
    import io.decagames.rotmg.pets.data.vo.requests.FusePetRequestVO;
    import kabam.rotmg.account.core.view.RegisterPromptDialog;

    public class UpgradePetCommand extends Command {

        private static const PET_YARD_REGISTER_STRING:String = "In order to upgradeYard your yard you must be a registered user.";

        [Inject]
        public var vo:IUpgradePetRequestVO;
        [Inject]
        public var messages:MessageProvider;
        [Inject]
        public var server:SocketServer;
        [Inject]
        public var account:Account;
        [Inject]
        public var openDialog:OpenDialogSignal;


        override public function execute():void{
            var _local1:PetUpgradeRequest;
            if ((this.vo is UpgradePetYardRequestVO)){
                if (!this.account.isRegistered()){
                    this.showPromptToRegister(PET_YARD_REGISTER_STRING);
                }
                _local1 = (this.messages.require(GameServerConnection.PETUPGRADEREQUEST) as PetUpgradeRequest);
                _local1.petTransType = 1;
                _local1.objectId = UpgradePetYardRequestVO(this.vo).objectID;
                _local1.paymentTransType = UpgradePetYardRequestVO(this.vo).paymentTransType;
            }
            if ((this.vo is FeedPetRequestVO)){
                _local1 = (this.messages.require(GameServerConnection.PETUPGRADEREQUEST) as PetUpgradeRequest);
                _local1.petTransType = 2;
                _local1.PIDOne = FeedPetRequestVO(this.vo).petInstanceId;
                _local1.slotsObject = FeedPetRequestVO(this.vo).slotObjects;
                _local1.paymentTransType = FeedPetRequestVO(this.vo).paymentTransType;
            }
            if ((this.vo is FusePetRequestVO)){
                _local1 = (this.messages.require(GameServerConnection.PETUPGRADEREQUEST) as PetUpgradeRequest);
                _local1.petTransType = 3;
                _local1.PIDOne = FusePetRequestVO(this.vo).petInstanceIdOne;
                _local1.PIDTwo = FusePetRequestVO(this.vo).petInstanceIdTwo;
                _local1.paymentTransType = FusePetRequestVO(this.vo).paymentTransType;
            }
            if (_local1){
                this.server.sendMessage(_local1);
            }
        }

        private function showPromptToRegister(_arg1:String):void{
            this.openDialog.dispatch(new RegisterPromptDialog(_arg1));
        }


    }
}//package io.decagames.rotmg.pets.commands

