// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.NotEnoughResources

package io.decagames.rotmg.shop{
    import io.decagames.rotmg.ui.popups.modal.TextModal;
    import com.company.assembleegameclient.util.Currency;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.ui.popups.modal.buttons.ClosePopupButton;
    import io.decagames.rotmg.ui.popups.modal.buttons.BuyGoldButton;

    public class NotEnoughResources extends TextModal {

        public function NotEnoughResources(_arg1:int, _arg2:int){
            var _local3:String = (((_arg2 == Currency.GOLD)) ? "gold" : "fame");
            var _local4:String = (((_arg2 == Currency.GOLD)) ? "You do not have enough Gold for this item. Would you like to buy Gold?" : "You do not have enough Fame for this item. You gain Fame when your character dies after having accomplished great things.");
            var _local5:Vector.<BaseButton> = new Vector.<BaseButton>();
            _local5.push(new ClosePopupButton("Cancel"));
            if ((_arg2 == Currency.GOLD)){
                _local5.push(new BuyGoldButton());
            };
            super(_arg1, ("Not enough " + _local3), _local4, _local5);
        }

    }
}//package io.decagames.rotmg.shop

