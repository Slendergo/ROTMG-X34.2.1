// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.data.vo.PetVO

package io.decagames.rotmg.pets.data.vo{
    import io.decagames.rotmg.pets.data.skin.PetSkinRenderer;
    import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
    import org.osflash.signals.Signal;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import kabam.rotmg.core.StaticInjectorContext;
    import io.decagames.rotmg.pets.data.PetsModel;

    public class PetVO extends PetSkinRenderer implements IPetVO {

        private var staticData:XML;
        private var id:int;
        private var type:int;
        private var _rarity:PetRarityEnum;
        private var _name:String;
        private var _maxAbilityPower:int;
        private var _abilityList:Array;
        private var _updated:Signal;
        private var _abilityUpdated:Signal;
        private var _ownedSkin:Boolean;
        private var _family:String = "";

        public function PetVO(_arg1:int=undefined){
            this._abilityList = [new AbilityVO(), new AbilityVO(), new AbilityVO()];
            this._updated = new Signal();
            this._abilityUpdated = new Signal();
            super();
            this.id = _arg1;
            this.staticData = <data/>
            ;
            this.listenToAbilities();
        }

        private static function getPetDataDescription(_arg1:int):String{
            return (ObjectLibrary.getPetDataXMLByType(_arg1).Description);
        }

        private static function getPetDataDisplayId(_arg1:int):String{
            return (ObjectLibrary.getPetDataXMLByType(_arg1).@id);
        }

        public static function clone(_arg1:PetVO):PetVO{
            var _local2:PetVO = new PetVO(_arg1.id);
            return (_local2);
        }


        public function get updated():Signal{
            return (this._updated);
        }

        private function listenToAbilities():void{
            var _local1:AbilityVO;
            for each (_local1 in this._abilityList) {
                _local1.updated.add(this.onAbilityUpdate);
            };
        }

        public function maxedAvailableAbilities():Boolean{
            var _local1:AbilityVO;
            for each (_local1 in this._abilityList) {
                if (((_local1.getUnlocked()) && ((_local1.level < this.maxAbilityPower)))){
                    return (false);
                };
            };
            return (true);
        }

        public function totalAbilitiesLevel():int{
            var _local2:AbilityVO;
            var _local1:int;
            for each (_local2 in this._abilityList) {
                if (((_local2.getUnlocked()) && (_local2.level))){
                    _local1 = (_local1 + _local2.level);
                };
            };
            return (_local1);
        }

        public function get totalMaxAbilitiesLevel():int{
            var _local2:AbilityVO;
            var _local1:int;
            for each (_local2 in this._abilityList) {
                if (_local2.getUnlocked()){
                    _local1 = (_local1 + this._maxAbilityPower);
                };
            };
            return (_local1);
        }

        public function maxedAllAbilities():Boolean{
            var _local2:AbilityVO;
            var _local1:int;
            for each (_local2 in this._abilityList) {
                if (((_local2.getUnlocked()) && ((_local2.level == this.maxAbilityPower)))){
                    _local1++;
                };
            };
            return ((_local1 == this._abilityList.length));
        }

        private function onAbilityUpdate(_arg1:AbilityVO):void{
            this._updated.dispatch();
            this._abilityUpdated.dispatch();
        }

        public function apply(_arg1:XML):void{
            this.extractBasicData(_arg1);
            this.extractAbilityData(_arg1);
        }

        private function extractBasicData(_arg1:XML):void{
            ((_arg1.@instanceId) && (this.setID(_arg1.@instanceId)));
            ((_arg1.@type) && (this.setType(_arg1.@type)));
            ((_arg1.@skin) && (this.setSkin(_arg1.@skin)));
            ((_arg1.@name) && (this.setName(_arg1.@name)));
            ((_arg1.@rarity) && (this.setRarity(_arg1.@rarity)));
            ((_arg1.@maxAbilityPower) && (this.setMaxAbilityPower(_arg1.@maxAbilityPower)));
        }

        public function extractAbilityData(_arg1:XML):void{
            var _local2:uint;
            var _local4:AbilityVO;
            var _local5:int;
            var _local3:uint = this._abilityList.length;
            _local2 = 0;
            while (_local2 < _local3) {
                _local4 = this._abilityList[_local2];
                _local5 = _arg1.Abilities.Ability[_local2].@type;
                _local4.name = getPetDataDisplayId(_local5);
                _local4.description = getPetDataDescription(_local5);
                _local4.level = _arg1.Abilities.Ability[_local2].@power;
                _local4.points = _arg1.Abilities.Ability[_local2].@points;
                _local2++;
            };
        }

        public function get family():String{
            var _local1:SkinVO = this.skinVO;
            if (_local1){
                return (_local1.family);
            };
            return (this.staticData.Family);
        }

        public function setID(_arg1:int):void{
            this.id = _arg1;
        }

        public function getID():int{
            return (this.id);
        }

        public function setType(_arg1:int):void{
            this.type = _arg1;
            this.staticData = ObjectLibrary.xmlLibrary_[this.type];
        }

        public function getType():int{
            return (this.type);
        }

        public function setRarity(_arg1:uint):void{
            this._rarity = PetRarityEnum.selectByOrdinal(_arg1);
            this.unlockAbilitiesBasedOnPetRarity(_arg1);
            this._updated.dispatch();
        }

        private function unlockAbilitiesBasedOnPetRarity(_arg1:uint):void{
            this._abilityList[0].setUnlocked(true);
            this._abilityList[1].setUnlocked((_arg1 >= PetRarityEnum.UNCOMMON.ordinal));
            this._abilityList[2].setUnlocked((_arg1 >= PetRarityEnum.LEGENDARY.ordinal));
        }

        public function get rarity():PetRarityEnum{
            return (this._rarity);
        }

        public function get skinVO():SkinVO{
            return (StaticInjectorContext.getInjector().getInstance(PetsModel).getSkinVOById(_skinType));
        }

        public function setName(_arg1:String):void{
            this._name = ObjectLibrary.typeToDisplayId_[_skinType];
            if ((((this._name == null)) || ((this._name == "")))){
                this._name = ObjectLibrary.typeToDisplayId_[this.getType()];
            };
            this._updated.dispatch();
        }

        public function get name():String{
            return (this._name);
        }

        public function setMaxAbilityPower(_arg1:int):void{
            this._maxAbilityPower = _arg1;
            this._updated.dispatch();
        }

        public function get maxAbilityPower():int{
            return (this._maxAbilityPower);
        }

        public function setSkin(_arg1:int):void{
            _skinType = _arg1;
            this._updated.dispatch();
        }

        public function get skinType():int{
            return (_skinType);
        }

        public function get ownedSkin():Boolean{
            return (this._ownedSkin);
        }

        public function set ownedSkin(_arg1:Boolean):void{
            this._ownedSkin = _arg1;
        }

        public function setFamily(_arg1:String):void{
            this._family = _arg1;
        }

        public function get abilityList():Array{
            return (this._abilityList);
        }

        public function set abilityList(_arg1:Array):void{
            this._abilityList = _arg1;
        }

        public function get isOwned():Boolean{
            return (false);
        }

        public function get abilityUpdated():Signal{
            return (this._abilityUpdated);
        }

        public function get isNew():Boolean{
            return (false);
        }

        public function set isNew(_arg1:Boolean):void{
        }


    }
}//package io.decagames.rotmg.pets.data.vo

