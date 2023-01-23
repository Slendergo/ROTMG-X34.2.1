﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.characters.model.LegacyCharacterModel

package kabam.rotmg.characters.model{
    import kabam.rotmg.core.model.PlayerModel;
    import com.company.assembleegameclient.appengine.SavedCharacter;

    public class LegacyCharacterModel implements CharacterModel {

        [Inject]
        public var wrapped:PlayerModel;
        private var selected:SavedCharacter;


        public function getCharacterCount():int{
            return (this.wrapped.getCharacterCount());
        }

        public function getCharacter(_arg1:int):SavedCharacter{
            return (this.wrapped.getCharById(_arg1));
        }

        public function deleteCharacter(_arg1:int):void{
            this.wrapped.deleteCharacter(_arg1);
            if (this.selected.charId() == _arg1){
                this.selected = null;
            };
        }

        public function select(_arg1:SavedCharacter):void{
            this.selected = _arg1;
        }

        public function getSelected():SavedCharacter{
            return (this.selected);
        }


    }
}//package kabam.rotmg.characters.model

