// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.core.Account

package kabam.rotmg.account.core{
    public interface Account {

        function updateUser(_arg1:String, _arg2:String, _arg3:String):void;
        function getUserName():String;
        function getUserId():String;
        function getPassword():String;
        function getToken():String;
        function getSecret():String;
        function getCredentials():Object;
        function isRegistered():Boolean;
        function clear():void;
        function reportIntStat(_arg1:String, _arg2:int):void;
        function getRequestPrefix():String;
        function verify(_arg1:Boolean):void;
        function isVerified():Boolean;
        function getMoneyUserId():String;
        function getMoneyAccessToken():String;
        function get creationDate():Date;
        function set creationDate(_arg1:Date):void;

    }
}//package kabam.rotmg.account.core

