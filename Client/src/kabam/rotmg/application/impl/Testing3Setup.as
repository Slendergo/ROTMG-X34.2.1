﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.application.impl.Testing3Setup

package kabam.rotmg.application.impl{
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.application.api.*;

    public class Testing3Setup implements ApplicationSetup {

        private const SERVER:String = "test3.realmofthemadgod.com";
        private const UNENCRYPTED:String = ("http://" + SERVER);
        private const ENCRYPTED:String = ("https://" + SERVER);
        private const BUILD_LABEL:String = "<font color='#FF0000'>TESTING 3 </font> #{VERSION}";


        public function getAppEngineUrl(_arg1:Boolean=false):String{
            return (this.ENCRYPTED);
        }

        public function getBuildLabel():String{
            var _local1:String = ((Parameters.BUILD_VERSION + ".") + Parameters.MINOR_VERSION);
            return (this.BUILD_LABEL.replace("{VERSION}", _local1));
        }

        public function useLocalTextures():Boolean{
            return true;
        }

        public function isToolingEnabled():Boolean{
            return true;
        }

        public function isServerLocal():Boolean{
            return false;
        }

        public function isGameLoopMonitored():Boolean{
            return true;
        }

        public function areErrorsReported():Boolean{
            return false;
        }

        public function useProductionDialogs():Boolean{
            return true;
        }

        public function areDeveloperHotkeysEnabled():Boolean{
            return false;
        }

        public function isDebug():Boolean{
            return false;
        }

        public function getServerDomain():String{
            return (this.SERVER);
        }


    }
}//package kabam.rotmg.application.impl

