// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.startup.model.impl.SignalTaskDelegate

package kabam.rotmg.startup.model.impl{
    import org.swiftsuspenders.Injector;
    import org.osflash.signals.Signal;
    import kabam.lib.tasks.DispatchSignalTask;
    import kabam.lib.tasks.Task;
    import kabam.rotmg.startup.model.api.*;

    public class SignalTaskDelegate implements StartupDelegate {

        public var injector:Injector;
        public var signalClass:Class;
        public var priority:int;


        public function getPriority():int{
            return (this.priority);
        }

        public function make():Task{
            var _local1:Signal = this.injector.getInstance(this.signalClass);
            return (new DispatchSignalTask(_local1));
        }


    }
}//package kabam.rotmg.startup.model.impl

