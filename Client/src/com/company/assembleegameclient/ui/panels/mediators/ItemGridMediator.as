// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.panels.mediators.ItemGridMediator

package com.company.assembleegameclient.ui.panels.mediators{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
    import kabam.rotmg.core.model.MapModel;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.game.model.PotionInventoryModel;
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.ui.model.TabStripModel;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import io.decagames.rotmg.pets.data.PetsModel;
    import kabam.rotmg.game.signals.AddTextLineSignal;
    import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTileEvent;
    import com.company.assembleegameclient.ui.tooltip.ToolTip;
    import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;
    import kabam.rotmg.game.view.components.TabStripView;
    import com.company.assembleegameclient.util.DisplayHierarchy;
    import com.company.assembleegameclient.map.Map;
    import kabam.rotmg.chat.model.ChatMessage;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.messaging.impl.GameServerConnection;
    import kabam.rotmg.constants.ItemConstants;
    import com.company.assembleegameclient.objects.OneWayContainer;
    import com.company.assembleegameclient.objects.Container;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;
    import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
    import com.company.assembleegameclient.ui.panels.itemgrids.ContainerGrid;
    import com.company.assembleegameclient.objects.GameObject;
    import com.company.assembleegameclient.objects.Player;
    import flash.utils.getTimer;
    import com.company.assembleegameclient.sound.SoundEffectLibrary;

    public class ItemGridMediator extends Mediator {

        [Inject]
        public var view:ItemGrid;
        [Inject]
        public var mapModel:MapModel;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var potionInventoryModel:PotionInventoryModel;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var tabStripModel:TabStripModel;
        [Inject]
        public var showToolTip:ShowTooltipSignal;
        [Inject]
        public var petsModel:PetsModel;
        [Inject]
        public var addTextLine:AddTextLineSignal;


        override public function initialize():void{
            this.view.addEventListener(ItemTileEvent.ITEM_MOVE, this.onTileMove);
            this.view.addEventListener(ItemTileEvent.ITEM_SHIFT_CLICK, this.onShiftClick);
            this.view.addEventListener(ItemTileEvent.ITEM_DOUBLE_CLICK, this.onDoubleClick);
            this.view.addEventListener(ItemTileEvent.ITEM_CTRL_CLICK, this.onCtrlClick);
            this.view.addToolTip.add(this.onAddToolTip);
        }

        private function onAddToolTip(_arg1:ToolTip):void{
            this.showToolTip.dispatch(_arg1);
        }

        override public function destroy():void{
            super.destroy();
        }

        private function onTileMove(_arg1:ItemTileEvent):void{
            var _local4:InteractiveItemTile;
            var _local5:TabStripView;
            var _local6:int;
            var _local2:InteractiveItemTile = _arg1.tile;
            if (this.swapTooSoon()){
                _local2.resetItemPosition();
                return;
            };
            var _local3:* = DisplayHierarchy.getParentWithTypeArray(_local2.getDropTarget(), TabStripView, InteractiveItemTile, Map);
            if ((((_local2.getItemId() == PotionInventoryModel.HEALTH_POTION_ID)) || ((_local2.getItemId() == PotionInventoryModel.MAGIC_POTION_ID)))){
                this.onPotionMove(_arg1);
                return;
            };
            if ((_local3 is InteractiveItemTile)){
                _local4 = (_local3 as InteractiveItemTile);
                if (this.view.curPlayer.lockedSlot[_local4.tileId] == 0){
                    if (this.canSwapItems(_local2, _local4)){
                        this.swapItemTiles(_local2, _local4);
                    };
                }
                else {
                    this.addTextLine.dispatch(ChatMessage.make(Parameters.ERROR_CHAT_NAME, "You cannot put items into this slot right now."));
                };
            }
            else {
                if ((_local3 is TabStripView)){
                    _local5 = (_local3 as TabStripView);
                    _local6 = _local2.ownerGrid.curPlayer.nextAvailableInventorySlot();
                    if (_local6 != -1){
                        GameServerConnection.instance.invSwap(this.view.curPlayer, _local2.ownerGrid.owner, _local2.tileId, _local2.itemSprite.itemId, this.view.curPlayer, _local6, ItemConstants.NO_ITEM);
                        _local2.setItem(ItemConstants.NO_ITEM);
                        _local2.updateUseability(this.view.curPlayer);
                    };
                }
                else {
                    if ((((_local3 is Map)) || ((this.hudModel.gameSprite.map.mouseX < 300)))){
                        this.dropItem(_local2);
                    };
                };
            };
            _local2.resetItemPosition();
        }

        private function petFoodCancel(_arg1:InteractiveItemTile):Function{
            var itemSlot:InteractiveItemTile = _arg1;
            return (function ():void{
                itemSlot.blockingItemUpdates = false;
            });
        }

        private function onPotionMove(_arg1:ItemTileEvent):void{
            var _local2:InteractiveItemTile = _arg1.tile;
            var _local3:* = DisplayHierarchy.getParentWithTypeArray(_local2.getDropTarget(), TabStripView, Map);
            if ((_local3 is TabStripView)){
                this.addToPotionStack(_local2);
            }
            else {
                if ((((_local3 is Map)) || ((this.hudModel.gameSprite.map.mouseX < 300)))){
                    this.dropItem(_local2);
                };
            };
            _local2.resetItemPosition();
        }

        private function addToPotionStack(_arg1:InteractiveItemTile):void{
            if (((((((!(GameServerConnection.instance)) || (!(this.view.interactive)))) || (!(_arg1)))) || ((this.potionInventoryModel.getPotionModel(_arg1.getItemId()).maxPotionCount <= this.hudModel.gameSprite.map.player_.getPotionCount(_arg1.getItemId()))))){
                return;
            };
            GameServerConnection.instance.invSwapPotion(this.view.curPlayer, this.view.owner, _arg1.tileId, _arg1.itemSprite.itemId, this.view.curPlayer, PotionInventoryModel.getPotionSlot(_arg1.getItemId()), ItemConstants.NO_ITEM);
            _arg1.setItem(ItemConstants.NO_ITEM);
            _arg1.updateUseability(this.view.curPlayer);
        }

        private function canSwapItems(_arg1:InteractiveItemTile, _arg2:InteractiveItemTile):Boolean{
            if (!_arg1.canHoldItem(_arg2.getItemId())){
                return false;
            };
            if (!_arg2.canHoldItem(_arg1.getItemId())){
                return false;
            };
            if ((ItemGrid(_arg2.parent).owner is OneWayContainer)){
                return false;
            };
            if (((_arg1.blockingItemUpdates) || (_arg2.blockingItemUpdates))){
                return false;
            };
            return true;
        }

        private function dropItem(_arg1:InteractiveItemTile):void{
            var _local5:Container;
            var _local6:Vector.<int>;
            var _local7:int;
            var _local8:int;
            var _local2:Boolean = ObjectLibrary.isSoulbound(_arg1.itemSprite.itemId);
            var _local3:Boolean = ObjectLibrary.isDropTradable(_arg1.itemSprite.itemId);
            var _local4:Container = (this.view.owner as Container);
            if ((((this.view.owner == this.view.curPlayer)) || (((((_local4) && ((_local4.ownerId_ == this.view.curPlayer.accountId_)))) && (!(_local2)))))){
                _local5 = (this.mapModel.currentInteractiveTarget as Container);
                if (((_local5) && (!(((((!(_local5.canHaveSoulbound_)) && (!(_local3)))) || (((((_local5.canHaveSoulbound_) && (_local5.isLoot_))) && (_local3)))))))){
                    _local6 = _local5.equipment_;
                    _local7 = _local6.length;
                    _local8 = 0;
                    while (_local8 < _local7) {
                        if (_local6[_local8] < 0) break;
                        _local8++;
                    };
                    if (_local8 < _local7){
                        this.dropWithoutDestTile(_arg1, _local5, _local8);
                    }
                    else {
                        GameServerConnection.instance.invDrop(this.view.owner, _arg1.tileId, _arg1.getItemId());
                    };
                }
                else {
                    GameServerConnection.instance.invDrop(this.view.owner, _arg1.tileId, _arg1.getItemId());
                };
            }
            else {
                if (((((_local4.canHaveSoulbound_) && (_local4.isLoot_))) && (_local3))){
                    GameServerConnection.instance.invDrop(this.view.owner, _arg1.tileId, _arg1.getItemId());
                };
            };
            _arg1.setItem(-1);
        }

        private function swapItemTiles(_arg1:ItemTile, _arg2:ItemTile):Boolean{
            if (((((((!(GameServerConnection.instance)) || (!(this.view.interactive)))) || (!(_arg1)))) || (!(_arg2)))){
                return false;
            };
            GameServerConnection.instance.invSwap(this.view.curPlayer, this.view.owner, _arg1.tileId, _arg1.itemSprite.itemId, _arg2.ownerGrid.owner, _arg2.tileId, _arg2.itemSprite.itemId);
            var _local3:int = _arg1.getItemId();
            _arg1.setItem(_arg2.getItemId());
            _arg2.setItem(_local3);
            _arg1.updateUseability(this.view.curPlayer);
            _arg2.updateUseability(this.view.curPlayer);
            return true;
        }

        private function dropWithoutDestTile(_arg1:ItemTile, _arg2:Container, _arg3:int):void{
            if (((((((!(GameServerConnection.instance)) || (!(this.view.interactive)))) || (!(_arg1)))) || (!(_arg2)))){
                return;
            };
            GameServerConnection.instance.invSwap(this.view.curPlayer, this.view.owner, _arg1.tileId, _arg1.itemSprite.itemId, _arg2, _arg3, -1);
            _arg1.setItem(ItemConstants.NO_ITEM);
        }

        private function onShiftClick(_arg1:ItemTileEvent):void{
            var _local2:InteractiveItemTile = _arg1.tile;
            if ((((_local2.ownerGrid is InventoryGrid)) || ((_local2.ownerGrid is ContainerGrid)))){
                GameServerConnection.instance.useItem_new(_local2.ownerGrid.owner, _local2.tileId);
            };
        }

        private function onCtrlClick(_arg1:ItemTileEvent):void{
            var _local2:InteractiveItemTile;
            var _local3:int;
            if (this.swapTooSoon()){
                return;
            };
            if (Parameters.data_.inventorySwap){
                _local2 = _arg1.tile;
                if ((_local2.ownerGrid is InventoryGrid)){
                    _local3 = _local2.ownerGrid.curPlayer.swapInventoryIndex(this.tabStripModel.currentSelection);
                    if (_local3 != -1){
                        GameServerConnection.instance.invSwap(this.view.curPlayer, _local2.ownerGrid.owner, _local2.tileId, _local2.itemSprite.itemId, this.view.curPlayer, _local3, ItemConstants.NO_ITEM);
                        _local2.setItem(ItemConstants.NO_ITEM);
                        _local2.updateUseability(this.view.curPlayer);
                    };
                };
            };
        }

        private function onDoubleClick(_arg1:ItemTileEvent):void{
            if (this.swapTooSoon()){
                return;
            };
            var _local2:InteractiveItemTile = _arg1.tile;
            if (this.isStackablePotion(_local2)){
                this.addToPotionStack(_local2);
            }
            else {
                if ((_local2.ownerGrid is ContainerGrid)){
                    this.equipOrUseContainer(_local2);
                }
                else {
                    this.equipOrUseInventory(_local2);
                };
            };
            this.view.refreshTooltip();
        }

        private function isStackablePotion(_arg1:InteractiveItemTile):Boolean{
            return ((((_arg1.getItemId() == PotionInventoryModel.HEALTH_POTION_ID)) || ((_arg1.getItemId() == PotionInventoryModel.MAGIC_POTION_ID))));
        }

        private function pickUpItem(_arg1:InteractiveItemTile):void{
            var _local2:int = this.view.curPlayer.nextAvailableInventorySlot();
            if (_local2 != -1){
                GameServerConnection.instance.invSwap(this.view.curPlayer, this.view.owner, _arg1.tileId, _arg1.itemSprite.itemId, this.view.curPlayer, _local2, ItemConstants.NO_ITEM);
            };
        }

        private function equipOrUseContainer(_arg1:InteractiveItemTile):void{
            var _local2:GameObject = _arg1.ownerGrid.owner;
            var _local3:Player = this.view.curPlayer;
            var _local4:int = this.view.curPlayer.nextAvailableInventorySlot();
            if (_local4 != -1){
                GameServerConnection.instance.invSwap(_local3, this.view.owner, _arg1.tileId, _arg1.itemSprite.itemId, this.view.curPlayer, _local4, ItemConstants.NO_ITEM);
            }
            else {
                GameServerConnection.instance.useItem_new(_local2, _arg1.tileId);
            };
        }

        private function equipOrUseInventory(_arg1:InteractiveItemTile):void{
            var _local2:GameObject = _arg1.ownerGrid.owner;
            var _local3:Player = this.view.curPlayer;
            var _local4:int = ObjectLibrary.getMatchingSlotIndex(_arg1.getItemId(), _local3);
            if (_local4 != -1){
                GameServerConnection.instance.invSwap(_local3, _local2, _arg1.tileId, _arg1.getItemId(), _local3, _local4, _local3.equipment_[_local4]);
            }
            else {
                GameServerConnection.instance.useItem_new(_local2, _arg1.tileId);
            };
        }

        private function swapTooSoon():Boolean{
            var _local1:int = getTimer();
            if ((this.view.curPlayer.lastSwap_ + 600) > _local1){
                SoundEffectLibrary.play("error");
                return true;
            };
            this.view.curPlayer.lastSwap_ = _local1;
            return false;
        }


    }
}//package com.company.assembleegameclient.ui.panels.mediators

