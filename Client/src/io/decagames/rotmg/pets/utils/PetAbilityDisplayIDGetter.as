// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.utils.PetAbilityDisplayIDGetter

package io.decagames.rotmg.pets.utils{
    import com.company.assembleegameclient.objects.ObjectLibrary;

    public class PetAbilityDisplayIDGetter {


        public function getID(_arg1:int):String{
            return (String(ObjectLibrary.getPetDataXMLByType(_arg1).@id));
        }


    }
}//package io.decagames.rotmg.pets.utils

