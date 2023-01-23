// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.packages.control.IsPackageAffordableGuard

package kabam.rotmg.packages.control{
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
    import kabam.rotmg.packages.model.PackageInfo;
    import robotlegs.bender.framework.api.*;

    public class IsPackageAffordableGuard implements IGuard {

        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var openMoneyWindow:OpenMoneyWindowSignal;
        [Inject]
        public var packageInfo:PackageInfo;


        public function approve():Boolean{
            var _local1 = (this.playerModel.getCredits() >= this.packageInfo.priceAmount);
            if (!_local1){
                this.openMoneyWindow.dispatch();
            };
            return (_local1);
        }


    }
}//package kabam.rotmg.packages.control

