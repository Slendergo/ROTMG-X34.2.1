// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.seasonalEvent.tasks.GetSeasonalEventTask

package io.decagames.rotmg.seasonalEvent.tasks{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.Account;
    import robotlegs.bender.framework.api.ILogger;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;

    public class GetSeasonalEventTask extends BaseTask {

        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var logger:ILogger;
        [Inject]
        public var model:SeasonalEventModel;


        override protected function startTask():void{
            this.logger.info("GetSeasonalEvent start");
            var _local1:Object = this.account.getCredentials();
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/season/getSeasons", _local1);
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            if (_arg1){
                this.onSeasonalEvent(_arg2);
            }
            else {
                this.onTextError(_arg2);
            };
        }

        private function onTextError(_arg1:String):void{
            this.logger.info("GetSeasonalEvent error");
            completeTask(true);
        }

        private function onSeasonalEvent(_arg1:String):void{
            var xmlData:XML;
            var data:String = _arg1;
            try {
                xmlData = new XML(data);
            }
            catch(e:Error) {
                logger.error(("Error parsing seasonal data: " + data));
                completeTask(true);
                return;
            };
            this.logger.info("GetSeasonalEvent update");
            this.logger.info(xmlData);
            this.model.parseConfigData(xmlData);
            completeTask(true);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.tasks

