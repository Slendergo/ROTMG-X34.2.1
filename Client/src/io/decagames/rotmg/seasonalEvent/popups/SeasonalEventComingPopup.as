// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.seasonalEvent.popups.SeasonalEventComingPopup

package io.decagames.rotmg.seasonalEvent.popups{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.utils.date.TimeLeft;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.text.TextFieldAutoSize;

    public class SeasonalEventComingPopup extends ModalPopup {

        private const WIDTH:int = 330;
        private const HEIGHT:int = 100;

        private var _okButton:SliceScalingButton;
        private var _scheduledDate:Date;

        public function SeasonalEventComingPopup(_arg1:Date){
            var _local2:SliceScalingBitmap;
            super(this.WIDTH, this.HEIGHT, "Seasonal Event coming!", DefaultLabelFormat.defaultSmallPopupTitle);
            this._scheduledDate = _arg1;
            _local2 = new TextureParser().getSliceScalingBitmap("UI", "main_button_decoration", 186);
            addChild(_local2);
            _local2.y = 40;
            _local2.x = Math.round(((this.WIDTH - _local2.width) / 2));
            this._okButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this._okButton.setLabel("OK", DefaultLabelFormat.questButtonCompleteLabel);
            this._okButton.width = 130;
            this._okButton.x = Math.round(((this.WIDTH - 130) / 2));
            this._okButton.y = 46;
            addChild(this._okButton);
            var _local3:String = TimeLeft.getStartTimeString(_arg1);
            var _local4:UILabel = new UILabel();
            DefaultLabelFormat.defaultSmallPopupTitle(_local4);
            _local4.width = this.WIDTH;
            _local4.autoSize = TextFieldAutoSize.CENTER;
            _local4.text = ("Seasonal Event starting in: " + _local3);
            _local4.y = 10;
            addChild(_local4);
        }

        public function get okButton():SliceScalingButton{
            return (this._okButton);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.popups

