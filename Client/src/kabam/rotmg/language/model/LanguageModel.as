// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.language.model.LanguageModel

package kabam.rotmg.language.model{

    public interface LanguageModel {

        function getLanguage():String;
        function setLanguage(_arg1:String):void;
        function getLanguageFamily():String;
        function getLanguageNames():Vector.<String>;
        function getLanguageCodeForName(_arg1:String):String;
        function getNameForLanguageCode(_arg1:String):String;

    }
}//package kabam.rotmg.language.model

