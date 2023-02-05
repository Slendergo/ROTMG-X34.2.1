// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.application.model.PlatformModel

package kabam.rotmg.application.model{
    import flash.display.DisplayObjectContainer;
    import flash.system.Capabilities;
    import flash.display.LoaderInfo;
    import kabam.rotmg.application.*;

    public class PlatformModel {

        private const DESKTOP:String = "Desktop";

        public function isWeb():Boolean{
            return Capabilities.playerType != DESKTOP;
        }

        public function isDesktop():Boolean{
            return Capabilities.playerType == DESKTOP;
        }
    }
}//package kabam.rotmg.application.model

