// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.language.control.RegisterChangeLanguageViaConsoleCommand

package kabam.rotmg.language.control{
    import kabam.lib.console.signals.RegisterConsoleActionSignal;
    import kabam.lib.console.vo.ConsoleAction;

    public class RegisterChangeLanguageViaConsoleCommand {

        [Inject]
        public var registerConsoleAction:RegisterConsoleActionSignal;
        [Inject]
        public var setLanguage:SetLanguageSignal;


        public function execute():void{
            var _local1:ConsoleAction;
            _local1 = new ConsoleAction();
            _local1.name = "setlang";
            _local1.description = "Sets the locale language (defaults to en-US)";
            this.registerConsoleAction.dispatch(_local1, this.setLanguage);
        }


    }
}//package kabam.rotmg.language.control

