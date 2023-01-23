// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.utils.dictionary.DictionaryUtils

package io.decagames.rotmg.utils.dictionary{
    import flash.utils.Dictionary;

    public class DictionaryUtils {


        public static function countKeys(_arg1:Dictionary):int{
            var _local3:*;
            var _local2:int;
            for (_local3 in _arg1) {
                _local2++;
            };
            return (_local2);
        }


    }
}//package io.decagames.rotmg.utils.dictionary

