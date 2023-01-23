// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.components.guiTab.PetsTabContentView

package io.decagames.rotmg.pets.components.guiTab{
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import io.decagames.rotmg.pets.data.vo.PetVO;
    import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
    import kabam.rotmg.ui.model.TabStripModel;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import io.decagames.rotmg.pets.components.petStatsGrid.PetStatsGrid;
    import io.decagames.rotmg.ui.gird.UIGrid;
    import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
    import io.decagames.rotmg.pets.data.family.PetFamilyKeys;
    import io.decagames.rotmg.pets.data.family.PetFamilyColors;

    public class PetsTabContentView extends Sprite {

        public var petBitmap:Bitmap;
        private var petsContent:Sprite;
        public var petRarityTextField:TextFieldDisplayConcrete;
        private var tabTitleTextField:TextFieldDisplayConcrete;
        private var petFamilyTextField:TextFieldDisplayConcrete;
        private var petVO:PetVO;

        public function PetsTabContentView(){
            this.petsContent = new Sprite();
            this.petRarityTextField = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 13, false);
            this.tabTitleTextField = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 15, true);
            this.petFamilyTextField = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 13, false);
            super();
        }

        public function init(_arg1:PetVO):void{
            this.petVO = _arg1;
            this.petBitmap = _arg1.getSkinBitmap();
            this.addChildren();
            this.addAbilities();
            this.positionChildren();
            this.updateTextFields();
            this.petsContent.name = TabStripModel.PETS;
            _arg1.updated.add(this.onUpdate);
        }

        private function onUpdate():void{
            this.updatePetBitmap();
            this.petRarityTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.rarity.rarityKey));
        }

        private function updatePetBitmap():void{
            this.petsContent.removeChild(this.petBitmap);
            this.petBitmap = this.petVO.getSkinBitmap();
            this.petsContent.addChild(this.petBitmap);
        }

        private function addAbilities():void{
            var _local1:UIGrid = new PetStatsGrid(171, this.petVO);
            this.petsContent.addChild(_local1);
            _local1.y = 50;
        }

        private function getNumAbilities():uint{
            var _local1:Boolean = (((this.petVO.rarity.rarityKey == PetRarityEnum.DIVINE.rarityKey)) || ((this.petVO.rarity.rarityKey == PetRarityEnum.LEGENDARY.rarityKey)));
            if (_local1){
                return (2);
            };
            return (3);
        }

        private function updateTextFields():void{
            this.tabTitleTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.name)).setColor(this.petVO.rarity.color).setSize((((this.petVO.name.length > 17)) ? 11 : 15));
            this.petRarityTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.rarity.rarityKey));
            this.petFamilyTextField.setStringBuilder(new LineBuilder().setParams(PetFamilyKeys.getTranslationKey(this.petVO.family))).setColor(PetFamilyColors.getColorByFamilyKey(this.petVO.family));
        }

        private function addChildren():void{
            this.petsContent.addChild(this.petBitmap);
            this.petsContent.addChild(this.tabTitleTextField);
            this.petsContent.addChild(this.petRarityTextField);
            this.petsContent.addChild(this.petFamilyTextField);
            addChild(this.petsContent);
        }

        private function positionChildren():void{
            this.petBitmap.x = (this.petBitmap.x - 10);
            this.petBitmap.y = (this.petBitmap.y - 1);
            this.petsContent.x = 7;
            this.petsContent.y = 6;
            this.tabTitleTextField.x = (this.petFamilyTextField.x = (this.petRarityTextField.x = 46));
            this.tabTitleTextField.y = 20;
            this.petRarityTextField.y = 33;
            this.petFamilyTextField.y = 47;
        }


    }
}//package io.decagames.rotmg.pets.components.guiTab

