// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.seasonalEvent.tasks.GetChallengerListTask

package io.decagames.rotmg.seasonalEvent.tasks{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.legends.model.LegendsModel;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import kabam.rotmg.legends.model.LegendFactory;
    import io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalItemDataFactory;
    import kabam.rotmg.legends.model.Timespan;
    import io.decagames.rotmg.seasonalEvent.signals.SeasonalLeaderBoardErrorSignal;
    import io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalLeaderBoard;
    import io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalLeaderBoardItemData;

    public class GetChallengerListTask extends BaseTask {

        public static const REFRESH_INTERVAL_IN_MILLISECONDS:Number = ((5 * 60) * 1000);//300000

        [Inject]
        public var account:Account;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var player:PlayerModel;
        [Inject]
        public var model:LegendsModel;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        [Inject]
        public var factory:LegendFactory;
        [Inject]
        public var seasonalItemDataFactory:SeasonalItemDataFactory;
        [Inject]
        public var timespan:Timespan;
        [Inject]
        public var listType:String;
        [Inject]
        public var seasonalLeaderBoardErrorSignal:SeasonalLeaderBoardErrorSignal;
        public var charId:int;


        override protected function startTask():void{
            this.client.complete.addOnce(this.onComplete);
            if (this.listType == SeasonalLeaderBoard.TOP_20_TAB_LABEL){
                this.client.sendRequest("/fame/challengerLeaderboard", this.makeRequestObject());
            }
            else {
                if (this.listType == SeasonalLeaderBoard.PLAYER_TAB_LABEL){
                    this.client.sendRequest(("/fame/challengerAccountLeaderboard?account=" + this.account.getUserName()), this.makeRequestObject());
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
            var _local3:Date = new Date((_local2.GeneratedOn * 1000));
            var _local4:Number = ((_local3.getTimezoneOffset() * 60) * 1000);
            _local3.setTime((_local3.getTime() - _local4));
            var _local5:Date = new Date();
            _local5.setTime((_local5.getTime() + REFRESH_INTERVAL_IN_MILLISECONDS));
            var _local6:Vector.<SeasonalLeaderBoardItemData> = this.seasonalItemDataFactory.createSeasonalLeaderBoardItemDatas(XML(_arg1));
            if (this.listType == SeasonalLeaderBoard.TOP_20_TAB_LABEL){
                this.seasonalEventModel.leaderboardTop20ItemDatas = _local6;
                this.seasonalEventModel.leaderboardTop20RefreshTime = _local5;
                this.seasonalEventModel.leaderboardTop20CreateTime = _local3;
            }
            else {
                if (this.listType == SeasonalLeaderBoard.PLAYER_TAB_LABEL){
                    _local6.sort(this.fameSort);
                    this.seasonalEventModel.leaderboardPlayerItemDatas = _local6;
                    this.seasonalEventModel.leaderboardPlayerRefreshTime = _local5;
                    this.seasonalEventModel.leaderboardPlayerCreateTime = _local3;
                };
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
            _local1.timespan = this.timespan.getId();
            _local1.accountId = this.player.getAccountId();
            _local1.charId = this.charId;
            return (_local1);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.tasks

