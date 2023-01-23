﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.characters.deletion.control.DeleteCharacterCommand

package kabam.rotmg.characters.deletion.control{
    import kabam.rotmg.characters.deletion.service.DeleteCharacterTask;
    import kabam.lib.tasks.TaskMonitor;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.core.signals.SetScreenSignal;
    import kabam.lib.tasks.TaskSequence;
    import kabam.lib.tasks.DispatchSignalTask;
    import kabam.rotmg.characters.deletion.view.DeletingCharacterView;
    import kabam.lib.tasks.BranchingTask;
    import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
    import kabam.lib.tasks.Task;

    public class DeleteCharacterCommand {

        [Inject]
        public var task:DeleteCharacterTask;
        [Inject]
        public var monitor:TaskMonitor;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var closeDialogs:CloseDialogsSignal;
        [Inject]
        public var setScreen:SetScreenSignal;


        public function execute():void{
            var _local1:TaskSequence = new TaskSequence();
            _local1.add(new DispatchSignalTask(this.openDialog, new DeletingCharacterView()));
            _local1.add(new BranchingTask(this.task, this.onSuccess(), this.onFailure()));
            this.monitor.add(_local1);
            _local1.start();
        }

        private function onSuccess():Task{
            var _local1:TaskSequence = new TaskSequence();
            _local1.add(new DispatchSignalTask(this.setScreen, new CharacterSelectionAndNewsScreen()));
            _local1.add(new DispatchSignalTask(this.closeDialogs));
            return (_local1);
        }

        private function onFailure():Task{
            return (new DispatchSignalTask(this.openDialog, "Unable to delete character"));
        }


    }
}//package kabam.rotmg.characters.deletion.control

