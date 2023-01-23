// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.windows.wardrobe.PetWardrobeWindow

package io.decagames.rotmg.pets.windows.wardrobe{
    import io.decagames.rotmg.ui.popups.UIPopup;
    import flash.display.Sprite;
    import io.decagames.rotmg.pets.components.petInfoSlot.PetInfoSlot;
    import io.decagames.rotmg.pets.components.selectedPetSkinInfo.SelectedPetSkinInfo;
    import io.decagames.rotmg.pets.components.petSkinsCollection.PetSkinsCollection;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;

    public class PetWardrobeWindow extends UIPopup {

        private var _closeButton:Sprite;
        private var _contentContainer:Sprite;
        private var currentPet:PetInfoSlot;
        private var selectedPet:SelectedPetSkinInfo;
        private var petCollection:PetSkinsCollection;

        public function PetWardrobeWindow(){
            super(600, 600);
            this._contentContainer = new Sprite();
            this._contentContainer.y = 120;
            this._contentContainer.x = 10;
            addChild(this._contentContainer);
        }

        public function renderCurrentPet():void{
            this.currentPet = new PetInfoSlot(195, true, true, true, true);
            this.currentPet.x = 20;
            this.currentPet.y = 130;
            addChild(this.currentPet);
            var _local1:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", 195);
            _local1.height = PetInfoSlot.INFO_HEIGHT;
            _local1.x = 20;
            _local1.y = 130;
            _local1.cacheAsBitmap = true;
            this.currentPet.cacheAsBitmap = true;
            addChild(_local1);
            this.currentPet.mask = _local1;
        }

        public function renderSelectedPet():void{
            this.selectedPet = new SelectedPetSkinInfo(195, true);
            this.selectedPet.x = 20;
            this.selectedPet.y = 348;
            addChild(this.selectedPet);
        }

        public function renderCollection(_arg1:int, _arg2:int):void{
            this.petCollection = new PetSkinsCollection(_arg1, _arg2);
            this.petCollection.x = 222;
            this.petCollection.y = 130;
            addChild(this.petCollection);
        }

        public function get closeButton():Sprite{
            return (this._closeButton);
        }

        public function get contentContainer():Sprite{
            return (this._contentContainer);
        }


    }
}//package io.decagames.rotmg.pets.windows.wardrobe

