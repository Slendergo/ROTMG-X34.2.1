// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.dailyQuests.view.popup.DailyQuestRefreshPopup

package io.decagames.rotmg.dailyQuests.view.popup{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;

    public class DailyQuestRefreshPopup extends ModalPopup {

        private const TITLE:String = "Refresh Daily Quests";
        private const TEXT:String = "Do you want to refresh your Daily Quests? All Daily Quests will be refreshed!";
        private const WIDTH:int = 300;
        private const HEIGHT:int = 100;

        private var _refreshPrice:int;
        private var _buyQuestRefreshButton:BuyQuestRefreshButton;

        public function DailyQuestRefreshPopup(_arg1:int){
            super(this.WIDTH, this.HEIGHT, this.TITLE);
            this._refreshPrice = _arg1;
            this.init();
        }

        private function init():void{
            var _local1:UILabel = new UILabel();
            _local1.width = 280;
            _local1.multiline = true;
            _local1.wordWrap = true;
            _local1.text = this.TEXT;
            DefaultLabelFormat.defaultSmallPopupTitle(_local1, TextFormatAlign.CENTER);
            _local1.x = ((this.WIDTH - _local1.width) / 2);
            _local1.y = 10;
            addChild(_local1);
            this._buyQuestRefreshButton = new BuyQuestRefreshButton(this._refreshPrice);
            this._buyQuestRefreshButton.x = ((this.WIDTH - this._buyQuestRefreshButton.width) / 2);
            this._buyQuestRefreshButton.y = 60;
            addChild(this._buyQuestRefreshButton);
        }

        public function get buyQuestRefreshButton():BuyQuestRefreshButton{
            return (this._buyQuestRefreshButton);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.popup

