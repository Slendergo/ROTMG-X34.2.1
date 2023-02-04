// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.web.commands.WebLoginCommand

package kabam.rotmg.account.web.commands{
    import kabam.rotmg.account.web.model.AccountData;
    import kabam.rotmg.account.core.services.LoginTask;
    import kabam.lib.tasks.TaskMonitor;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.core.signals.TaskErrorSignal;
    import kabam.rotmg.account.core.signals.UpdateAccountInfoSignal;
    import kabam.rotmg.core.signals.InvalidateDataSignal;
    import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
    import kabam.rotmg.core.model.ScreenModel;
    import kabam.rotmg.packages.services.GetPackagesTask;
    import kabam.rotmg.mysterybox.services.GetMysteryBoxesTask;
    import kabam.lib.tasks.DispatchSignalTask;
    import kabam.lib.tasks.BranchingTask;
    import kabam.lib.tasks.TaskSequence;
    import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;

    public class WebLoginCommand {

        [Inject]
        public var data:AccountData;
        [Inject]
        public var loginTask:LoginTask;
        [Inject]
        public var monitor:TaskMonitor;
        [Inject]
        public var closeDialogs:CloseDialogsSignal;
        [Inject]
        public var loginError:TaskErrorSignal;
        [Inject]
        public var updateLogin:UpdateAccountInfoSignal;
        [Inject]
        public var invalidate:InvalidateDataSignal;
        [Inject]
        public var setScreenWithValidData:SetScreenWithValidDataSignal;
        [Inject]
        public var screenModel:ScreenModel;
        [Inject]
        public var getPackageTask:GetPackagesTask;
        [Inject]
        public var mysteryBoxTask:GetMysteryBoxesTask;
        private var setScreenTask:DispatchSignalTask;


        public function execute():void{
            var _local1:BranchingTask = new BranchingTask(this.loginTask, this.makeSuccessTask(), this.makeFailureTask());
            this.monitor.add(_local1);
            _local1.start();
        }

        private function makeSuccessTask():TaskSequence{
            this.setScreenTask = new DispatchSignalTask(this.setScreenWithValidData, new CharacterSelectionAndNewsScreen());
            var _local1:TaskSequence = new TaskSequence();
            _local1.add(new DispatchSignalTask(this.closeDialogs));
            _local1.add(new DispatchSignalTask(this.updateLogin));
            _local1.add(new DispatchSignalTask(this.invalidate));
            _local1.add(this.getPackageTask);
            _local1.add(this.mysteryBoxTask);
            _local1.add(this.setScreenTask);
            return (_local1);
        }

        private function makeFailureTask():TaskSequence{
            var _local1:TaskSequence = new TaskSequence();
            _local1.add(new DispatchSignalTask(this.loginError, this.loginTask));
            return (_local1);
        }
    }
}//package kabam.rotmg.account.web.commands

