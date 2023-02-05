// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid

package com.company.assembleegameclient.ui.panels.itemgrids{
    import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.EquipmentTile;
    import com.company.assembleegameclient.objects.GameObject;
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.util.EquipmentUtil;
    import com.company.util.ArrayIterator;
    import kabam.lib.util.VectorAS3Util;
    import com.company.util.IIterator;
    import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;

    public class EquippedGrid extends ItemGrid {

        private var tiles:Vector.<EquipmentTile>;
        private var _invTypes:Vector.<int>;

        public function EquippedGrid(_arg1:GameObject, _arg2:Vector.<int>, _arg3:Player, _arg4:int=0){
            super(_arg1, _arg3, _arg4);
            this._invTypes = _arg2;
            this.init();
        }

        private function init():void{
            var _local3:EquipmentTile;
            var _local1:int = EquipmentUtil.NUM_SLOTS;
            this.tiles = new Vector.<EquipmentTile>(_local1);
            var _local2:int;
            while (_local2 < _local1) {
                _local3 = new EquipmentTile(_local2, this, interactive);
                addToGrid(_local3, 1, _local2);
                _local3.setType(this._invTypes[_local2]);
                this.tiles[_local2] = _local3;
                _local2++;
            }
        }

        public function createInteractiveItemTileIterator():IIterator{
            return (new ArrayIterator(VectorAS3Util.toArray(this.tiles)));
        }

        override public function setItems(_arg1:Vector.<int>, _arg2:int=0):void{
            if (!_arg1){
                return;
            }
            var _local3:int = _arg1.length;
            var _local4:int;
            while (_local4 < this.tiles.length) {
                if ((_local4 + _arg2) < _local3){
                    this.tiles[_local4].setItem(_arg1[(_local4 + _arg2)]);
                }
                else {
                    this.tiles[_local4].setItem(-1);
                }
                this.tiles[_local4].updateDim(curPlayer);
                _local4++;
            }
        }

        public function toggleTierTags(_arg1:Boolean):void{
            var _local2:ItemTile;
            for each (_local2 in this.tiles) {
                _local2.toggleTierTag(_arg1);
            }
        }


    }
}//package com.company.assembleegameclient.ui.panels.itemgrids

