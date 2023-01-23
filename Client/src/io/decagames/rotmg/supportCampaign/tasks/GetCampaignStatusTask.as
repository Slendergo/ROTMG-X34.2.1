// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.supportCampaign.tasks.GetCampaignStatusTask

package io.decagames.rotmg.supportCampaign.tasks{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.Account;
    import robotlegs.bender.framework.api.ILogger;
    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;

    public class GetCampaignStatusTask extends BaseTask {

        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var logger:ILogger;
        [Inject]
        public var model:SupporterCampaignModel;


        override protected function startTask():void{
            this.logger.info("GetCampaignStatus start");
            var _local1:Object = this.account.getCredentials();
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/supportCampaign/status", _local1);
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            if (_arg1){
                this.onCampaignUpdate(_arg2);
            }
            else {
                this.onTextError(_arg2);
            };
        }

        private function onTextError(_arg1:String):void{
            this.logger.info("GetCampaignStatus error");
            completeTask(true);
        }

        private function onCampaignUpdate(_arg1:String):void{
            var xmlData:XML;
            var data:String = _arg1;
            try {
                xmlData = new XML(data);
            }
            catch(e:Error) {
                logger.error(("Error parsing campaign data: " + data));
                completeTask(true);
                return;
            };
            this.logger.info("GetCampaignStatus update");
            this.logger.info(xmlData);
            this.model.parseConfigData(xmlData);
            completeTask(true);
        }


    }
}//package io.decagames.rotmg.supportCampaign.tasks

