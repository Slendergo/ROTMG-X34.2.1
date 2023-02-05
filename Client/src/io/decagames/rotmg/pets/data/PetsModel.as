// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.data.PetsModel

package io.decagames.rotmg.pets.data{
    import io.decagames.rotmg.pets.signals.NotifyActivePetUpdated;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.pets.data.vo.PetVO;
    import flash.utils.Dictionary;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import io.decagames.rotmg.pets.data.yard.PetYardEnum;
    import com.company.assembleegameclient.map.AbstractMap;
    import io.decagames.rotmg.pets.data.vo.SkinVO;
    import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
    import com.company.assembleegameclient.appengine.SavedCharacter;

    public class PetsModel {

        private static var petsDataXML:Class = PetsModel_petsDataXML;

        private var petsData:XMLList;
        [Inject]
        public var notifyActivePetUpdated:NotifyActivePetUpdated;
        [Inject]
        public var playerModel:PlayerModel;
        private var hash:Object;
        private var pets:Vector.<PetVO>;
        private var skins:Dictionary;
        private var familySkins:Dictionary;
        private var yardXmlData:XML;
        private var type:int;
        private var activePet:PetVO;
        private var _wardrobePet:PetVO;
        private var _totalPetsSkins:int = 0;
        private var ownedSkinsIDs:Vector.<int>;
        private var _activeUIVO:PetVO;

        public function PetsModel():void{
            this.hash = {};
            this.pets = new Vector.<PetVO>();
            this.skins = new Dictionary();
            this.familySkins = new Dictionary();
            this.ownedSkinsIDs = new Vector.<int>();
            super();
        }

        public function destroy():void{
        }

        public function setPetYardType(_arg1:int):void{
            this.type = _arg1;
            this.yardXmlData = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(_arg1));
        }

        public function getPetYardRarity():uint{
            return (PetYardEnum.selectByValue(this.yardXmlData.@id).rarity.ordinal);
        }

        public function getPetYardType():int{
            return (((this.yardXmlData) ? PetYardEnum.selectByValue(this.yardXmlData.@id).ordinal : 1));
        }

        public function isMapNameYardName(_arg1:AbstractMap):Boolean{
            return (((_arg1.name_) && ((_arg1.name_.substr(0, 8) == "Pet Yard"))));
        }

        public function getPetYardUpgradeFamePrice():int{
            return int(this.yardXmlData.Fame);
        }

        public function getPetYardUpgradeGoldPrice():int{
            return int(this.yardXmlData.Price);
        }

        public function getPetYardObjectID():int{
            return (this.type);
        }

        public function deletePet(_arg1:int):void{
            var _local2:int = this.getPetIndex(_arg1);
            if (_local2 >= 0){
                this.pets.splice(this.getPetIndex(_arg1), 1);
                if (((this._activeUIVO) && ((this._activeUIVO.getID() == _arg1)))){
                    this._activeUIVO = null;
                }
                if (((this.activePet) && ((this.activePet.getID() == _arg1)))){
                    this.removeActivePet();
                }
            }
        }

        public function clearPets():void{
            this.hash = {};
            this.pets = new Vector.<PetVO>();
            this.petsData = null;
            this.skins = new Dictionary();
            this.familySkins = new Dictionary();
            this._totalPetsSkins = 0;
            this.ownedSkinsIDs = new Vector.<int>();
            this.removeActivePet();
        }

        public function parsePetsData():void{
            var _local1:uint;
            var _local2:int;
            var _local3:XML;
            var _local4:SkinVO;
            if (this.petsData == null){
                this.petsData = XML(new petsDataXML()).Object;
                _local1 = this.petsData.length();
                _local2 = 0;
                while (_local2 < _local1) {
                    _local3 = this.petsData[_local2];
                    if (_local3.hasOwnProperty("PetSkin")){
                        if (_local3.@type != "0x8090"){
                            _local4 = SkinVO.parseFromXML(_local3);
                            _local4.isOwned = (this.ownedSkinsIDs.indexOf(_local4.skinType) >= 0);
                            this.skins[_local4.skinType] = _local4;
                            this._totalPetsSkins++;
                            if (!this.familySkins[_local4.family]){
                                this.familySkins[_local4.family] = new Vector.<SkinVO>();
                            }
                            this.familySkins[_local4.family].push(_local4);
                        }
                    }
                    _local2++;
                }
            }
        }

        public function unlockSkin(_arg1:int):void{
            this.skins[_arg1].isNew = true;
            this.skins[_arg1].isOwned = true;
            if (this.ownedSkinsIDs.indexOf(_arg1) == -1){
                this.ownedSkinsIDs.push(_arg1);
            }
        }

        public function getSkinVOById(_arg1:int):SkinVO{
            return (this.skins[_arg1]);
        }

        public function hasSkin(_arg1:int):Boolean{
            return (!((this.ownedSkinsIDs.indexOf(_arg1) == -1)));
        }

        public function parseOwnedSkins(_arg1:XML):void{
            if (_arg1.toString() != ""){
                this.ownedSkinsIDs = Vector.<int>(_arg1.toString().split(","));
            }
        }

        public function getPetVO(_arg1:int):PetVO{
            var _local2:PetVO;
            if (this.hash[_arg1] != null){
                return (this.hash[_arg1]);
            }
            _local2 = new PetVO(_arg1);
            this.pets.push(_local2);
            this.hash[_arg1] = _local2;
            return (_local2);
        }

        public function get totalPetsSkins():int{
            return (this._totalPetsSkins);
        }

        public function get totalOwnedPetsSkins():int{
            return (this.ownedSkinsIDs.length);
        }

        public function getPetsSkinsFromFamily(_arg1:String):Vector.<SkinVO>{
            return (this.familySkins[_arg1]);
        }

        private function petNodeIsSkin(_arg1:XML):Boolean{
            return (_arg1.hasOwnProperty("PetSkin"));
        }

        public function getCachedVOOnly(_arg1:int):PetVO{
            return (this.hash[_arg1]);
        }

        public function getAllPets(_arg1:String="", _arg2:PetRarityEnum=null):Vector.<PetVO>{
            var family:String = _arg1;
            var rarity = _arg2;
            var petsList:Vector.<PetVO> = this.pets;
            if (family != ""){
                petsList = petsList.filter(function (_arg1:PetVO, _arg2:int, _arg3:Vector.<PetVO>):Boolean{
                    return ((_arg1.family == family));
                });
            }
            if (rarity != null){
                petsList = petsList.filter(function (_arg1:PetVO, _arg2:int, _arg3:Vector.<PetVO>):Boolean{
                    return ((_arg1.rarity == rarity));
                });
            }
            return (petsList);
        }

        public function addPet(_arg1:PetVO):void{
            this.pets.push(_arg1);
        }

        public function setActivePet(_arg1:PetVO):void{
            this.activePet = _arg1;
            var _local2:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
            if (_local2){
                _local2.setPetVO(this.activePet);
            }
            this.notifyActivePetUpdated.dispatch();
        }

        public function getActivePet():PetVO{
            return (this.activePet);
        }

        public function removeActivePet():void{
            if (this.activePet == null){
                return;
            }
            var _local1:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
            if (_local1){
                _local1.setPetVO(null);
            }
            this.activePet = null;
            this.notifyActivePetUpdated.dispatch();
        }

        public function getPet(_arg1:int):PetVO{
            var _local2:int = this.getPetIndex(_arg1);
            if (_local2 == -1){
                return (null);
            }
            return (this.pets[_local2]);
        }

        private function getPetIndex(_arg1:int):int{
            var _local2:PetVO;
            var _local3:uint;
            while (_local3 < this.pets.length) {
                _local2 = this.pets[_local3];
                if (_local2.getID() == _arg1){
                    return (_local3);
                }
                _local3++;
            }
            return (-1);
        }

        private function selectPetInWardrobe(_arg1:PetVO):void{
            this._wardrobePet = _arg1;
        }

        public function get activeUIVO():PetVO{
            return (this._activeUIVO);
        }

        public function set activeUIVO(_arg1:PetVO):void{
            this._activeUIVO = _arg1;
        }


    }
}//package io.decagames.rotmg.pets.data

