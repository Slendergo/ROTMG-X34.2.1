// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.servers.model.FixedIPServerModel

package kabam.rotmg.servers.model{
    import kabam.rotmg.servers.api.Server;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.servers.api.*;

    public class FixedIPServerModel implements ServerModel {

        private var localhost:Server;

        public function FixedIPServerModel(){
            this.localhost = new Server().setName("localhost").setPort(Parameters.PORT);
        }

        public function setIP(_arg1:String):FixedIPServerModel{
            this.localhost.setAddress(_arg1);
            return (this);
        }

        public function getServers():Vector.<Server>{
            return (new <Server>[this.localhost]);
        }

        public function getServer():Server{
            return (this.localhost);
        }

        public function isServerAvailable():Boolean{
            return true;
        }

        public function setServers(_arg1:Vector.<Server>):void{
        }

        public function setAvailableServers():void{
        }

        public function getAvailableServers():Vector.<Server>{
            return (new <Server>[this.localhost]);
        }


    }
}//package kabam.rotmg.servers.model

