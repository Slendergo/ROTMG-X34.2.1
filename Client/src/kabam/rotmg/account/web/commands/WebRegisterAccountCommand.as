﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.web.commands.WebRegisterAccountCommand

package kabam.rotmg.account.web.commands{
    import kabam.rotmg.account.core.services.RegisterAccountTask;
    import kabam.lib.tasks.TaskMonitor;
    import kabam.rotmg.core.signals.TaskErrorSignal;
    import kabam.rotmg.account.core.signals.UpdateAccountInfoSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.core.signals.TrackEventSignal;
    import kabam.rotmg.ui.signals.EnterGameSignal;
    import kabam.rotmg.ui.signals.PollVerifyEmailSignal;
    import kabam.lib.tasks.BranchingTask;
    import kabam.lib.tasks.TaskSequence;
    import kabam.lib.tasks.DispatchSignalTask;
    import kabam.rotmg.account.web.view.WebVerifyEmailDialog;
    import kabam.lib.tasks.Task;
    import kabam.rotmg.core.service.TrackingData;

    public class WebRegisterAccountCommand {

        [Inject]
        public var task:RegisterAccountTask;
        [Inject]
        public var monitor:TaskMonitor;
        [Inject]
        public var taskError:TaskErrorSignal;
        [Inject]
        public var updateAccount:UpdateAccountInfoSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var track:TrackEventSignal;
        [Inject]
        public var enterGame:EnterGameSignal;
        [Inject]
        public var pollVerifyEmailSignal:PollVerifyEmailSignal;


        public function execute():void{
            var _local1:BranchingTask = new BranchingTask(this.task, this.makeSuccess(), this.makeFailure());
            this.monitor.add(_local1);
            _local1.start();
        }

        private function makeSuccess():Task{
            var _local1:TaskSequence = new TaskSequence();
            _local1.add(new DispatchSignalTask(this.updateAccount));
            _local1.add(new DispatchSignalTask(this.openDialog, new WebVerifyEmailDialog()));
            _local1.add(new DispatchSignalTask(this.enterGame));
            _local1.add(new DispatchSignalTask(this.pollVerifyEmailSignal));
            return (_local1);
        }

        private function makeFailure():DispatchSignalTask{
            return (new DispatchSignalTask(this.taskError, this.task));
        }

        private function getTrackingData():TrackingData{
            var _local1:TrackingData = new TrackingData();
            _local1.category = "account";
            _local1.action = "accountRegistered";
            return (_local1);
        }


    }
}//package kabam.rotmg.account.web.commands

