﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.game.view.components.BackpackTabContent

package kabam.rotmg.game.view.components{
    import flash.display.Sprite;
    import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
    import kabam.rotmg.ui.view.PotionInventoryView;
    import com.company.assembleegameclient.objects.Player;
    import kabam.rotmg.ui.model.TabStripModel;
    import kabam.rotmg.constants.GeneralConstants;

    public class BackpackTabContent extends Sprite {

        private var backpackContent:Sprite;
        private var _backpack:InventoryGrid;
        private var backpackPotionsInventory:PotionInventoryView;

        public function BackpackTabContent(_arg1:Player){
            this.backpackContent = new Sprite();
            this.backpackPotionsInventory = new PotionInventoryView();
            super();
            this.init(_arg1);
            this.addChildren();
            this.positionChildren();
        }

        private function init(_arg1:Player):void{
            name = TabStripModel.BACKPACK;
            this._backpack = new InventoryGrid(_arg1, _arg1, (GeneralConstants.NUM_EQUIPMENT_SLOTS + GeneralConstants.NUM_INVENTORY_SLOTS), true);
        }

        private function positionChildren():void{
            this.backpackContent.x = 7;
            this.backpackContent.y = 7;
            this.backpackPotionsInventory.y = (this._backpack.height + 4);
        }

        private function addChildren():void{
            this.backpackContent.addChild(this._backpack);
            this.backpackContent.addChild(this.backpackPotionsInventory);
            addChild(this.backpackContent);
        }

        public function get backpack():InventoryGrid{
            return (this._backpack);
        }


    }
}//package kabam.rotmg.game.view.components

