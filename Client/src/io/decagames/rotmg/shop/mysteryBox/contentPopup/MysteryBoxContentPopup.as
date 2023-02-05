// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.mysteryBox.contentPopup.MysteryBoxContentPopup

package io.decagames.rotmg.shop.mysteryBox.contentPopup{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import kabam.rotmg.mysterybox.model.MysteryBoxInfo;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;

    public class MysteryBoxContentPopup extends ModalPopup {

        private var _info:MysteryBoxInfo;

        public function MysteryBoxContentPopup(_arg1:MysteryBoxInfo){
            var _local2:UILabel;
            this._info = _arg1;
            super(280, 0, _arg1.title, DefaultLabelFormat.defaultSmallPopupTitle);
            _local2 = new UILabel();
            DefaultLabelFormat.mysteryBoxContentInfo(_local2);
            _local2.multiline = true;
            switch (_arg1.rolls){
                case 1:
                    _local2.text = "You will win one\nof the rewards listed below!";
                    break;
                case 2:
                    _local2.text = "You will win two\nof the rewards listed below!";
                    break;
                case 3:
                    _local2.text = "You will win three\nof the rewards listed below!";
                    break;
            }
            _local2.x = ((280 - _local2.textWidth) / 2);
            addChild(_local2);
        }

        public function get info():MysteryBoxInfo{
            return (this._info);
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.contentPopup

