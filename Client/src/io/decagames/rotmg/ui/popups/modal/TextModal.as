// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.popups.modal.TextModal

package io.decagames.rotmg.ui.popups.modal{
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;

    public class TextModal extends ModalPopup {

        private var buttonsMargin:int = 30;

        public function TextModal(_arg1:int, _arg2:String, _arg3:String, _arg4:Vector.<BaseButton>, _arg5:Boolean=false){
            var _local6:UILabel;
            var _local8:BaseButton;
            var _local9:int;
            super(_arg1, 0, _arg2);
            _local6 = new UILabel();
            _local6.multiline = true;
            DefaultLabelFormat.defaultTextModalText(_local6);
            _local6.multiline = true;
            _local6.width = _arg1;
            if (_arg5){
                _local6.htmlText = _arg3;
            }
            else {
                _local6.text = _arg3;
            };
            _local6.wordWrap = true;
            addChild(_local6);
            var _local7:int;
            for each (_local8 in _arg4) {
                _local7 = (_local7 + _local8.width);
            };
            _local7 = (_local7 + (this.buttonsMargin * (_arg4.length - 1)));
            _local9 = ((_arg1 - _local7) / 2);
            for each (_local8 in _arg4) {
                _local8.x = _local9;
                _local9 = (_local9 + (this.buttonsMargin + _local8.width));
                _local8.y = ((_local6.y + _local6.textHeight) + 15);
                addChild(_local8);
                registerButton(_local8);
            };
        }

    }
}//package io.decagames.rotmg.ui.popups.modal

