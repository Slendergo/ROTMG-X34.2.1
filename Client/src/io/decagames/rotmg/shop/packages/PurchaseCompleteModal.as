// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.packages.PurchaseCompleteModal

package io.decagames.rotmg.shop.packages{
    import io.decagames.rotmg.ui.popups.modal.TextModal;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.ui.popups.modal.buttons.ClosePopupButton;
    import kabam.rotmg.packages.model.PackageInfo;

    public class PurchaseCompleteModal extends TextModal {

        public function PurchaseCompleteModal(_arg1:String){
            var _local2:Vector.<BaseButton> = new Vector.<BaseButton>();
            _local2.push(new ClosePopupButton("OK"));
            var _local3 = "";
            switch (_arg1){
                case PackageInfo.PURCHASE_TYPE_SLOTS_ONLY:
                    _local3 = "Your purchase has been validated!";
                    break;
                case PackageInfo.PURCHASE_TYPE_CONTENTS_ONLY:
                    _local3 = "Your items have been sent to the Gift Chest!";
                    break;
                case PackageInfo.PURCHASE_TYPE_MIXED:
                    _local3 = "Your purchase has been validated! You will find your items in the Gift Chest.";
                    break;
            };
            super(300, "Package Purchased", _local3, _local2);
        }

    }
}//package io.decagames.rotmg.shop.packages

