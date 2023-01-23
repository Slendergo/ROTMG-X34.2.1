// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.kongregate.model.KongregateMoneyConfig

package kabam.rotmg.account.kongregate.model{
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.text.model.TextKey;
    import com.company.assembleegameclient.util.offer.Offer;
    import kabam.rotmg.text.view.stringBuilder.StringBuilder;
    import kabam.rotmg.account.core.model.*;

    public class KongregateMoneyConfig implements MoneyConfig {


        public function showPaymentMethods():Boolean{
            return (false);
        }

        public function showBonuses():Boolean{
            return (false);
        }

        public function parseOfferPrice(_arg1:Offer):StringBuilder{
            return (new LineBuilder().setParams(TextKey.PAYMENTS_KONGREGATE_COST, {cost:_arg1.price_}));
        }

        public function jsInitializeFunction():String{
            throw (new Error("No current support for new Kabam offer wall on Kongregate."));
        }


    }
}//package kabam.rotmg.account.kongregate.model

