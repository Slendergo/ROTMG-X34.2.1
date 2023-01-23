// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.application.api.ApplicationSetup

package kabam.rotmg.application.api{
    public interface ApplicationSetup extends DebugSetup {

        function getBuildLabel():String;
        function getAppEngineUrl(_arg1:Boolean=false):String;
        function getAnalyticsCode():String;
        function useLocalTextures():Boolean;
        function isToolingEnabled():Boolean;
        function areDeveloperHotkeysEnabled():Boolean;
        function isGameLoopMonitored():Boolean;
        function useProductionDialogs():Boolean;
        function areErrorsReported():Boolean;
        function isServerLocal():Boolean;
        function getServerDomain():String;

    }
}//package kabam.rotmg.application.api

