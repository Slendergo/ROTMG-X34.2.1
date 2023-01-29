﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.application.impl.PrivateSetup

package kabam.rotmg.application.impl{
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.application.api.*;

    public class PrivateSetup implements ApplicationSetup {

        private const SERVER:String = "test.realmofthemadgod.com";
        private const UNENCRYPTED:String = ("http://" + SERVER);
        private const ENCRYPTED:String = ("https://" + SERVER);
        private const BUILD_LABEL:String = "<font color='#FFEE00'>TESTING APP ENGINE, PRIVATE SERVER</font> #{VERSION}";


        public function getAppEngineUrl(_arg1:Boolean=false):String{
            return (((_arg1) ? this.UNENCRYPTED : this.ENCRYPTED));
        }

        public function getBuildLabel():String{
            var _local1:String = ((Parameters.BUILD_VERSION + ".") + Parameters.MINOR_VERSION);
            return (this.BUILD_LABEL.replace("{VERSION}", _local1));
        }

        public function useLocalTextures():Boolean{
            return (true);
        }

        public function isToolingEnabled():Boolean{
            return (true);
        }

        public function isServerLocal():Boolean{
            return (false);
        }

        public function isGameLoopMonitored():Boolean{
            return (true);
        }

        public function useProductionDialogs():Boolean{
            return (false);
        }

        public function areErrorsReported():Boolean{
            return (false);
        }

        public function areDeveloperHotkeysEnabled():Boolean{
            return (true);
        }

        public function isDebug():Boolean{
            return (true);
        }

        public function getServerDomain():String{
            return (this.SERVER);
        }


    }
}//package kabam.rotmg.application.impl

