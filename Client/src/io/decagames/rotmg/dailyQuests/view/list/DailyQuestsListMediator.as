// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.dailyQuests.view.list.DailyQuestsListMediator

package io.decagames.rotmg.dailyQuests.view.list{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.ui.signals.UpdateQuestSignal;
    import io.decagames.rotmg.dailyQuests.signal.ShowQuestInfoSignal;
    import kabam.rotmg.constants.GeneralConstants;
    import io.decagames.rotmg.dailyQuests.model.DailyQuest;
    import io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfo;

    public class DailyQuestsListMediator extends Mediator {

        [Inject]
        public var view:DailyQuestsList;
        [Inject]
        public var model:DailyQuestsModel;
        [Inject]
        public var hud:HUDModel;
        [Inject]
        public var updateQuestSignal:UpdateQuestSignal;
        [Inject]
        public var showInfoSignal:ShowQuestInfoSignal;
        private var hasEvent:Boolean;


        override public function initialize():void{
            this.onQuestsUpdate(UpdateQuestSignal.QUEST_LIST_LOADED);
            this.updateQuestSignal.add(this.onQuestsUpdate);
            this.view.tabs.tabSelectedSignal.add(this.onTabSelected);
        }

        private function onTabSelected(_arg1:String):void{
            var _local2:DailyQuestListElement = this.view.getCurrentlySelected(_arg1);
            if (_local2){
                this.showInfoSignal.dispatch(_local2.id, _local2.category, _arg1);
            }
            else {
                this.showInfoSignal.dispatch("", -1, _arg1);
            }
        }

        private function onQuestsUpdate(_arg1:String):void{
            this.view.clearQuestLists();
            var _local2:Vector.<int> = ((this.hud.gameSprite.map.player_) ? this.hud.gameSprite.map.player_.equipment_.slice((GeneralConstants.NUM_EQUIPMENT_SLOTS - 1), (GeneralConstants.NUM_EQUIPMENT_SLOTS + (GeneralConstants.NUM_INVENTORY_SLOTS * 2))) : new Vector.<int>());
            this.view.tabs.buttonsRenderedSignal.addOnce(this.onAddedHandler);
            this.addDailyQuests(_local2);
            this.addEventQuests(_local2);
        }

        private function addEventQuests(_arg1:Vector.<int>):void{
            var _local4:DailyQuest;
            var _local5:Boolean;
            var _local6:DailyQuestListElement;
            var _local2:Boolean = true;
            var _local3:Date = new Date();
            for each (_local4 in this.model.eventQuestsList) {
                _local5 = false;
                if (_local4.expiration != ""){
                    _local5 = ((Number(_local4.expiration) - (_local3.time / 1000)) < 0);
                }
                if (!((_local4.completed) || (_local5))){
                    _local6 = new DailyQuestListElement(_local4.id, _local4.name, _local4.completed, DailyQuestInfo.hasAllItems(_local4.requirements, _arg1), _local4.category);
                    if (_local2){
                        _local6.isSelected = true;
                    }
                    _local2 = false;
                    this.view.addEventToList(_local6);
                    this.hasEvent = true;
                }
            }
        }

        private function addDailyQuests(_arg1:Vector.<int>):void{
            var _local3:DailyQuest;
            var _local4:DailyQuestListElement;
            var _local2:Boolean = true;
            for each (_local3 in this.model.dailyQuestsList) {
                if (!_local3.completed){
                    _local4 = new DailyQuestListElement(_local3.id, _local3.name, _local3.completed, DailyQuestInfo.hasAllItems(_local3.requirements, _arg1), _local3.category);
                    if (_local2){
                        _local4.isSelected = true;
                    }
                    _local2 = false;
                    this.view.addQuestToList(_local4);
                }
            }
            this.onTabSelected(DailyQuestsList.QUEST_TAB_LABEL);
        }

        private function onAddedHandler():void{
            if (this.hasEvent){
                this.view.addIndicator(this.hasEvent);
            }
        }

        override public function destroy():void{
            this.view.tabs.buttonsRenderedSignal.remove(this.onAddedHandler);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.list

