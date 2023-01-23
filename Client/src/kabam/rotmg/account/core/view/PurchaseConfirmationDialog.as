// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.core.view.PurchaseConfirmationDialog

package kabam.rotmg.account.core.view{
    import com.company.assembleegameclient.ui.dialogs.Dialog;

    public class PurchaseConfirmationDialog extends Dialog {

        public var confirmedHandler:Function;

        public function PurchaseConfirmationDialog(_arg1:Function):void{
            super("Purchase confirmation", "Continue with purchase?", "Yes", "No", null);
            this.confirmedHandler = _arg1;
        }

    }
}//package kabam.rotmg.account.core.view

