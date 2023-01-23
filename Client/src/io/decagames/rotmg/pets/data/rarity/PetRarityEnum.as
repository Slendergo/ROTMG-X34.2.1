// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.data.rarity.PetRarityEnum

package io.decagames.rotmg.pets.data.rarity{
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;

    public class PetRarityEnum {

        public static const COMMON:PetRarityEnum = new PetRarityEnum("Pets.common", 0, 12960964, 0x454545);
        public static const UNCOMMON:PetRarityEnum = new PetRarityEnum("Pets.uncommon", 1, 12960964, 0x454545);
        public static const RARE:PetRarityEnum = new PetRarityEnum("Pets.rare", 2, 222407, 672896);
        public static const LEGENDARY:PetRarityEnum = new PetRarityEnum("Pets.legendary", 3, 222407, 672896);
        public static const DIVINE:PetRarityEnum = new PetRarityEnum("Pets.divine", 4, 0xC5A100, 8349960);

        public var rarityKey:String;
        public var ordinal:int;
        public var rarityName:String;
        public var color:uint;
        public var backgroundColor:uint;

        public function PetRarityEnum(_arg1:String, _arg2:int, _arg3:uint, _arg4:uint){
            this.rarityKey = _arg1;
            this.ordinal = _arg2;
            this.color = _arg3;
            this.backgroundColor = _arg4;
        }

        public static function parseNames():void{
            var _local1:PetRarityEnum;
            for each (_local1 in PetRarityEnum.list) {
                _local1.rarityName = LineBuilder.getLocalizedStringFromKey(_local1.rarityKey);
            };
        }

        public static function get list():Array{
            return ([COMMON, UNCOMMON, RARE, LEGENDARY, DIVINE]);
        }

        public static function selectByRarityKey(_arg1:String):PetRarityEnum{
            var _local2:PetRarityEnum;
            var _local3:PetRarityEnum;
            for each (_local3 in PetRarityEnum.list) {
                if (_arg1 == _local3.rarityKey){
                    _local2 = _local3;
                };
            };
            return (_local2);
        }

        public static function selectByRarityName(_arg1:String):PetRarityEnum{
            var _local2:PetRarityEnum;
            var _local3:PetRarityEnum;
            for each (_local3 in PetRarityEnum.list) {
                if (_arg1 == _local3.rarityName){
                    _local2 = _local3;
                };
            };
            return (_local2);
        }

        public static function selectByOrdinal(_arg1:int):PetRarityEnum{
            var _local2:PetRarityEnum;
            var _local3:PetRarityEnum;
            for each (_local3 in PetRarityEnum.list) {
                if (_arg1 == _local3.ordinal){
                    _local2 = _local3;
                };
            };
            return (_local2);
        }


    }
}//package io.decagames.rotmg.pets.data.rarity

