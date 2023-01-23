// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.dailyQuests.command.QuestFetchCompleteCommand

package io.decagames.rotmg.dailyQuests.command{
    import robotlegs.bender.bundles.mvcs.Command;
    import io.decagames.rotmg.dailyQuests.messages.incoming.QuestFetchResponse;
    import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
    import io.decagames.rotmg.dailyQuests.model.DailyQuest;
    import io.decagames.rotmg.dailyQuests.messages.data.QuestData;

    public class QuestFetchCompleteCommand extends Command {

        [Inject]
        public var response:QuestFetchResponse;
        [Inject]
        public var model:DailyQuestsModel;
        private var _questsList:Vector.<DailyQuest>;


        override public function execute():void{
            var _local1:QuestData;
            var _local2:DailyQuest;
            this.model.clear();
            this.model.nextRefreshPrice = this.response.nextRefreshPrice;
            if (this.response.quests){
                this._questsList = new <DailyQuest>[];
                for each (_local1 in this.response.quests) {
                    _local2 = new DailyQuest();
                    _local2.id = _local1.id;
                    _local2.name = _local1.name;
                    _local2.description = _local1.description;
                    _local2.expiration = _local1.expiration;
                    _local2.requirements = _local1.requirements;
                    _local2.rewards = _local1.rewards;
                    _local2.completed = _local1.completed;
                    _local2.category = _local1.category;
                    _local2.itemOfChoice = _local1.itemOfChoice;
                    _local2.repeatable = _local1.repeatable;
                    _local2.weight = _local1.weight;
                    this._questsList.push(_local2);
                };
                this._questsList.sort(this.questWeightSort);
                this.model.addQuests(this._questsList);
            };
        }

        private function questWeightSort(_arg1:DailyQuest, _arg2:DailyQuest):int{
            if (_arg1.weight > _arg2.weight){
                return (-1);
            };
            if (_arg1.weight < _arg2.weight){
                return (1);
            };
            return (0);
        }


    }
}//package io.decagames.rotmg.dailyQuests.command

