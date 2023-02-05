// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.application.model.DomainModel

package kabam.rotmg.application.model{
    import flash.system.Security;
    import flash.net.LocalConnection;

    public class DomainModel {

        private const LOCALHOST:String = "localhost";
        private const PRODUCTION_WHITELIST:Array = ["www.realmofthemadgod.com", "realmofthemadgodhrd.appspot.com", "realmofthemadgod.appspot.com"];
        private const TESTING_WHITELIST:Array = ["test.realmofthemadgod.com", "testing.realmofthemadgod.com", "rotmgtesting.appspot.com", "rotmghrdtesting.appspot.com"];
        private const TESTING2_WHITELIST:Array = ["realmtesting2.appspot.com", "test2.realmofthemadgod.com"];
        private const TESTING3_WHITELIST:Array = ["rotmgtesting3.appspot.com", "test3.realmofthemadgod.com"];
        private const TRANSLATION_WHITELIST:Array = ["xlate.kabam.com"];
        private const WHITELIST:Array = PRODUCTION_WHITELIST.AS3::concat(TESTING_WHITELIST).AS3::concat(TRANSLATION_WHITELIST).AS3::concat(TESTING2_WHITELIST).AS3::concat(TESTING3_WHITELIST);

        [Inject]
        public var client:PlatformModel;
        private var localDomain:String;


        public function applyDomainSecurity():void{
            var _local1:String;
            for each (_local1 in this.WHITELIST) {
                Security.allowDomain(_local1);
            }
        }

        public function isLocalDomainValid():Boolean{
            return (((this.client.isDesktop()) || (this.isLocalDomainInWhiteList())));
        }

        public function isLocalDomainProduction():Boolean{
            var _local1:String = this.getLocalDomain();
            return (!((this.PRODUCTION_WHITELIST.indexOf(_local1) == -1)));
        }

        private function isLocalDomainInWhiteList():Boolean{
            var _local3:String;
            var _local1:String = this.getLocalDomain();
            var _local2 = (_local1 == this.LOCALHOST);
            for each (_local3 in this.WHITELIST) {
                _local2 = ((_local2) || ((_local1 == _local3)));
            }
            return (_local2);
        }

        private function getLocalDomain():String{
            return ((this.localDomain = ((this.localDomain) || (new LocalConnection().domain))));
        }
    }
}//package kabam.rotmg.application.model

