// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.EquipmentTile

package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles{
    import flash.display.Bitmap;
    import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import com.company.assembleegameclient.util.EquipmentUtil;
    import com.company.assembleegameclient.util.FilterUtil;
    import com.company.assembleegameclient.objects.Player;

    public class EquipmentTile extends InteractiveItemTile {

        public var backgroundDetail:Bitmap;
        public var itemType:int;
        private var minManaUsage:int;

        public function EquipmentTile(_arg1:int, _arg2:ItemGrid, _arg3:Boolean){
            super(_arg1, _arg2, _arg3);
        }

        override public function canHoldItem(_arg1:int):Boolean{
            return ((((_arg1 <= 0)) || ((this.itemType == ObjectLibrary.getSlotTypeFromType(_arg1)))));
        }

        public function setType(_arg1:int):void{
            this.backgroundDetail = EquipmentUtil.getEquipmentBackground(_arg1, 4);
            if (this.backgroundDetail){
                this.backgroundDetail.x = BORDER;
                this.backgroundDetail.y = BORDER;
                this.backgroundDetail.filters = FilterUtil.getGreyColorFilter();
                addChildAt(this.backgroundDetail, 0);
            }
            this.itemType = _arg1;
        }

        override public function setItem(_arg1:int):Boolean{
            var _local2:Boolean = super.setItem(_arg1);
            if (_local2){
                this.backgroundDetail.visible = (itemSprite.itemId <= 0);
                this.updateMinMana();
            }
            return (_local2);
        }

        private function updateMinMana():void{
            var _local1:XML;
            this.minManaUsage = 0;
            if (itemSprite.itemId > 0){
                _local1 = ObjectLibrary.xmlLibrary_[itemSprite.itemId];
                if (((_local1) && (_local1.hasOwnProperty("Usable")))){
                    if (_local1.hasOwnProperty("MultiPhase")){
                        this.minManaUsage = _local1.MpEndCost;
                    }
                    else {
                        this.minManaUsage = _local1.MpCost;
                    }
                }
            }
        }

        public function updateDim(_arg1:Player):void{
            itemSprite.setDim(((_arg1) && ((((_arg1.mp_ < this.minManaUsage)) || (((this.minManaUsage) && (_arg1.isSilenced())))))));
        }

        override protected function beginDragCallback():void{
            this.backgroundDetail.visible = true;
        }

        override protected function endDragCallback():void{
            this.backgroundDetail.visible = (itemSprite.itemId <= 0);
        }

        override protected function getBackgroundColor():int{
            return (0x454545);
        }


    }
}//package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles

