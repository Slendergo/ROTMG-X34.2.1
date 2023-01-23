﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.game.view.components.InventoryTabContent

package kabam.rotmg.game.view.components{
    import flash.display.Sprite;
    import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
    import kabam.rotmg.ui.view.PotionInventoryView;
    import com.company.assembleegameclient.objects.Player;
    import kabam.rotmg.ui.model.TabStripModel;

    public class InventoryTabContent extends Sprite {

        private var storageContent:Sprite;
        private var _storage:InventoryGrid;
        private var potionsInventory:PotionInventoryView;

        public function InventoryTabContent(_arg1:Player){
            this.storageContent = new Sprite();
            this.potionsInventory = new PotionInventoryView();
            super();
            this.init(_arg1);
            this.addChildren();
            this.positionChildren();
        }

        private function init(_arg1:Player):void{
            this._storage = new InventoryGrid(_arg1, _arg1, 4);
            this.storageContent.name = TabStripModel.MAIN_INVENTORY;
        }

        private function addChildren():void{
            this.storageContent.addChild(this._storage);
            this.storageContent.addChild(this.potionsInventory);
            addChild(this.storageContent);
        }

        private function positionChildren():void{
            this.storageContent.x = 7;
            this.storageContent.y = 7;
            this.potionsInventory.y = (this._storage.height + 4);
        }

        public function get storage():InventoryGrid{
            return (this._storage);
        }


    }
}//package kabam.rotmg.game.view.components

