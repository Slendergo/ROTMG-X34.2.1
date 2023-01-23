// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.supportCampaign.tab.donate.popup.DonateConfirmationPopup

package io.decagames.rotmg.supportCampaign.tab.donate.popup{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import io.decagames.rotmg.shop.ShopBuyButton;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;
    import io.decagames.rotmg.ui.texture.TextureParser;

    public class DonateConfirmationPopup extends ModalPopup {

        private var _donateButton:ShopBuyButton;
        private var supportIcon:SliceScalingBitmap;
        private var _gold:int;

        public function DonateConfirmationPopup(_arg1:int, _arg2:int){
            var _local6:SliceScalingBitmap;
            super(240, 130, "Boost");
            this._gold = _arg1;
            var _local3:UILabel = new UILabel();
            _local3.text = "You will receive:";
            DefaultLabelFormat.createLabelFormat(_local3, 14, 0x999999, TextFormatAlign.CENTER, false);
            _local3.wordWrap = true;
            _local3.width = _contentWidth;
            _local3.y = 5;
            addChild(_local3);
            this.supportIcon = TextureParser.instance.getSliceScalingBitmap("UI", "campaign_Points");
            addChild(this.supportIcon);
            var _local4:UILabel = new UILabel();
            _local4.text = _arg2.toString();
            DefaultLabelFormat.createLabelFormat(_local4, 22, 15585539, TextFormatAlign.CENTER, true);
            _local4.x = (((_contentWidth / 2) - (_local4.width / 2)) - 10);
            _local4.y = 25;
            addChild(_local4);
            this.supportIcon.y = (_local4.y + 3);
            this.supportIcon.x = (_local4.x + _local4.width);
            var _local5:UILabel = new UILabel();
            _local5.text = "Bonus Points";
            DefaultLabelFormat.createLabelFormat(_local5, 14, 0x999999, TextFormatAlign.CENTER, false);
            _local5.wordWrap = true;
            _local5.width = _contentWidth;
            _local5.y = 50;
            addChild(_local5);
            _local6 = new TextureParser().getSliceScalingBitmap("UI", "main_button_decoration", 148);
            addChild(_local6);
            this._donateButton = new ShopBuyButton(_arg1);
            this._donateButton.width = (_local6.width - 45);
            addChild(this._donateButton);
            _local6.y = (_contentHeight - 50);
            _local6.x = Math.round(((_contentWidth - _local6.width) / 2));
            this._donateButton.y = (_local6.y + 6);
            this._donateButton.x = (_local6.x + 22);
        }

        public function get donateButton():ShopBuyButton{
            return (this._donateButton);
        }

        public function get gold():int{
            return (this._gold);
        }


    }
}//package io.decagames.rotmg.supportCampaign.tab.donate.popup

