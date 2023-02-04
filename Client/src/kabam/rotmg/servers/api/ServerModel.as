// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.servers.api.ServerModel

package kabam.rotmg.servers.api{

    public interface ServerModel {

        function setServers(_arg1:Vector.<Server>):void;
        function getServer():Server;
        function isServerAvailable():Boolean;
        function getServers():Vector.<Server>;
        function setAvailableServers():void;
        function getAvailableServers():Vector.<Server>;

    }
}//package kabam.rotmg.servers.api

