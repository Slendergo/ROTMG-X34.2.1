// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.steam.SteamApi

package kabam.rotmg.account.steam{
    import org.osflash.signals.Signal;
    import org.osflash.signals.OnceSignal;

    public interface SteamApi {

        function load(_arg1:String):void;
        function get loaded():Signal;
        function requestSessionTicket():void;
        function get sessionReceived():Signal;
        function getSessionAuthentication():Object;
        function getSteamId():String;
        function reportStatistic(_arg1:String, _arg2:int):void;
        function get paymentAuthorized():OnceSignal;
        function getPersonaName():String;
        function get isOverlayEnabled():Boolean;

    }
}//package kabam.rotmg.account.steam

