// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.panels.mediators.InventoryGridMediator

package com.company.assembleegameclient.ui.panels.mediators{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
    import kabam.rotmg.ui.signals.UpdateHUDSignal;
    import kabam.rotmg.ui.signals.ToggleShowTierTagSignal;
    import com.company.assembleegameclient.objects.Player;

    public class InventoryGridMediator extends Mediator {

        [Inject]
        public var view:InventoryGrid;
        [Inject]
        public var updateHUD:UpdateHUDSignal;
        [Inject]
        public var toggleShowTierTag:ToggleShowTierTagSignal;


        override public function initialize():void{
            this.updateHUD.add(this.onUpdateHUD);
            this.toggleShowTierTag.add(this.onToggleShowTierTag);
        }

        private function onToggleShowTierTag(_arg1:Boolean):void{
            this.view.toggleTierTags(_arg1);
        }

        override public function destroy():void{
            this.updateHUD.remove(this.onUpdateHUD);
        }

        private function onUpdateHUD(_arg1:Player):void{
            this.view.draw();
        }


    }
}//package com.company.assembleegameclient.ui.panels.mediators

