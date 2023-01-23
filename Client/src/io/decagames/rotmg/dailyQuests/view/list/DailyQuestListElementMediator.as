// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.dailyQuests.view.list.DailyQuestListElementMediator

package io.decagames.rotmg.dailyQuests.view.list{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.dailyQuests.signal.ShowQuestInfoSignal;
    import flash.events.MouseEvent;

    public class DailyQuestListElementMediator extends Mediator {

        [Inject]
        public var view:DailyQuestListElement;
        [Inject]
        public var showInfoSignal:ShowQuestInfoSignal;


        override public function initialize():void{
            this.showInfoSignal.add(this.resetElement);
            this.view.addEventListener(MouseEvent.CLICK, this.onClickHandler);
        }

        private function resetElement(_arg1:String, _arg2:int, _arg3:String):void{
            if ((((_arg1 == "")) || ((_arg2 == -1)))){
                return;
            };
            if (_arg1 != this.view.id){
                if (((!((_arg2 == 7))) && (!((this.view.category == 7))))){
                    this.view.isSelected = false;
                }
                else {
                    if (_arg2 == this.view.category){
                        this.view.isSelected = false;
                    };
                };
            };
        }

        override public function destroy():void{
            this.view.removeEventListener(MouseEvent.CLICK, this.onClickHandler);
        }

        private function onClickHandler(_arg1:MouseEvent):void{
            this.view.isSelected = true;
            var _local2:String = (((this.view.category == 7)) ? DailyQuestsList.EVENT_TAB_LABEL : DailyQuestsList.QUEST_TAB_LABEL);
            this.showInfoSignal.dispatch(this.view.id, this.view.category, _local2);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.list

