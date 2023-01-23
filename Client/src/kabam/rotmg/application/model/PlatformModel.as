﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.application.model.PlatformModel

package kabam.rotmg.application.model{
    import flash.display.DisplayObjectContainer;
    import flash.system.Capabilities;
    import flash.display.LoaderInfo;
    import kabam.rotmg.application.*;

    public class PlatformModel {

        private static var platform:PlatformType;

        private const DESKTOP:String = "Desktop";

        [Inject]
        public var root:DisplayObjectContainer;


        public function isWeb():Boolean{
            return (!((Capabilities.playerType == this.DESKTOP)));
        }

        public function isDesktop():Boolean{
            return ((Capabilities.playerType == this.DESKTOP));
        }

        public function getPlatform():PlatformType{
            return ((platform = ((platform) || (this.determinePlatform()))));
        }

        private function determinePlatform():PlatformType{
            var _local1:Object = LoaderInfo(this.root.stage.root.loaderInfo).parameters;
            if (this.isKongregate(_local1)){
                return (PlatformType.KONGREGATE);
            };
            if (this.isSteam(_local1)){
                return (PlatformType.STEAM);
            };
            if (this.isKabam(_local1)){
                return (PlatformType.KABAM);
            };
            return (PlatformType.WEB);
        }

        private function isKongregate(_arg1:Object):Boolean{
            return (!((_arg1.kongregate_api_path == null)));
        }

        private function isSteam(_arg1:Object):Boolean{
            return (!((_arg1.steam_api_path == null)));
        }

        private function isKabam(_arg1:Object):Boolean{
            return (!((_arg1.kabam_signed_request == null)));
        }


    }
}//package kabam.rotmg.application.model

