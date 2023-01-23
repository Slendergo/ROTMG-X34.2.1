﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.kongregate.commands.KongregateHandleAlreadyRegisteredCommand

package kabam.rotmg.account.kongregate.commands{
    import kabam.rotmg.account.core.services.LoginTask;
    import kabam.lib.tasks.TaskMonitor;
    import kabam.rotmg.ui.signals.RefreshScreenAfterLoginSignal;
    import kabam.lib.tasks.BranchingTask;
    import kabam.lib.tasks.DispatchSignalTask;

    public class KongregateHandleAlreadyRegisteredCommand {

        [Inject]
        public var login:LoginTask;
        [Inject]
        public var monitor:TaskMonitor;
        [Inject]
        public var refresh:RefreshScreenAfterLoginSignal;


        public function execute():void{
            var _local1:BranchingTask = new BranchingTask(this.login);
            _local1.addSuccessTask(new DispatchSignalTask(this.refresh));
            this.monitor.add(_local1);
            _local1.start();
        }


    }
}//package kabam.rotmg.account.kongregate.commands

