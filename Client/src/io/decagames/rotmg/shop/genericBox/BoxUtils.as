// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.genericBox.BoxUtils

package io.decagames.rotmg.shop.genericBox{
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.util.Currency;
    import io.decagames.rotmg.shop.NotEnoughResources;
    import io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo;
    import kabam.rotmg.game.model.GameModel;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

    public class BoxUtils {


        public static function moneyCheckPass(_arg1:GenericBoxInfo, _arg2:int, _arg3:GameModel, _arg4:PlayerModel, _arg5:ShowPopupSignal):Boolean{
            var _local6:int;
            var _local7:int;
            if (((_arg1.isOnSale()) && ((_arg1.saleAmount > 0)))){
                _local6 = int(_arg1.saleCurrency);
                _local7 = (int(_arg1.saleAmount) * _arg2);
            }
            else {
                _local6 = int(_arg1.priceCurrency);
                _local7 = (int(_arg1.priceAmount) * _arg2);
            };
            var _local8:Boolean = true;
            var _local9:int;
            var _local10:int;
            var _local11:Player = _arg3.player;
            if (_local11 != null){
                _local10 = _local11.credits_;
                _local9 = _local11.fame_;
            }
            else {
                if (_arg4 != null){
                    _local10 = _arg4.getCredits();
                    _local9 = _arg4.getFame();
                };
            };
            if ((((_local6 == Currency.GOLD)) && ((_local10 < _local7)))){
                _arg5.dispatch(new NotEnoughResources(300, Currency.GOLD));
                _local8 = false;
            }
            else {
                if ((((_local6 == Currency.FAME)) && ((_local9 < _local7)))){
                    _arg5.dispatch(new NotEnoughResources(300, Currency.FAME));
                    _local8 = false;
                };
            };
            return (_local8);
        }


    }
}//package io.decagames.rotmg.shop.genericBox

