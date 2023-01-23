// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.characters.model.CharacterModel

package kabam.rotmg.characters.model{
    import com.company.assembleegameclient.appengine.SavedCharacter;

    public interface CharacterModel {

        function getCharacterCount():int;
        function getCharacter(_arg1:int):SavedCharacter;
        function deleteCharacter(_arg1:int):void;
        function select(_arg1:SavedCharacter):void;
        function getSelected():SavedCharacter;

    }
}//package kabam.rotmg.characters.model

