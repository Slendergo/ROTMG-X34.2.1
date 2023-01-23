// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.commands.AddPetsConsoleActionsCommand

package io.decagames.rotmg.pets.commands{
    import kabam.lib.console.signals.RegisterConsoleActionSignal;
    import io.decagames.rotmg.pets.signals.OpenCaretakerQueryDialogSignal;
    import kabam.lib.console.vo.ConsoleAction;

    public class AddPetsConsoleActionsCommand {

        [Inject]
        public var register:RegisterConsoleActionSignal;
        [Inject]
        public var openCaretakerQuerySignal:OpenCaretakerQueryDialogSignal;


        public function execute():void{
            var _local1:ConsoleAction;
            _local1 = new ConsoleAction();
            _local1.name = "caretaker";
            _local1.description = "opens the pets caretaker query UI";
            this.register.dispatch(_local1, this.openCaretakerQuerySignal);
        }


    }
}//package io.decagames.rotmg.pets.commands

