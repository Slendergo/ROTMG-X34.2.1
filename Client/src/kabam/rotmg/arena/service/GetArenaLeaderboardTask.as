﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.arena.service.GetArenaLeaderboardTask

package kabam.rotmg.arena.service{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.arena.control.ReloadLeaderboard;
    import kabam.rotmg.arena.model.ArenaLeaderboardFilter;
    import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
    import com.company.util.MoreObjectUtil;

    public class GetArenaLeaderboardTask extends BaseTask {

        private static const REQUEST:String = "arena/getRecords";

        [Inject]
        public var account:Account;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var factory:ArenaLeaderboardFactory;
        [Inject]
        public var reloadLeaderboard:ReloadLeaderboard;
        public var filter:ArenaLeaderboardFilter;


        override protected function startTask():void{
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest(REQUEST, this.makeRequestObject());
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            ((_arg1) && (this.updateLeaderboard(_arg2)));
            completeTask(_arg1, _arg2);
        }

        private function updateLeaderboard(_arg1:String):void{
            var _local2:Vector.<ArenaLeaderboardEntry> = this.factory.makeEntries(XML(_arg1).Record);
            this.filter.setEntries(_local2);
            this.reloadLeaderboard.dispatch();
        }

        private function makeRequestObject():Object{
            var _local1:Object = {type:this.filter.getKey()};
            MoreObjectUtil.addToObject(_local1, this.account.getCredentials());
            return (_local1);
        }


    }
}//package kabam.rotmg.arena.service

