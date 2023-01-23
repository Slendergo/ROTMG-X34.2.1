// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.popups.modal.ConfirmationModal

package io.decagames.rotmg.ui.popups.modal{
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.ui.popups.modal.buttons.ClosePopupButton;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;

    public class ConfirmationModal extends TextModal {

        public var confirmButton:SliceScalingButton;

        public function ConfirmationModal(_arg1:int, _arg2:String, _arg3:String, _arg4:String, _arg5:String, _arg6:int=100){
            var _local7:Vector.<BaseButton>;
            _local7 = new Vector.<BaseButton>();
            var _local8:ClosePopupButton = new ClosePopupButton(_arg5);
            _local8.width = _arg6;
            this.confirmButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this.confirmButton.setLabel(_arg4, DefaultLabelFormat.defaultButtonLabel);
            this.confirmButton.width = _arg6;
            _local7.push(this.confirmButton);
            _local7.push(_local8);
            super(_arg1, _arg2, _arg3, _local7);
        }

    }
}//package io.decagames.rotmg.ui.popups.modal

