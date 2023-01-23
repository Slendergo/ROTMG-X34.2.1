// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.kabam.model.KabamMoneyConfig

package kabam.rotmg.account.kabam.model{
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import com.company.assembleegameclient.util.offer.Offer;
    import kabam.rotmg.text.view.stringBuilder.StringBuilder;
    import kabam.rotmg.account.core.model.*;

    public class KabamMoneyConfig implements MoneyConfig {


        public function showPaymentMethods():Boolean{
            return (true);
        }

        public function showBonuses():Boolean{
            return (false);
        }

        public function parseOfferPrice(_arg1:Offer):StringBuilder{
            return (new LineBuilder());
        }

        public function jsInitializeFunction():String{
            return ("rotmg.KabamPayment.setupKabamAccount");
        }


    }
}//package kabam.rotmg.account.kabam.model

