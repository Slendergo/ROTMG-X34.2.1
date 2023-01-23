// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.seasonalEvent.tasks.GetLegacyChallengerListTask

package io.decagames.rotmg.seasonalEvent.tasks{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import kabam.rotmg.legends.model.LegendFactory;
    import io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalItemDataFactory;
    import io.decagames.rotmg.seasonalEvent.signals.SeasonalLeaderBoardErrorSignal;
    import io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalLeaderBoardItemData;

    public class GetLegacyChallengerListTask extends BaseTask {

        [Inject]
        public var account:Account;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var player:PlayerModel;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        [Inject]
        public var factory:LegendFactory;
        [Inject]
        public var seasonalItemDataFactory:SeasonalItemDataFactory;
        [Inject]
        public var seasonId:String;
        [Inject]
        public var isTop20:Boolean;
        [Inject]
        public var seasonalLeaderBoardErrorSignal:SeasonalLeaderBoardErrorSignal;
        public var charId:int;


        override protected function startTask():void{
            this.client.complete.addOnce(this.onComplete);
            if (((!((this.seasonId == ""))) && (!((this.seasonId == null))))){
                if (this.isTop20){
                    this.client.sendRequest(("/fame/challengerLeaderboard?season=" + this.seasonId), this.makeRequestObject());
                }
                else {
                    this.client.sendRequest(((("/fame/challengerAccountLeaderboard?season=" + this.seasonId) + "&account=") + this.account.getUserName()), this.makeRequestObject());
                };
            };
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            if (_arg1){
                this.updateFameListData(_arg2);
            }
            else {
                this.onFameListError(_arg2);
            };
        }

        private function onFameListError(_arg1:String):void{
            this.seasonalLeaderBoardErrorSignal.dispatch(_arg1);
            completeTask(true);
        }

        private function updateFameListData(_arg1:String):void{
            var _local2:XML = XML(_arg1);
            var _local3:Vector.<SeasonalLeaderBoardItemData> = this.seasonalItemDataFactory.createSeasonalLeaderBoardItemDatas(XML(_arg1));
            if (this.isTop20){
                this.seasonalEventModel.leaderboardLegacyTop20ItemDatas = _local3;
            }
            else {
                _local3.sort(this.fameSort);
                this.seasonalEventModel.leaderboardLegacyPlayerItemDatas = _local3;
            };
            completeTask(true);
        }

        private function fameSort(_arg1:SeasonalLeaderBoardItemData, _arg2:SeasonalLeaderBoardItemData):int{
            if (_arg1.totalFame > _arg2.totalFame){
                return (-1);
            };
            if (_arg1.totalFame < _arg2.totalFame){
                return (1);
            };
            return (0);
        }

        private function makeRequestObject():Object{
            var _local1:Object = {};
            _local1.accountId = this.player.getAccountId();
            _local1.charId = this.charId;
            return (_local1);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.tasks

