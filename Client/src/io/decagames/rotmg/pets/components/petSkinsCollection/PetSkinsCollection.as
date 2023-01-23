// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.components.petSkinsCollection.PetSkinsCollection

package io.decagames.rotmg.pets.components.petSkinsCollection{
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.gird.UIGrid;
    import io.decagames.rotmg.ui.gird.UIGridElement;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import io.decagames.rotmg.utils.colors.Tint;
    import io.decagames.rotmg.ui.scroll.UIScrollbar;
    import io.decagames.rotmg.pets.data.vo.SkinVO;
    import io.decagames.rotmg.pets.components.petSkinSlot.PetSkinSlot;

    public class PetSkinsCollection extends Sprite {

        public static const COLLECTION_HEIGHT:int = 425;

        public static var COLLECTION_WIDTH:int = 360;

        private var collectionContainer:Sprite;
        private var contentInset:SliceScalingBitmap;
        private var contentTitle:SliceScalingBitmap;
        private var title:UILabel;
        private var contentGrid:UIGrid;
        private var contentElement:UIGridElement;
        private var petGrid:UIGrid;

        public function PetSkinsCollection(_arg1:int, _arg2:int){
            var _local3:SliceScalingBitmap;
            var _local4:UILabel;
            super();
            this.contentGrid = new UIGrid((COLLECTION_WIDTH - 40), 1, 15);
            this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", COLLECTION_WIDTH);
            addChild(this.contentInset);
            this.contentInset.height = COLLECTION_HEIGHT;
            this.contentInset.x = 0;
            this.contentInset.y = 0;
            this.contentTitle = TextureParser.instance.getSliceScalingBitmap("UI", "content_title_decoration", COLLECTION_WIDTH);
            addChild(this.contentTitle);
            this.contentTitle.x = 0;
            this.contentTitle.y = 0;
            this.title = new UILabel();
            this.title.text = "Collection";
            DefaultLabelFormat.petNameLabel(this.title, 0xFFFFFF);
            this.title.width = COLLECTION_WIDTH;
            this.title.wordWrap = true;
            this.title.y = 4;
            this.title.x = 0;
            addChild(this.title);
            _local3 = TextureParser.instance.getSliceScalingBitmap("UI", "content_divider_smalltitle_white", 94);
            Tint.add(_local3, 0x333333, 1);
            addChild(_local3);
            _local3.x = Math.round(((COLLECTION_WIDTH - _local3.width) / 2));
            _local3.y = 23;
            _local4 = new UILabel();
            DefaultLabelFormat.wardrobeCollectionLabel(_local4);
            _local4.text = ((_arg1 + "/") + _arg2);
            _local4.width = _local3.width;
            _local4.wordWrap = true;
            _local4.y = (_local3.y + 1);
            _local4.x = _local3.x;
            addChild(_local4);
            this.createScrollview();
        }

        private function createScrollview():void{
            var _local1:Sprite;
            var _local3:Sprite;
            _local1 = new Sprite();
            this.collectionContainer = new Sprite();
            this.collectionContainer.x = this.contentInset.x;
            this.collectionContainer.y = 2;
            this.collectionContainer.addChild(this.contentGrid);
            _local1.addChild(this.collectionContainer);
            var _local2:UIScrollbar = new UIScrollbar((COLLECTION_HEIGHT - 57));
            _local2.mouseRollSpeedFactor = 1;
            _local2.scrollObject = this;
            _local2.content = this.collectionContainer;
            _local1.addChild(_local2);
            _local2.x = ((this.contentInset.x + this.contentInset.width) - 25);
            _local2.y = 7;
            _local3 = new Sprite();
            _local3.graphics.beginFill(0);
            _local3.graphics.drawRect(0, 0, COLLECTION_WIDTH, 380);
            _local3.x = this.collectionContainer.x;
            _local3.y = this.collectionContainer.y;
            this.collectionContainer.mask = _local3;
            _local1.addChild(_local3);
            addChild(_local1);
            _local1.y = 42;
        }

        private function sortByName(_arg1:SkinVO, _arg2:SkinVO):int{
            if (_arg1.name > _arg2.name){
                return (1);
            };
            return (-1);
        }

        private function sortByRarity(_arg1:SkinVO, _arg2:SkinVO):int{
            if (_arg1.rarity.ordinal == _arg2.rarity.ordinal){
                return (this.sortByName(_arg1, _arg2));
            };
            if (_arg1.rarity.ordinal > _arg2.rarity.ordinal){
                return (1);
            };
            return (-1);
        }

        public function addPetSkins(_arg1:String, _arg2:Vector.<SkinVO>):void{
            var _local5:SkinVO;
            if (_arg2 == null){
                return;
            };
            var _local3:int;
            var _local4:int;
            this.petGrid = new UIGrid((COLLECTION_WIDTH - 40), 7, 5);
            _arg2 = _arg2.sort(this.sortByRarity);
            for each (_local5 in _arg2) {
                this.petGrid.addGridElement(new PetSkinSlot(_local5, true));
                _local3++;
                if (_local5.isOwned){
                    _local4++;
                };
            };
            this.petGrid.x = 10;
            this.petGrid.y = 25;
            var _local6:PetFamilyContainer = new PetFamilyContainer(_arg1, _local4, _local3);
            _local6.addChild(this.petGrid);
            this.contentGrid.addGridElement(_local6);
        }


    }
}//package io.decagames.rotmg.pets.components.petSkinsCollection

