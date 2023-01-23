// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.packages.PackageBoxTileMediator

package io.decagames.rotmg.shop.packages{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.game.model.GameModel;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.Account;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import io.decagames.rotmg.shop.PurchaseInProgressModal;
    import flash.events.MouseEvent;
    import io.decagames.rotmg.shop.genericBox.BoxUtils;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import com.company.assembleegameclient.objects.Player;
    import kabam.rotmg.packages.model.PackageInfo;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
    import io.decagames.rotmg.shop.packages.contentPopup.PackageBoxContentPopup;

    public class PackageBoxTileMediator extends Mediator {

        [Inject]
        public var view:PackageBoxTile;
        [Inject]
        public var gameModel:GameModel;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var openDialogSignal:OpenDialogSignal;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var supportCampaignModel:SupporterCampaignModel;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        private var inProgressModal:PurchaseInProgressModal;


        override public function initialize():void{
            this.view.spinner.valueWasChanged.add(this.changeAmountHandler);
            this.view.buyButton.clickSignal.add(this.onBuyHandler);
            if (this.view.infoButton){
                this.view.infoButton.clickSignal.add(this.onInfoClick);
            };
            if (this.view.clickMask){
                this.view.clickMask.addEventListener(MouseEvent.CLICK, this.onBoxClickHandler);
            };
        }

        private function onBoxClickHandler(_arg1:MouseEvent):void{
            this.onInfoClick(null);
        }

        private function changeAmountHandler(_arg1:int):void{
            if (this.view.boxInfo.isOnSale()){
                this.view.buyButton.price = (_arg1 * int(this.view.boxInfo.saleAmount));
            }
            else {
                this.view.buyButton.price = (_arg1 * int(this.view.boxInfo.priceAmount));
            };
        }

        private function onBuyHandler(_arg1:BaseButton):void{
            var _local2:Boolean = BoxUtils.moneyCheckPass(this.view.boxInfo, this.view.spinner.value, this.gameModel, this.playerModel, this.showPopupSignal);
            if (_local2){
                this.inProgressModal = new PurchaseInProgressModal();
                this.showPopupSignal.dispatch(this.inProgressModal);
                this.sendPurchaseRequest();
            };
        }

        private function sendPurchaseRequest():void{
            var _local1:Object = this.account.getCredentials();
            _local1.isChallenger = this.seasonalEventModel.isChallenger;
            _local1.boxId = this.view.boxInfo.id;
            if (this.view.boxInfo.isOnSale()){
                _local1.quantity = this.view.spinner.value;
                _local1.price = this.view.boxInfo.saleAmount;
                _local1.currency = this.view.boxInfo.saleCurrency;
            }
            else {
                _local1.quantity = this.view.spinner.value;
                _local1.price = this.view.boxInfo.priceAmount;
                _local1.currency = this.view.boxInfo.priceCurrency;
            };
            this.client.sendRequest("/account/purchasePackage", _local1);
            this.client.complete.addOnce(this.onRollRequestComplete);
        }

        private function onRollRequestComplete(_arg1:Boolean, _arg2):void{
            var _local3:XML;
            var _local4:Player;
            var _local5:String;
            var _local6:Array;
            var _local7:int;
            var _local8:Array;
            var _local9:int;
            var _local10:Array;
            if (_arg1){
                _local3 = new XML(_arg2);
                if (_local3.hasOwnProperty("CampaignProgress")){
                    this.supportCampaignModel.parseUpdateData(_local3.CampaignProgress);
                };
                if (((_local3.hasOwnProperty("Left")) && (!((this.view.boxInfo.unitsLeft == -1))))){
                    this.view.boxInfo.unitsLeft = int(_local3.Left);
                };
                if (((_local3.hasOwnProperty("PurchaseLeft")) && (!((this.view.boxInfo.purchaseLeft == -1))))){
                    this.view.boxInfo.purchaseLeft = int(_local3.PurchaseLeft);
                };
                _local4 = this.gameModel.player;
                if (_local4 != null){
                    if (_local3.hasOwnProperty("Gold")){
                        _local4.setCredits(int(_local3.Gold));
                    }
                    else {
                        if (_local3.hasOwnProperty("Fame")){
                            _local4.setFame(int(_local3.Fame));
                        };
                    };
                }
                else {
                    if (this.playerModel != null){
                        if (_local3.hasOwnProperty("Gold")){
                            this.playerModel.setCredits(int(_local3.Gold));
                        }
                        else {
                            if (_local3.hasOwnProperty("Fame")){
                                this.playerModel.setFame(int(_local3.Fame));
                            };
                        };
                    };
                };
                this.closePopupSignal.dispatch(this.inProgressModal);
                this.showPopupSignal.dispatch(new PurchaseCompleteModal(PackageInfo(this.view.boxInfo).purchaseType));
            }
            else {
                _local5 = "MysteryBoxRollModal.pleaseTryAgainString";
                if (LineBuilder.getLocalizedStringFromKey(_arg2) != ""){
                    _local5 = _arg2;
                };
                if (_arg2.indexOf("MysteryBoxError.soldOut") >= 0){
                    _local6 = _arg2.split("|");
                    if (_local6.length == 2){
                        _local7 = _local6[1];
                        this.view.boxInfo.unitsLeft = _local7;
                        if (_local7 == 0){
                            _local5 = "MysteryBoxError.soldOutAll";
                        }
                        else {
                            _local5 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutLeft", {
                                left:this.view.boxInfo.unitsLeft,
                                box:(((this.view.boxInfo.unitsLeft == 1)) ? LineBuilder.getLocalizedStringFromKey("MysteryBoxError.box") : LineBuilder.getLocalizedStringFromKey("MysteryBoxError.boxes"))
                            });
                        };
                    };
                };
                if (_arg2.indexOf("MysteryBoxError.maxPurchase") >= 0){
                    _local8 = _arg2.split("|");
                    if (_local8.length == 2){
                        _local9 = _local8[1];
                        if (_local9 == 0){
                            _local5 = "MysteryBoxError.maxPurchase";
                        }
                        else {
                            _local5 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.maxPurchaseLeft", {left:_local9});
                        };
                    };
                };
                if (_arg2.indexOf("blockedForUser") >= 0){
                    _local10 = _arg2.split("|");
                    if (_local10.length == 2){
                        _local5 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.blockedForUser", {date:_local10[1]});
                    };
                };
                this.showErrorMessage(_local5);
            };
        }

        private function showErrorMessage(_arg1:String):void{
            this.closePopupSignal.dispatch(this.inProgressModal);
            this.showPopupSignal.dispatch(new ErrorModal(300, LineBuilder.getLocalizedStringFromKey("MysteryBoxRollModal.purchaseFailedString", {}), LineBuilder.getLocalizedStringFromKey(_arg1, {}).replace("box", "package")));
        }

        private function onInfoClick(_arg1:BaseButton):void{
            this.showPopupSignal.dispatch(new PackageBoxContentPopup(PackageInfo(this.view.boxInfo)));
        }

        override public function destroy():void{
            this.view.spinner.valueWasChanged.remove(this.changeAmountHandler);
            this.view.buyButton.clickSignal.remove(this.onBuyHandler);
            if (this.view.infoButton){
                this.view.infoButton.clickSignal.remove(this.onInfoClick);
            };
            if (this.view.clickMask){
                this.view.clickMask.removeEventListener(MouseEvent.CLICK, this.onBoxClickHandler);
            };
        }


    }
}//package io.decagames.rotmg.shop.packages

