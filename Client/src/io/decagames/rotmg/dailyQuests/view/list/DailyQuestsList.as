// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.dailyQuests.view.list.DailyQuestsList

package io.decagames.rotmg.dailyQuests.view.list{
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.tabs.UITabs;
    import io.decagames.rotmg.ui.tabs.TabButton;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.tabs.UITab;
    import io.decagames.rotmg.ui.scroll.UIScrollbar;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.ui.tabs.*;

    public class DailyQuestsList extends Sprite {

        public static const QUEST_TAB_LABEL:String = "Quests";
        public static const EVENT_TAB_LABEL:String = "Events";
        public static const SCROLL_BAR_HEIGHT:int = 345;

        private var questLinesPosition:int = 0;
        private var eventLinesPosition:int = 0;
        private var questsContainer:Sprite;
        private var eventsContainer:Sprite;
        private var _tabs:UITabs;
        private var eventsTab:TabButton;
        private var contentTabs:SliceScalingBitmap;
        private var contentInset:SliceScalingBitmap;
        private var _dailyQuestElements:Vector.<DailyQuestListElement>;
        private var _eventQuestElements:Vector.<DailyQuestListElement>;

        public function DailyQuestsList(){
            this.init();
        }

        private function init():void{
            this.createContentTabs();
            this.createContentInset();
            this.createTabs();
        }

        private function createTabs():void{
            this._tabs = new UITabs(230, true);
            this._tabs.addTab(this.createQuestsTab(), true);
            this._tabs.addTab(this.createEventsTab());
            this._tabs.y = 1;
            addChild(this._tabs);
        }

        private function createContentInset():void{
            this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", 230);
            this.contentInset.height = 360;
            this.contentInset.y = 35;
            addChild(this.contentInset);
        }

        private function createContentTabs():void{
            this.contentTabs = TextureParser.instance.getSliceScalingBitmap("UI", "tab_inset_content_background", 230);
            this.contentTabs.height = 45;
            addChild(this.contentTabs);
        }

        private function createQuestsTab():UITab{
            var _local4:Sprite;
            var _local1:UITab = new UITab(QUEST_TAB_LABEL);
            var _local2:Sprite = new Sprite();
            this.questsContainer = new Sprite();
            this.questsContainer.x = this.contentInset.x;
            this.questsContainer.y = 10;
            _local2.addChild(this.questsContainer);
            var _local3:UIScrollbar = new UIScrollbar(SCROLL_BAR_HEIGHT);
            _local3.mouseRollSpeedFactor = 1;
            _local3.scrollObject = _local1;
            _local3.content = this.questsContainer;
            _local2.addChild(_local3);
            _local3.x = ((this.contentInset.x + this.contentInset.width) - 25);
            _local3.y = 7;
            _local4 = new Sprite();
            _local4.graphics.beginFill(0);
            _local4.graphics.drawRect(0, 0, 230, SCROLL_BAR_HEIGHT);
            _local4.x = this.questsContainer.x;
            _local4.y = this.questsContainer.y;
            this.questsContainer.mask = _local4;
            _local2.addChild(_local4);
            _local1.addContent(_local2);
            return (_local1);
        }

        private function createEventsTab():UITab{
            var _local1:UITab;
            _local1 = new UITab("Events");
            var _local2:Sprite = new Sprite();
            this.eventsContainer = new Sprite();
            this.eventsContainer.x = this.contentInset.x;
            this.eventsContainer.y = 10;
            _local2.addChild(this.eventsContainer);
            var _local3:UIScrollbar = new UIScrollbar(SCROLL_BAR_HEIGHT);
            _local3.mouseRollSpeedFactor = 1;
            _local3.scrollObject = _local1;
            _local3.content = this.eventsContainer;
            _local2.addChild(_local3);
            _local3.x = ((this.contentInset.x + this.contentInset.width) - 25);
            _local3.y = 7;
            var _local4:Sprite = new Sprite();
            _local4.graphics.beginFill(0);
            _local4.graphics.drawRect(0, 0, 230, SCROLL_BAR_HEIGHT);
            _local4.x = this.eventsContainer.x;
            _local4.y = this.eventsContainer.y;
            this.eventsContainer.mask = _local4;
            _local2.addChild(_local4);
            _local1.addContent(_local2);
            return (_local1);
        }

        public function addIndicator(_arg1:Boolean):void{
            this.eventsTab = this._tabs.getTabButtonByLabel(EVENT_TAB_LABEL);
            if (this.eventsTab){
                this.eventsTab.showIndicator = _arg1;
                this.eventsTab.clickSignal.add(this.onEventsClick);
            };
        }

        private function onEventsClick(_arg1:BaseButton):void{
            if (TabButton(_arg1).hasIndicator){
                TabButton(_arg1).showIndicator = false;
            };
        }

        public function addQuestToList(_arg1:DailyQuestListElement):void{
            if (!this._dailyQuestElements){
                this._dailyQuestElements = new <DailyQuestListElement>[];
            };
            _arg1.x = 10;
            _arg1.y = (this.questLinesPosition * 35);
            this.questsContainer.addChild(_arg1);
            this.questLinesPosition++;
            this._dailyQuestElements.push(_arg1);
        }

        public function addEventToList(_arg1:DailyQuestListElement):void{
            if (!this._eventQuestElements){
                this._eventQuestElements = new <DailyQuestListElement>[];
            };
            _arg1.x = 10;
            _arg1.y = (this.eventLinesPosition * 35);
            this.eventsContainer.addChild(_arg1);
            this.eventLinesPosition++;
            this._eventQuestElements.push(_arg1);
        }

        public function get list():Sprite{
            return (this.questsContainer);
        }

        public function get tabs():UITabs{
            return (this._tabs);
        }

        public function clearQuestLists():void{
            var _local1:DailyQuestListElement;
            while (this.questsContainer.numChildren > 0) {
                _local1 = (this.questsContainer.removeChildAt(0) as DailyQuestListElement);
                _local1 = null;
            };
            this.questLinesPosition = 0;
            ((this._dailyQuestElements) && ((this._dailyQuestElements.length = 0)));
            while (this.eventsContainer.numChildren > 0) {
                _local1 = (this.eventsContainer.removeChildAt(0) as DailyQuestListElement);
                _local1 = null;
            };
            this.eventLinesPosition = 0;
            ((this._eventQuestElements) && ((this._eventQuestElements.length = 0)));
        }

        public function getCurrentlySelected(_arg1:String):DailyQuestListElement{
            var _local2:DailyQuestListElement;
            var _local3:DailyQuestListElement;
            var _local4:DailyQuestListElement;
            if (_arg1 == QUEST_TAB_LABEL){
                for each (_local3 in this._dailyQuestElements) {
                    if (_local3.isSelected){
                        _local2 = _local3;
                        break;
                    };
                };
            }
            else {
                if (_arg1 == EVENT_TAB_LABEL){
                    for each (_local4 in this._eventQuestElements) {
                        if (_local4.isSelected){
                            _local2 = _local4;
                            break;
                        };
                    };
                };
            };
            return (_local2);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.list

