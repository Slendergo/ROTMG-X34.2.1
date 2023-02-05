// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.supportCampaign.tab.donate.DonatePanelMediator

package io.decagames.rotmg.supportCampaign.tab.donate{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import io.decagames.rotmg.supportCampaign.signals.MaxRankReachedSignal;
    import io.decagames.rotmg.supportCampaign.signals.UpdateCampaignProgress;
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import flash.events.Event;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.supportCampaign.tab.donate.popup.DonateConfirmationPopup;

    public class DonatePanelMediator extends Mediator {

        [Inject]
        public var view:DonatePanel;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var model:SupporterCampaignModel;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        [Inject]
        public var maxRankReachedSignal:MaxRankReachedSignal;
        [Inject]
        public var updateCampaignProgress:UpdateCampaignProgress;
        private var infoToolTip:TextToolTip;
        private var hoverTooltipDelegate:HoverTooltipDelegate;


        override public function initialize():void{
            this.maxRankReachedSignal.add(this.onMaxRankReached);
            this.updateCampaignProgress.add(this.onCampaignUpdate);
            if (!this.model.isEnded){
                this.view.upArrow.clickSignal.add(this.upClickHandler);
                this.view.downArrow.clickSignal.add(this.downClickHandler);
                this.view.amountTextfield.addEventListener(Event.CHANGE, this.onAmountChange);
            }
            if (this.model.hasMaxRank()){
                this.setDonateButtonState(true);
                this.onMaxRankReached();
            }
            else {
                if (this.view.donateButton){
                    this.view.donateButton.clickSignal.add(this.donateClickHandler);
                }
            }
            if (this.model.donatePointsRatio == 0){
                this.infoToolTip = new TextToolTip(0x363636, 15585539, "Donation not possible", "You cannot spend Gold to progress in this Campaign", 220);
                this.hoverTooltipDelegate = new HoverTooltipDelegate();
                this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
                this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
                this.hoverTooltipDelegate.setDisplayObject(this.view);
                this.hoverTooltipDelegate.tooltip = this.infoToolTip;
            }
        }

        public function onCampaignUpdate():void{
            this.onAmountChange();
        }

        private function onMaxRankReached():void{
            this.setDonateButtonState(true);
            this.view.setCompleteText((this.model.campaignTitle + " Complete!"));
        }

        private function setDonateButtonState(_arg1:Boolean):void{
            if (this.view.donateButton){
                this.view.donateButton.disabled = _arg1;
            }
        }

        override public function destroy():void{
            if (!this.model.isEnded){
                this.view.upArrow.clickSignal.remove(this.upClickHandler);
                this.view.downArrow.clickSignal.remove(this.downClickHandler);
                this.view.donateButton.clickSignal.remove(this.donateClickHandler);
                this.view.amountTextfield.removeEventListener(Event.CHANGE, this.onAmountChange);
            }
            if (this.model.donatePointsRatio == 0){
                this.hoverTooltipDelegate = null;
                this.infoToolTip = null;
            }
            this.maxRankReachedSignal.remove(this.onMaxRankReached);
            this.updateCampaignProgress.remove(this.onCampaignUpdate);
        }

        private function onAmountChange(_arg1:Event=null):void{
            var _local2:int = ((this.model.ranks[(this.model.ranks.length - 1)] - this.model.points) / this.model.donatePointsRatio);
            if (int(this.view.amountTextfield.text) > _local2){
                this.view.amountTextfield.text = _local2.toString();
            }
            this.view.updateDonateAmount();
        }

        private function upClickHandler(_arg1:BaseButton):void{
            if ((this.model.ranks[(this.model.ranks.length - 1)] - this.model.points) > 0){
                this.view.addDonateAmount(this.getDonationPoints(SupporterCampaignModel.DEFAULT_DONATE_SPINNER_STEP));
            }
        }

        private function downClickHandler(_arg1:BaseButton):void{
            this.view.addDonateAmount(this.getDonationPoints(-(SupporterCampaignModel.DEFAULT_DONATE_SPINNER_STEP)));
        }

        private function donateClickHandler(_arg1:BaseButton):void{
            this.showPopupSignal.dispatch(new DonateConfirmationPopup(this.view.gold, (this.view.gold * this.model.donatePointsRatio)));
        }

        private function getDonationPoints(_arg1:int):int{
            var _local2:int;
            var _local3:int = int(this.view.amountTextfield.text);
            var _local4:int = ((this.model.ranks[(this.model.ranks.length - 1)] - this.model.points) / this.model.donatePointsRatio);
            if ((_local3 + _arg1) > _local4){
                _local2 = (_local4 - _local3);
                this.view.upArrow.disabled = true;
            }
            else {
                this.view.upArrow.disabled = false;
                _local2 = _arg1;
            }
            return (_local2);
        }


    }
}//package io.decagames.rotmg.supportCampaign.tab.donate

