﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.build.impl.CompileTimeBuildData

package kabam.rotmg.build.impl{
    import flash.display.LoaderInfo;
    import kabam.rotmg.build.api.BuildEnvironment;
    import flash.net.LocalConnection;
    import flash.system.Capabilities;
    import kabam.rotmg.build.api.*;

    public class CompileTimeBuildData implements BuildData {

        private static const DESKTOP:String = "Desktop";
        private static const ROTMG:String = "www.realmofthemadgod.com";
        private static const ROTMG_APPSPOT:String = "realmofthemadgodhrd.appspot.com";
        private static const ROTMG_TESTING:String = "test.realmofthemadgod.com";
        private static const ROTMG_TESTING_MAP:String = "test.realmofthemadgod.com";
        private static const ROTMG_TESTING2:String = "test2.realmofthemadgod.com";
        private static const ROTMG_TESTING3:String = "test3.realmofthemadgod.com";
        private static const STEAM_PRODUCTION_CONFIG:String = "Production";

        [Inject]
        public var loaderInfo:LoaderInfo;
        [Inject]
        public var environments:BuildEnvironments;
        private var isParsed:Boolean = false;
        private var environment:BuildEnvironment;


        public function getEnvironmentString():String{
            return ("localhost".toLowerCase());
        }

        public function getEnvironment():BuildEnvironment{
            ((this.isParsed) || (this.parseEnvironment()));
            return (this.environment);
        }

        private function parseEnvironment():void{
            this.isParsed = true;
            this.setEnvironmentValue(this.getEnvironmentString());
        }

        private function setEnvironmentValue(_arg1:String):void{
            var _local3:LocalConnection;
            var _local2:Boolean = this.conditionsRequireTesting(_arg1);
            if (_local2){
                _local3 = new LocalConnection();
                if ((((_local3.domain == ROTMG_TESTING)) || ((_local3.domain == ROTMG_TESTING_MAP)))){
                    this.environment = BuildEnvironment.TESTING;
                }
                else {
                    if (_local3.domain == ROTMG_TESTING2){
                        this.environment = BuildEnvironment.TESTING2;
                    }
                    else {
                        if (_local3.domain == ROTMG_TESTING3){
                            this.environment = BuildEnvironment.TESTING3;
                        };
                    };
                };
            }
            else {
                this.environment = this.environments.getEnvironment(_arg1);
            };
        }

        private function conditionsRequireTesting(_arg1:String):Boolean{
            return ((((_arg1 == BuildEnvironments.PRODUCTION)) && (!(this.isMarkedAsProductionRelease()))));
        }

        private function isMarkedAsProductionRelease():Boolean{
            return (((this.isDesktopPlayer()) ? this.isSteamProductionDeployment() : this.isHostedOnProductionServers()));
        }

        private function isDesktopPlayer():Boolean{
            return ((Capabilities.playerType == DESKTOP));
        }

        private function isSteamProductionDeployment():Boolean{
            var _local1:Object = this.loaderInfo.parameters;
            return ((_local1.deployment == STEAM_PRODUCTION_CONFIG));
        }

        private function isHostedOnProductionServers():Boolean{
            var _local1:LocalConnection = new LocalConnection();
            return ((((_local1.domain == ROTMG)) || ((_local1.domain == ROTMG_APPSPOT))));
        }


    }
}//package kabam.rotmg.build.impl

