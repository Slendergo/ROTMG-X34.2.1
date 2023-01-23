// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.lib.console.ConsoleExtension

package kabam.lib.console{
    import flash.display.DisplayObjectContainer;
    import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
    import kabam.lib.resizing.ResizeExtension;
    import robotlegs.bender.framework.api.IContext;
    import robotlegs.bender.framework.api.*;

    public class ConsoleExtension implements IExtension {

        [Inject]
        public var contextView:DisplayObjectContainer;


        public function extend(_arg1:IContext):void{
            _arg1.extend(SignalCommandMapExtension).extend(ResizeExtension).configure(ConsoleConfig);
        }


    }
}//package kabam.lib.console

