// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.lib.console.signals.RegisterConsoleActionSignal

package kabam.lib.console.signals{
    import org.osflash.signals.Signal;
    import kabam.lib.console.vo.ConsoleAction;

    public final class RegisterConsoleActionSignal extends Signal {

        public function RegisterConsoleActionSignal(){
            super(ConsoleAction, Signal);
        }

    }
}//package kabam.lib.console.signals

