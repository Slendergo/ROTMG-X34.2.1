// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.popup.info.PetInfoItemMediator

package io.decagames.rotmg.pets.popup.info{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import com.company.assembleegameclient.ui.tooltip.ToolTip;

    public class PetInfoItemMediator extends Mediator {

        [Inject]
        public var view:PetInfoItem;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        private var hoverTooltipDelegate:HoverTooltipDelegate;


        override public function initialize():void{
            var _local1:ToolTip;
            if (this.view.titel == "Pets"){
                _local1 = new PetsTooltip();
            }
            else {
                if (this.view.titel == "Feeding"){
                    _local1 = new FeedTooltip();
                }
                else {
                    if (this.view.titel == "Fusing"){
                        _local1 = new FuseTooltip();
                    }
                    else {
                        if (this.view.titel == "Upgrade"){
                            _local1 = new UpgradeTooltip();
                        }
                        else {
                            if (this.view.titel == "Wardrobe"){
                                _local1 = new WardrobeTooltip();
                            };
                        };
                    };
                };
            };
            this.hoverTooltipDelegate = new HoverTooltipDelegate();
            this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
            this.hoverTooltipDelegate.setDisplayObject(this.view.background);
            this.hoverTooltipDelegate.tooltip = _local1;
        }


    }
}//package io.decagames.rotmg.pets.popup.info

