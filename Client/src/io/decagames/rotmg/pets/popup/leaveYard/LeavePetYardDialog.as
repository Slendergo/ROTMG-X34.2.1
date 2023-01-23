// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.popup.leaveYard.LeavePetYardDialog

package io.decagames.rotmg.pets.popup.leaveYard{
    import io.decagames.rotmg.ui.popups.modal.TextModal;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.text.model.TextKey;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import io.decagames.rotmg.ui.popups.modal.buttons.ClosePopupButton;

    public class LeavePetYardDialog extends TextModal {

        private var _leaveButton:SliceScalingButton;

        public function LeavePetYardDialog(){
            var _local1:Vector.<BaseButton>;
            _local1 = new Vector.<BaseButton>();
            this._leaveButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this._leaveButton.width = 100;
            this._leaveButton.setLabel(LineBuilder.getLocalizedStringFromKey(TextKey.PET_DIALOG_LEAVE), DefaultLabelFormat.defaultButtonLabel);
            _local1.push(new ClosePopupButton(LineBuilder.getLocalizedStringFromKey(TextKey.PET_DIALOG_REMAIN)));
            _local1.push(this.leaveButton);
            super(300, LineBuilder.getLocalizedStringFromKey("LeavePetYardDialog.title"), LineBuilder.getLocalizedStringFromKey("LeavePetYardDialog.text"), _local1);
        }

        public function get leaveButton():SliceScalingButton{
            return (this._leaveButton);
        }


    }
}//package io.decagames.rotmg.pets.popup.leaveYard

