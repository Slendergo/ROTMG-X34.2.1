// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.popup.upgradeYard.PetYardUpgradeDialog

package io.decagames.rotmg.pets.popup.upgradeYard{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import io.decagames.rotmg.shop.ShopBuyButton;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import com.company.assembleegameclient.util.Currency;
    import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;

    public class PetYardUpgradeDialog extends ModalPopup {

        private var _upgradeGoldButton:ShopBuyButton;
        private var _upgradeFameButton:ShopBuyButton;
        private var upgradeButtonsMargin:int = 20;

        public function PetYardUpgradeDialog(_arg1:PetRarityEnum, _arg2:int, _arg3:int){
            var _local4:SliceScalingBitmap;
            var _local5:UILabel;
            var _local6:UILabel;
            super(270, 0, "Upgrade Pet Yard");
            _local4 = TextureParser.instance.getSliceScalingBitmap("UI", ("petYard_" + LineBuilder.getLocalizedStringFromKey((("{" + _arg1.rarityKey) + "}"))));
            _local4.x = Math.round(((contentWidth - _local4.width) / 2));
            addChild(_local4);
            _local5 = new UILabel();
            DefaultLabelFormat.petYardUpgradeInfo(_local5);
            _local5.x = 50;
            _local5.y = (_local4.height + 10);
            _local5.width = 170;
            _local5.wordWrap = true;
            _local5.text = LineBuilder.getLocalizedStringFromKey("YardUpgraderView.info");
            addChild(_local5);
            _local6 = new UILabel();
            DefaultLabelFormat.petYardUpgradeRarityInfo(_local6);
            _local6.y = ((_local5.y + _local5.textHeight) + 8);
            _local6.width = contentWidth;
            _local6.wordWrap = true;
            _local6.text = LineBuilder.getLocalizedStringFromKey((("{" + _arg1.rarityKey) + "}"));
            addChild(_local6);
            this._upgradeGoldButton = new ShopBuyButton(_arg2, Currency.GOLD);
            this._upgradeFameButton = new ShopBuyButton(_arg3, Currency.FAME);
            this._upgradeGoldButton.width = (this._upgradeFameButton.width = 120);
            this._upgradeGoldButton.y = (this._upgradeFameButton.y = ((_local6.y + _local6.height) + 15));
            var _local7:int = ((contentWidth - ((this._upgradeGoldButton.width + this._upgradeFameButton.width) + this.upgradeButtonsMargin)) / 2);
            this._upgradeGoldButton.x = _local7;
            this._upgradeFameButton.x = ((this._upgradeGoldButton.x + this._upgradeGoldButton.width) + this.upgradeButtonsMargin);
            addChild(this._upgradeGoldButton);
            addChild(this._upgradeFameButton);
        }

        public function get upgradeGoldButton():ShopBuyButton{
            return (this._upgradeGoldButton);
        }

        public function get upgradeFameButton():ShopBuyButton{
            return (this._upgradeFameButton);
        }


    }
}//package io.decagames.rotmg.pets.popup.upgradeYard

