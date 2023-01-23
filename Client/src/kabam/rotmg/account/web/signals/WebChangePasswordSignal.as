// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.web.signals.WebChangePasswordSignal

package kabam.rotmg.account.web.signals{
    import org.osflash.signals.Signal;
    import kabam.rotmg.account.web.model.ChangePasswordData;

    public class WebChangePasswordSignal extends Signal {

        public function WebChangePasswordSignal(){
            super(ChangePasswordData);
        }

    }
}//package kabam.rotmg.account.web.signals

