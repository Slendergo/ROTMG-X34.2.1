// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.web.model.WebMoneyConfig

package kabam.rotmg.account.web.model{
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.text.model.TextKey;
    import com.company.assembleegameclient.util.offer.Offer;
    import kabam.rotmg.text.view.stringBuilder.StringBuilder;
    import kabam.rotmg.account.core.model.*;

    public class WebMoneyConfig implements MoneyConfig {


        public function showPaymentMethods():Boolean{
            return (true);
        }

        public function showBonuses():Boolean{
            return (true);
        }

        public function parseOfferPrice(_arg1:Offer):StringBuilder{
            return (new LineBuilder().setParams(TextKey.PAYMENTS_WEB_COST, {cost:_arg1.price_}));
        }

        public function jsInitializeFunction():String{
            return ("rotmg.KabamPayment.setupRotmgAccount");
        }


    }
}//package kabam.rotmg.account.web.model

