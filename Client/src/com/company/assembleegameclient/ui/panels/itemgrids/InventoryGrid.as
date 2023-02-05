﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid

package com.company.assembleegameclient.ui.panels.itemgrids{
    import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InventoryTile;
    import com.company.assembleegameclient.objects.GameObject;
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;

    public class InventoryGrid extends ItemGrid {

        private const NUM_SLOTS:uint = 8;

        private var _tiles:Vector.<InventoryTile>;
        private var isBackpack:Boolean;

        public function InventoryGrid(_arg1:GameObject, _arg2:Player, _arg3:int=0, _arg4:Boolean=false){
            var _local6:InventoryTile;
            super(_arg1, _arg2, _arg3);
            this._tiles = new Vector.<InventoryTile>(this.NUM_SLOTS);
            this.isBackpack = _arg4;
            var _local5:int;
            while (_local5 < this.NUM_SLOTS) {
                _local6 = new InventoryTile((_local5 + indexOffset), this, interactive);
                _local6.addTileNumber((_local5 + 1));
                addToGrid(_local6, 2, _local5);
                this._tiles[_local5] = _local6;
                _local5++;
            }
        }

        public function getItemById(_arg1:int):InventoryTile{
            var _local2:InventoryTile;
            for each (_local2 in this._tiles) {
                if (_local2.getItemId() == _arg1){
                    return (_local2);
                }
            }
            return (null);
        }

        override public function setItems(_arg1:Vector.<int>, _arg2:int=0):void{
            var _local3:Boolean;
            var _local4:int;
            var _local5:int;
            if (_arg1){
                _local3 = false;
                _local4 = _arg1.length;
                _local5 = 0;
                while (_local5 < this.NUM_SLOTS) {
                    if ((_local5 + indexOffset) < _local4){
                        if (this._tiles[_local5].setItem(_arg1[(_local5 + indexOffset)])){
                            _local3 = true;
                        }
                    }
                    else {
                        if (this._tiles[_local5].setItem(-1)){
                            _local3 = true;
                        }
                    }
                    _local5++;
                }
                if (_local3){
                    refreshTooltip();
                }
            }
        }

        public function get tiles():Vector.<InventoryTile>{
            return (this._tiles.concat());
        }

        public function toggleTierTags(_arg1:Boolean):void{
            var _local2:ItemTile;
            for each (_local2 in this._tiles) {
                _local2.toggleTierTag(_arg1);
            }
        }


    }
}//package com.company.assembleegameclient.ui.panels.itemgrids

