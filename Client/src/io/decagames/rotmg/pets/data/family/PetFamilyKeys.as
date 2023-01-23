// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.data.family.PetFamilyKeys

package io.decagames.rotmg.pets.data.family{
    public class PetFamilyKeys {

        public static const KEYS:Object = {
            Humanoid:"Pets.humanoid",
            Feline:"Pets.feline",
            Canine:"Pets.canine",
            Avian:"Pets.avian",
            Exotic:"Pets.exotic",
            Farm:"Pets.farm",
            Woodland:"Pets.woodland",
            Reptile:"Pets.reptile",
            Insect:"Pets.insect",
            Penguin:"Pets.penguin",
            Aquatic:"Pets.aquatic",
            Spooky:"Pets.spooky",
            Automaton:"Pets.automaton"
        };


        public static function getTranslationKey(_arg1:String):String{
            var _local2:String = KEYS[_arg1];
            _local2 = ((_local2) || ((((_arg1 == "? ? ? ?")) ? "Pets.miscellaneous" : "")));
            return (_local2);
        }


    }
}//package io.decagames.rotmg.pets.data.family

