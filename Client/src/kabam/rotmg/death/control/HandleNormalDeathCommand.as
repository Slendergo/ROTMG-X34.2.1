﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.death.control.HandleNormalDeathCommand

package kabam.rotmg.death.control{
    import kabam.rotmg.messaging.impl.incoming.Death;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.account.core.services.GetCharListTask;
    import kabam.rotmg.fame.control.ShowFameViewSignal;
    import kabam.lib.tasks.TaskMonitor;
    import kabam.rotmg.fame.model.FameVO;
    import kabam.rotmg.fame.model.SimpleFameVO;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.lib.tasks.TaskSequence;
    import kabam.lib.tasks.DispatchSignalTask;

    public class HandleNormalDeathCommand {

        [Inject]
        public var death:Death;
        [Inject]
        public var player:PlayerModel;
        [Inject]
        public var task:GetCharListTask;
        [Inject]
        public var showFame:ShowFameViewSignal;
        [Inject]
        public var monitor:TaskMonitor;
        private var fameVO:FameVO;


        public function execute():void{
            this.fameVO = new SimpleFameVO(this.death.accountId_, this.death.charId_);
            this.updateParameters();
            this.gotoFameView();
        }

        private function updateParameters():void{
            Parameters.data_.needsRandomRealm = false;
            Parameters.save();
        }

        private function gotoFameView():void{
            if (this.player.getAccountId() == ""){
                this.gotoFameViewOnceDataIsLoaded();
            }
            else {
                this.showFame.dispatch(this.fameVO);
            };
        }

        private function gotoFameViewOnceDataIsLoaded():void{
            var _local1:TaskSequence = new TaskSequence();
            _local1.add(this.task);
            _local1.add(new DispatchSignalTask(this.showFame, this.fameVO));
            this.monitor.add(_local1);
            _local1.start();
        }
    }
}//package kabam.rotmg.death.control

