// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.popups.modal.error.ErrorModal

package io.decagames.rotmg.ui.popups.modal.error{
    import io.decagames.rotmg.ui.popups.modal.TextModal;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.ui.popups.modal.buttons.ClosePopupButton;

    public class ErrorModal extends TextModal {

        public function ErrorModal(_arg1:int, _arg2:String, _arg3:String){
            var _local4:Vector.<BaseButton> = new Vector.<BaseButton>();
            _local4.push(new ClosePopupButton("Ok"));
            super(_arg1, _arg2, _arg3, _local4);
        }

    }
}//package io.decagames.rotmg.ui.popups.modal.error

