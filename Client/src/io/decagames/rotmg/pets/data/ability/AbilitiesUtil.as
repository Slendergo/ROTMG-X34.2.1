// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.data.ability.AbilitiesUtil

package io.decagames.rotmg.pets.data.ability{
    import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
    import io.decagames.rotmg.pets.data.vo.AbilityVO;
    import io.decagames.rotmg.pets.data.vo.IPetVO;

    public class AbilitiesUtil {


        public static function isActiveAbility(_arg1:PetRarityEnum, _arg2:int):Boolean{
            if (_arg1.ordinal >= PetRarityEnum.LEGENDARY.ordinal){
                return true;
            };
            if (_arg1.ordinal >= PetRarityEnum.UNCOMMON.ordinal){
                return ((_arg2 <= 1));
            };
            return ((_arg2 == 0));
        }

        public static function abilityPowerToMinPoints(_arg1:int):int{
            return (Math.ceil(((AbilityConfig.ABILITY_LEVEL1_POINTS * (1 - Math.pow(AbilityConfig.ABILITY_GEOMETRIC_RATIO, (_arg1 - 1)))) / (1 - AbilityConfig.ABILITY_GEOMETRIC_RATIO))));
        }

        public static function abilityPointsToLevel(_arg1:int):int{
            var _local2:Number = (((_arg1 * (AbilityConfig.ABILITY_GEOMETRIC_RATIO - 1)) / AbilityConfig.ABILITY_LEVEL1_POINTS) + 1);
            return ((int((Math.log(_local2) / Math.log(AbilityConfig.ABILITY_GEOMETRIC_RATIO))) + 1));
        }

        public static function simulateAbilityUpgrade(_arg1:IPetVO, _arg2:int):Array{
            var _local5:AbilityVO;
            var _local6:int;
            var _local3:Array = [];
            var _local4:int;
            while (_local4 < 3) {
                _local5 = _arg1.abilityList[_local4].clone();
                if (((AbilitiesUtil.isActiveAbility(_arg1.rarity, _local4)) && ((_local5.level < _arg1.maxAbilityPower)))){
                    _local5.points = (_local5.points + (_arg2 * AbilityConfig.ABILITY_INDEX_TO_POINT_MODIFIER[_local4]));
                    _local6 = abilityPointsToLevel(_local5.points);
                    if (_local6 > _arg1.maxAbilityPower){
                        _local6 = _arg1.maxAbilityPower;
                        _local5.points = abilityPowerToMinPoints(_local6);
                    };
                    _local5.level = _local6;
                };
                _local3.push(_local5);
                _local4++;
            };
            return (_local3);
        }


    }
}//package io.decagames.rotmg.pets.data.ability

