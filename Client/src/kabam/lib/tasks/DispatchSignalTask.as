// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.lib.tasks.DispatchSignalTask

package kabam.lib.tasks{
    import org.osflash.signals.Signal;

    public class DispatchSignalTask extends BaseTask {

        private var signal:Signal;
        private var params:Array;

        public function DispatchSignalTask(_arg1:Signal, ... _args){
            this.signal = _arg1;
            this.params = _args;
        }

        override protected function startTask():void{
            this.signal.dispatch.apply(null, this.params);
            completeTask(true);
        }


    }
}//package kabam.lib.tasks

