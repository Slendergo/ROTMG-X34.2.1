// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.dailyQuests.model.DailyQuestsModel

package io.decagames.rotmg.dailyQuests.model{
    import io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot;
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.ui.signals.UpdateQuestSignal;
    import kabam.rotmg.constants.GeneralConstants;
    import io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfo;

    public class DailyQuestsModel {

        public var currentQuest:DailyQuest;
        public var isPopupOpened:Boolean;
        public var categoriesWeight:Array;
        public var selectedItem:int = -1;
        private var _questsList:Vector.<DailyQuest>;
        private var _dailyQuestsList:Vector.<DailyQuest>;
        private var _eventQuestsList:Vector.<DailyQuest>;
        private var slots:Vector.<DailyQuestItemSlot>;
        private var _nextRefreshPrice:int;
        private var _hasQuests:Boolean;
        [Inject]
        public var hud:HUDModel;
        [Inject]
        public var updateQuestSignal:UpdateQuestSignal;

        public function DailyQuestsModel(){
            this.categoriesWeight = [1, 0, 2, 3, 4];
            this._dailyQuestsList = new <DailyQuest>[];
            this._eventQuestsList = new <DailyQuest>[];
            this.slots = new <DailyQuestItemSlot>[];
            super();
        }

        public function registerSelectableSlot(_arg1:DailyQuestItemSlot):void{
            this.slots.push(_arg1);
        }

        public function unregisterSelectableSlot(_arg1:DailyQuestItemSlot):void{
            var _local2:int = this.slots.indexOf(_arg1);
            if (_local2 != -1){
                this.slots.splice(_local2, 1);
            }
        }

        public function unselectAllSlots(_arg1:int):void{
            var _local2:DailyQuestItemSlot;
            for each (_local2 in this.slots) {
                if (_local2.itemID != _arg1){
                    _local2.selected = false;
                }
            }
        }

        public function clear():void{
            this._dailyQuestsList.length = 0;
            this._eventQuestsList.length = 0;
            if (this._questsList){
                this._questsList.length = 0;
            }
        }

        public function addQuests(_arg1:Vector.<DailyQuest>):void{
            var _local2:DailyQuest;
            this._questsList = _arg1;
            if (this._questsList.length > 0){
                this._hasQuests = true;
            }
            for each (_local2 in this._questsList) {
                this.addQuestToCategoryList(_local2);
            }
            this.updateQuestSignal.dispatch(UpdateQuestSignal.QUEST_LIST_LOADED);
        }

        public function addQuestToCategoryList(_arg1:DailyQuest):void{
            if (_arg1.category == 7){
                this._eventQuestsList.push(_arg1);
            }
            else {
                this._dailyQuestsList.push(_arg1);
            }
        }

        public function markAsCompleted(_arg1:String):void{
            var _local2:DailyQuest;
            for each (_local2 in this._questsList) {
                if ((((_local2.id == _arg1)) && (!(_local2.repeatable)))){
                    _local2.completed = true;
                }
            }
        }

        public function get playerItemsFromInventory():Vector.<int>{
            var _local1:Vector.<int> = ((this.hud.gameSprite.map.player_) ? this.hud.gameSprite.map.player_.equipment_.slice((GeneralConstants.NUM_EQUIPMENT_SLOTS - 1), (GeneralConstants.NUM_EQUIPMENT_SLOTS + (GeneralConstants.NUM_INVENTORY_SLOTS * 2))) : new Vector.<int>());
            return (_local1);
        }

        public function get numberOfActiveQuests():int{
            return (this._questsList.length);
        }

        public function get numberOfCompletedQuests():int{
            var _local2:DailyQuest;
            var _local1:int;
            for each (_local2 in this._questsList) {
                if (_local2.completed){
                    _local1++;
                }
            }
            return (_local1);
        }

        public function get questsList():Vector.<DailyQuest>{
            var _local1:Vector.<DailyQuest> = this._questsList.concat();
            return (_local1.sort(this.questsCompleteSort));
        }

        private function questsNameSort(_arg1:DailyQuest, _arg2:DailyQuest):int{
            if (_arg1.name > _arg2.name){
                return (1);
            }
            return (-1);
        }

        private function sortByCategory(_arg1:DailyQuest, _arg2:DailyQuest):int{
            if (this.categoriesWeight[_arg1.category] < this.categoriesWeight[_arg2.category]){
                return (-1);
            }
            if (this.categoriesWeight[_arg1.category] > this.categoriesWeight[_arg2.category]){
                return (1);
            }
            return (this.questsNameSort(_arg1, _arg2));
        }

        private function questsReadySort(_arg1:DailyQuest, _arg2:DailyQuest):int{
            var _local3:Boolean = DailyQuestInfo.hasAllItems(_arg1.requirements, this.playerItemsFromInventory);
            var _local4:Boolean = DailyQuestInfo.hasAllItems(_arg2.requirements, this.playerItemsFromInventory);
            if (((_local3) && (!(_local4)))){
                return (-1);
            }
            if (((_local3) && (_local4))){
                return (this.questsNameSort(_arg1, _arg2));
            }
            return (1);
        }

        private function questsCompleteSort(_arg1:DailyQuest, _arg2:DailyQuest):int{
            if (((_arg1.completed) && (!(_arg2.completed)))){
                return (1);
            }
            if (((_arg1.completed) && (_arg2.completed))){
                return (this.sortByCategory(_arg1, _arg2));
            }
            if (((!(_arg1.completed)) && (!(_arg2.completed)))){
                return (this.sortByCategory(_arg1, _arg2));
            }
            return (-1);
        }

        public function getQuestById(_arg1:String):DailyQuest{
            var _local2:DailyQuest;
            for each (_local2 in this._questsList) {
                if (_local2.id == _arg1){
                    return (_local2);
                }
            }
            return (null);
        }

        public function get first():DailyQuest{
            if (this._questsList.length > 0){
                return (this.questsList[0]);
            }
            return (null);
        }

        public function get nextRefreshPrice():int{
            return (this._nextRefreshPrice);
        }

        public function set nextRefreshPrice(_arg1:int):void{
            this._nextRefreshPrice = _arg1;
        }

        public function get dailyQuestsList():Vector.<DailyQuest>{
            return (this._dailyQuestsList);
        }

        public function get eventQuestsList():Vector.<DailyQuest>{
            return (this._eventQuestsList);
        }

        public function removeQuestFromlist(_arg1:DailyQuest):void{
            var _local2:int;
            while (_local2 < this._eventQuestsList.length) {
                if (_arg1.id == this._eventQuestsList[_local2].id){
                    this._eventQuestsList.splice(_local2, 1);
                }
                _local2++;
            }
            var _local3:int;
            while (_local3 < this._questsList.length) {
                if (_arg1.id == this._questsList[_local3].id){
                    this._questsList.splice(_local3, 1);
                }
                _local3++;
            }
        }

        public function get hasQuests():Boolean{
            return (this._hasQuests);
        }


    }
}//package io.decagames.rotmg.dailyQuests.model

