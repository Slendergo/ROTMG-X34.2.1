// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.popup.ability.NewAbilityUnlockedDialog

package io.decagames.rotmg.pets.popup.ability{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import io.decagames.rotmg.ui.texture.TextureParser;

    public class NewAbilityUnlockedDialog extends ModalPopup {

        private var _okButton:SliceScalingButton;

        public function NewAbilityUnlockedDialog(_arg1:String){
            var _local2:UILabel;
            var _local4:UILabel;
            var _local5:SliceScalingBitmap;
            super(270, 120, LineBuilder.getLocalizedStringFromKey("NewAbility.gratz"));
            _local2 = new UILabel();
            DefaultLabelFormat.newAbilityInfo(_local2);
            _local2.y = 5;
            _local2.width = _contentWidth;
            _local2.wordWrap = true;
            _local2.text = LineBuilder.getLocalizedStringFromKey("NewAbility.text");
            addChild(_local2);
            var _local3:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", 229);
            addChild(_local3);
            _local3.height = 35;
            _local3.y = ((_local2.y + _local2.textHeight) + 10);
            _local3.x = Math.round(((_contentWidth - _local3.width) / 2));
            _local4 = new UILabel();
            DefaultLabelFormat.newAbilityName(_local4);
            _local4.y = (_local3.y + 8);
            _local4.width = _contentWidth;
            _local4.wordWrap = true;
            _local4.text = _arg1;
            addChild(_local4);
            _local5 = new TextureParser().getSliceScalingBitmap("UI", "main_button_decoration", 194);
            addChild(_local5);
            _local5.y = ((_local3.y + _local3.height) + 10);
            _local5.x = Math.round(((_contentWidth - _local5.width) / 2));
            this._okButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this._okButton.setLabel(LineBuilder.getLocalizedStringFromKey("NewAbility.righteous"), DefaultLabelFormat.questButtonCompleteLabel);
            this._okButton.width = 149;
            this._okButton.x = Math.round(((_contentWidth - this._okButton.width) / 2));
            this._okButton.y = (_local5.y + 6);
            addChild(this._okButton);
        }

        public function get okButton():SliceScalingButton{
            return (this._okButton);
        }


    }
}//package io.decagames.rotmg.pets.popup.ability

