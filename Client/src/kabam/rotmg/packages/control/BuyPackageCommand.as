// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.packages.control.BuyPackageCommand

package kabam.rotmg.packages.control{
    import kabam.rotmg.packages.services.BuyPackageTask;
    import kabam.lib.tasks.TaskMonitor;

    public class BuyPackageCommand {

        [Inject]
        public var buyPackageTask:BuyPackageTask;
        [Inject]
        public var taskMonitor:TaskMonitor;


        public function execute():void{
            this.taskMonitor.add(this.buyPackageTask);
            this.buyPackageTask.start();
        }


    }
}//package kabam.rotmg.packages.control

