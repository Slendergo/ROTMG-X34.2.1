// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.commands.OpenCaretakerQueryDialogCommand

package io.decagames.rotmg.pets.commands{
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import io.decagames.rotmg.pets.components.caretaker.CaretakerQueryDialog;

    public class OpenCaretakerQueryDialogCommand {

        [Inject]
        public var openDialog:OpenDialogSignal;


        public function execute():void{
            var _local1:CaretakerQueryDialog = new CaretakerQueryDialog();
            this.openDialog.dispatch(_local1);
        }


    }
}//package io.decagames.rotmg.pets.commands

