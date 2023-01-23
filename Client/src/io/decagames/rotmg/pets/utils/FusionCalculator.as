// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.utils.FusionCalculator

package io.decagames.rotmg.pets.utils{
    import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
    import io.decagames.rotmg.pets.data.vo.PetVO;

    public class FusionCalculator {

        private static var ranges:Object = makeRanges();


        private static function makeRanges():Object{
            ranges = {};
            ranges[PetRarityEnum.COMMON.rarityKey] = 30;
            ranges[PetRarityEnum.UNCOMMON.rarityKey] = 20;
            ranges[PetRarityEnum.RARE.rarityKey] = 20;
            ranges[PetRarityEnum.LEGENDARY.rarityKey] = 20;
            return (ranges);
        }

        public static function getStrengthPercentage(_arg1:PetVO, _arg2:PetVO):Number{
            var _local3:Number = getRarityPointsPercentage(_arg1);
            var _local4:Number = getRarityPointsPercentage(_arg2);
            return (average(_local3, _local4));
        }

        private static function average(_arg1:Number, _arg2:Number):Number{
            return (((_arg1 + _arg2) / 2));
        }

        private static function getRarityPointsPercentage(_arg1:PetVO):Number{
            var _local2:int = ranges[_arg1.rarity.rarityKey];
            var _local3:int = (_arg1.maxAbilityPower - _local2);
            var _local4:int = (_arg1.abilityList[0].level - _local3);
            return ((_local4 / _local2));
        }


    }
}//package io.decagames.rotmg.pets.utils

