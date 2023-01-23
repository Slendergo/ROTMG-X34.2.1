// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.windows.yard.feed.FeedTabMediator

package io.decagames.rotmg.pets.windows.yard.feed{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.ui.model.HUDModel;
    import io.decagames.rotmg.pets.data.PetsModel;
    import io.decagames.rotmg.pets.signals.SelectFeedItemSignal;
    import io.decagames.rotmg.pets.signals.SelectPetSignal;
    import kabam.rotmg.game.model.GameModel;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.pets.signals.UpgradePetSignal;
    import io.decagames.rotmg.ui.popups.signals.ShowLockFade;
    import io.decagames.rotmg.ui.popups.signals.RemoveLockFade;
    import io.decagames.rotmg.pets.signals.SimulateFeedSignal;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import io.decagames.rotmg.pets.data.vo.PetVO;
    import io.decagames.rotmg.pets.windows.yard.feed.items.FeedItem;
    import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InventoryTile;
    import kabam.rotmg.game.view.components.InventoryTabContent;
    import io.decagames.rotmg.pets.utils.FeedFuseCostModel;
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import kabam.rotmg.messaging.impl.PetUpgradeRequest;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.pets.data.vo.requests.FeedPetRequestVO;
    import kabam.rotmg.messaging.impl.data.SlotObjectData;
    import io.decagames.rotmg.shop.NotEnoughResources;
    import com.company.assembleegameclient.util.Currency;
    import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;

    public class FeedTabMediator extends Mediator {

        [Inject]
        public var view:FeedTab;
        [Inject]
        public var hud:HUDModel;
        [Inject]
        public var model:PetsModel;
        [Inject]
        public var selectFeedItemSignal:SelectFeedItemSignal;
        [Inject]
        public var selectPetSignal:SelectPetSignal;
        [Inject]
        public var gameModel:GameModel;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var showPopup:ShowPopupSignal;
        [Inject]
        public var upgradePet:UpgradePetSignal;
        [Inject]
        public var showFade:ShowLockFade;
        [Inject]
        public var removeFade:RemoveLockFade;
        [Inject]
        public var simulateFeed:SimulateFeedSignal;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        private var currentPet:PetVO;
        private var items:Vector.<FeedItem>;


        override public function initialize():void{
            this.currentPet = ((this.model.activeUIVO) ? this.model.activeUIVO : this.model.getActivePet());
            this.selectPetSignal.add(this.onPetSelected);
            this.items = new Vector.<FeedItem>();
            this.selectFeedItemSignal.add(this.refreshFeedPower);
            this.view.feedGoldButton.clickSignal.add(this.purchaseGold);
            this.view.feedFameButton.clickSignal.add(this.purchaseFame);
            this.view.displaySignal.add(this.showHideSignal);
            this.renderItems();
            this.refreshFeedPower();
        }

        override public function destroy():void{
            this.items = new Vector.<FeedItem>();
            this.selectFeedItemSignal.remove(this.refreshFeedPower);
            this.selectPetSignal.remove(this.onPetSelected);
            this.view.feedGoldButton.clickSignal.remove(this.purchaseGold);
            this.view.feedFameButton.clickSignal.remove(this.purchaseFame);
            this.view.displaySignal.remove(this.showHideSignal);
        }

        private function showHideSignal(_arg1:Boolean):void{
            var _local2:FeedItem;
            if (!_arg1){
                for each (_local2 in this.items) {
                    _local2.selected = false;
                };
                this.refreshFeedPower();
            };
        }

        private function renderItems():void{
            var _local3:InventoryTile;
            var _local4:int;
            var _local5:FeedItem;
            this.view.clearGrid();
            this.items = new Vector.<FeedItem>();
            var _local1:InventoryTabContent = this.hud.gameSprite.hudView.tabStrip.getTabView(InventoryTabContent);
            var _local2:Vector.<InventoryTile> = new Vector.<InventoryTile>();
            if (_local1){
                _local2 = _local2.concat(_local1.storage.tiles);
            };
            for each (_local3 in _local2) {
                _local4 = _local3.getItemId();
                if (((!((_local4 == -1))) && (this.hasFeedPower(_local4)))){
                    _local5 = new FeedItem(_local3);
                    this.items.push(_local5);
                    this.view.addItem(_local5);
                };
            };
        }

        private function refreshFeedPower():void{
            var _local3:FeedItem;
            var _local1:int;
            var _local2:int;
            for each (_local3 in this.items) {
                if (_local3.selected){
                    _local1 = (_local1 + _local3.feedPower);
                    _local2++;
                };
            };
            if (this.currentPet){
                this.view.feedGoldButton.price = ((Boolean(this.seasonalEventModel.isChallenger)) ? 0 : (FeedFuseCostModel.getFeedGoldCost(this.currentPet.rarity) * _local2));
                this.view.feedFameButton.price = ((Boolean(this.seasonalEventModel.isChallenger)) ? 0 : (FeedFuseCostModel.getFeedFameCost(this.currentPet.rarity) * _local2));
                this.view.updateFeedPower(_local1, this.currentPet.maxedAvailableAbilities());
            }
            else {
                this.view.feedGoldButton.price = 0;
                this.view.feedFameButton.price = 0;
                this.view.updateFeedPower(0, false);
            };
            this.simulateFeed.dispatch(_local1);
        }

        private function get currentGold():int{
            var _local1:Player = this.gameModel.player;
            if (_local1 != null){
                return (_local1.credits_);
            };
            if (this.playerModel != null){
                return (this.playerModel.getCredits());
            };
            return (0);
        }

        private function get currentFame():int{
            var _local1:Player = this.gameModel.player;
            if (_local1 != null){
                return (_local1.fame_);
            };
            if (this.playerModel != null){
                return (this.playerModel.getFame());
            };
            return (0);
        }

        private function hasFeedPower(_arg1:int):Boolean{
            var _local3:XML;
            var _local2:XML = ObjectLibrary.xmlLibrary_[_arg1];
            if (ObjectLibrary.usePatchedData){
                _local3 = ObjectLibrary.xmlPatchLibrary_[_arg1];
                if (((_local3) && (_local3.hasOwnProperty("feedPower")))){
                    return (true);
                };
            };
            return (_local2.hasOwnProperty("feedPower"));
        }

        private function purchaseFame(_arg1:BaseButton):void{
            this.purchase(PetUpgradeRequest.FAME_PAYMENT_TYPE, this.view.feedFameButton.price);
        }

        private function purchaseGold(_arg1:BaseButton):void{
            this.purchase(PetUpgradeRequest.GOLD_PAYMENT_TYPE, this.view.feedGoldButton.price);
        }

        private function purchase(_arg1:int, _arg2:int):void{
            var _local4:FeedItem;
            var _local5:FeedPetRequestVO;
            var _local6:SlotObjectData;
            if (!this.checkYardType()){
                return;
            };
            if ((((_arg1 == PetUpgradeRequest.GOLD_PAYMENT_TYPE)) && ((this.currentGold < _arg2)))){
                this.showPopup.dispatch(new NotEnoughResources(300, Currency.GOLD));
                return;
            };
            if ((((_arg1 == PetUpgradeRequest.FAME_PAYMENT_TYPE)) && ((this.currentFame < _arg2)))){
                this.showPopup.dispatch(new NotEnoughResources(300, Currency.FAME));
                return;
            };
            var _local3:Vector.<SlotObjectData> = new Vector.<SlotObjectData>();
            for each (_local4 in this.items) {
                if (_local4.selected){
                    _local6 = new SlotObjectData();
                    _local6.objectId_ = _local4.item.ownerGrid.owner.objectId_;
                    _local6.objectType_ = _local4.item.getItemId();
                    _local6.slotId_ = _local4.item.tileId;
                    _local3.push(_local6);
                };
            };
            this.currentPet.abilityUpdated.addOnce(this.abilityUpdated);
            this.showFade.dispatch();
            _local5 = new FeedPetRequestVO(this.currentPet.getID(), _local3, _arg1);
            this.upgradePet.dispatch(_local5);
        }

        private function abilityUpdated():void{
            var _local1:FeedItem;
            this.removeFade.dispatch();
            this.renderItems();
            for each (_local1 in this.items) {
                _local1.selected = false;
            };
            this.refreshFeedPower();
        }

        private function onPetSelected(_arg1:PetVO):void{
            var _local2:FeedItem;
            this.currentPet = _arg1;
            for each (_local2 in this.items) {
                _local2.selected = false;
            };
            this.refreshFeedPower();
        }

        private function checkYardType():Boolean{
            if (this.currentPet.rarity.ordinal >= this.model.getPetYardType()){
                this.showPopup.dispatch(new ErrorModal(350, "Feed Pets", LineBuilder.getLocalizedStringFromKey("server.upgrade_petyard_first")));
                return (false);
            };
            return (true);
        }


    }
}//package io.decagames.rotmg.pets.windows.yard.feed

