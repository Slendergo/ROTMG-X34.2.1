// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.mysteryBox.rollModal.MysteryBoxRollModalMediator

package io.decagames.rotmg.shop.mysteryBox.rollModal{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.Account;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import kabam.rotmg.game.model.GameModel;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import kabam.rotmg.mysterybox.services.GetMysteryBoxesTask;
    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
    import flash.utils.Timer;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import flash.events.TimerEvent;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.popups.header.PopupHeader;
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;
    import flash.utils.Dictionary;
    import com.company.assembleegameclient.objects.Player;
    import io.decagames.rotmg.utils.dictionary.DictionaryUtils;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
    import io.decagames.rotmg.shop.genericBox.BoxUtils;
    import io.decagames.rotmg.ui.buttons.BaseButton;

    public class MysteryBoxRollModalMediator extends Mediator {

        [Inject]
        public var view:MysteryBoxRollModal;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var gameModel:GameModel;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var getMysteryBoxesTask:GetMysteryBoxesTask;
        [Inject]
        public var supportCampaignModel:SupporterCampaignModel;
        private var boxConfig:Array;
        private var swapImageTimer:Timer;
        private var totalRollDelay:int = 2000;
        private var nextRollDelay:int = 550;
        private var quantity:int = 1;
        private var requestComplete:Boolean;
        private var timerComplete:Boolean;
        private var rollNumber:int = 0;
        private var timeout:uint;
        private var rewardsList:Array;
        private var totalRewards:int = 0;
        private var closeButton:SliceScalingButton;
        private var totalRolls:int = 1;

        public function MysteryBoxRollModalMediator(){
            this.swapImageTimer = new Timer(80);
            this.rewardsList = [];
            super();
        }

        override public function initialize():void{
            this.configureRoll();
            this.swapImageTimer.addEventListener(TimerEvent.TIMER, this.swapItems);
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.boxConfig = this.parseBoxContents();
            this.quantity = this.view.quantity;
            this.playRollAnimation();
            this.sendRollRequest();
        }

        override public function destroy():void{
            this.closeButton.clickSignal.remove(this.onClose);
            this.closeButton.dispose();
            this.swapImageTimer.removeEventListener(TimerEvent.TIMER, this.swapItems);
            this.view.spinner.valueWasChanged.remove(this.changeAmountHandler);
            this.view.buyButton.clickSignal.remove(this.buyMore);
            this.view.finishedShowingResult.remove(this.onAnimationFinished);
            clearTimeout(this.timeout);
        }

        private function sendRollRequest():void{
            this.view.spinner.valueWasChanged.remove(this.changeAmountHandler);
            this.view.buyButton.clickSignal.remove(this.buyMore);
            this.closeButton.clickSignal.remove(this.onClose);
            this.requestComplete = false;
            this.timerComplete = false;
            var _local1:Object = this.account.getCredentials();
            _local1.boxId = this.view.info.id;
            if (this.view.info.isOnSale()){
                _local1.quantity = this.quantity;
                _local1.price = this.view.info.saleAmount;
                _local1.currency = this.view.info.saleCurrency;
            }
            else {
                _local1.quantity = this.quantity;
                _local1.price = this.view.info.priceAmount;
                _local1.currency = this.view.info.priceCurrency;
            };
            this.client.sendRequest("/account/purchaseMysteryBox", _local1);
            this.client.complete.addOnce(this.onRollRequestComplete);
            this.timeout = setTimeout(this.showRewards, this.totalRollDelay);
        }

        private function showRewards():void{
            var _local1:Dictionary;
            this.timerComplete = true;
            clearTimeout(this.timeout);
            if (this.requestComplete){
                this.view.finishedShowingResult.add(this.onAnimationFinished);
                this.view.bigSpinner.pause();
                this.view.littleSpinner.pause();
                this.swapImageTimer.stop();
                _local1 = this.rewardsList[this.rollNumber];
                if (this.rollNumber == 0){
                    this.view.prepareResultGrid(this.totalRewards);
                };
                this.view.displayResult([_local1]);
            };
        }

        private function onRollRequestComplete(_arg1:Boolean, _arg2):void{
            var _local3:XML;
            var _local4:XML;
            var _local5:Player;
            var _local6:Array;
            var _local7:Dictionary;
            var _local8:String;
            var _local9:Array;
            var _local10:int;
            var _local11:Array;
            var _local12:int;
            var _local13:Array;
            this.requestComplete = true;
            if (_arg1){
                _local3 = new XML(_arg2);
                this.rewardsList = [];
                if (_local3.hasOwnProperty("CampaignProgress")){
                    this.supportCampaignModel.parseUpdateData(_local3.CampaignProgress);
                };
                for each (_local4 in _local3.elements("Awards")) {
                    _local6 = _local4.toString().split(",");
                    _local7 = this.convertItemsToAmountDictionary(_local6);
                    this.totalRewards = (this.totalRewards + DictionaryUtils.countKeys(_local7));
                    this.rewardsList.push(_local7);
                };
                if (((_local3.hasOwnProperty("Left")) && (!((this.view.info.unitsLeft == -1))))){
                    this.view.info.unitsLeft = int(_local3.Left);
                    if (this.view.info.unitsLeft == 0){
                        this.view.buyButton.soldOut = true;
                    };
                };
                _local5 = this.gameModel.player;
                if (_local5 != null){
                    if (_local3.hasOwnProperty("Gold")){
                        _local5.setCredits(int(_local3.Gold));
                    }
                    else {
                        if (_local3.hasOwnProperty("Fame")){
                            _local5.setFame(int(_local3.Fame));
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
                if (((_local3.hasOwnProperty("PurchaseLeft")) && (!((this.view.info.purchaseLeft == -1))))){
                    this.view.info.purchaseLeft = int(_local3.PurchaseLeft);
                    if (this.view.info.purchaseLeft <= 0){
                        this.view.buyButton.soldOut = true;
                    };
                };
                if (this.timerComplete){
                    this.showRewards();
                };
            }
            else {
                clearTimeout(this.timeout);
                _local8 = "MysteryBoxRollModal.pleaseTryAgainString";
                if (LineBuilder.getLocalizedStringFromKey(_arg2) != ""){
                    _local8 = _arg2;
                };
                if (_arg2.indexOf("MysteryBoxError.soldOut") >= 0){
                    _local9 = _arg2.split("|");
                    if (_local9.length == 2){
                        _local10 = _local9[1];
                        this.view.info.unitsLeft = _local10;
                        if (_local10 == 0){
                            _local8 = "MysteryBoxError.soldOutAll";
                        }
                        else {
                            _local8 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutLeft", {
                                left:this.view.info.unitsLeft,
                                box:(((this.view.info.unitsLeft == 1)) ? LineBuilder.getLocalizedStringFromKey("MysteryBoxError.box") : LineBuilder.getLocalizedStringFromKey("MysteryBoxError.boxes"))
                            });
                        };
                    };
                };
                if (_arg2.indexOf("MysteryBoxError.maxPurchase") >= 0){
                    _local11 = _arg2.split("|");
                    if (_local11.length == 2){
                        _local12 = _local11[1];
                        if (_local12 == 0){
                            _local8 = "MysteryBoxError.maxPurchase";
                        }
                        else {
                            _local8 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.maxPurchaseLeft", {left:_local12});
                        };
                    };
                };
                if (_arg2.indexOf("blockedForUser") >= 0){
                    _local13 = _arg2.split("|");
                    if (_local13.length == 2){
                        _local8 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.blockedForUser", {date:_local13[1]});
                    };
                };
                this.showErrorMessage(_local8);
            };
        }

        private function showErrorMessage(_arg1:String):void{
            this.closePopupSignal.dispatch(this.view);
            this.showPopupSignal.dispatch(new ErrorModal(300, LineBuilder.getLocalizedStringFromKey("MysteryBoxRollModal.purchaseFailedString", {}), LineBuilder.getLocalizedStringFromKey(_arg1, {})));
            this.getMysteryBoxesTask.start();
        }

        private function configureRoll():void{
            if (this.view.info.quantity > 1){
                this.totalRollDelay = 1000;
            };
        }

        private function convertItemsToAmountDictionary(_arg1:Array):Dictionary{
            var _local3:String;
            var _local2:Dictionary = new Dictionary();
            for each (_local3 in _arg1) {
                if (_local2[_local3]){
                    var _local6 = _local2;
                    var _local7 = _local3;
                    var _local8 = (_local6[_local7] + 1);
                    _local6[_local7] = _local8;
                }
                else {
                    _local2[_local3] = 1;
                };
            };
            return (_local2);
        }

        private function parseBoxContents():Array{
            var _local4:String;
            var _local5:Array;
            var _local6:Array;
            var _local7:String;
            var _local1:Array = this.view.info.contents.split("|");
            var _local2:Array = [];
            var _local3:int;
            for each (_local4 in _local1) {
                _local5 = [];
                _local6 = _local4.split(";");
                for each (_local7 in _local6) {
                    _local5.push(this.convertItemsToAmountDictionary(_local7.split(",")));
                };
                _local2[_local3] = _local5;
                _local3++;
            };
            this.totalRolls = _local3;
            return (_local2);
        }

        private function onAnimationFinished():void{
            this.rollNumber++;
            if (this.rollNumber < this.view.quantity){
                this.playRollAnimation();
                this.timeout = setTimeout(this.showRewards, (this.view.totalAnimationTime(this.totalRolls) + this.nextRollDelay));
            }
            else {
                this.closeButton.clickSignal.addOnce(this.onClose);
                this.view.spinner.valueWasChanged.add(this.changeAmountHandler);
                this.view.spinner.value = this.view.quantity;
                this.view.showBuyButton();
                this.view.buyButton.clickSignal.add(this.buyMore);
            };
        }

        private function changeAmountHandler(_arg1:int):void{
            if (this.view.info.isOnSale()){
                this.view.buyButton.price = (_arg1 * int(this.view.info.saleAmount));
            }
            else {
                this.view.buyButton.price = (_arg1 * int(this.view.info.priceAmount));
            };
        }

        private function buyMore(_arg1:BaseButton):void{
            var _local2:Boolean = BoxUtils.moneyCheckPass(this.view.info, this.view.spinner.value, this.gameModel, this.playerModel, this.showPopupSignal);
            if (_local2){
                this.rollNumber = 0;
                this.totalRewards = 0;
                this.view.buyMore(this.view.spinner.value);
                this.configureRoll();
                this.quantity = this.view.quantity;
                this.playRollAnimation();
                this.sendRollRequest();
            };
        }

        private function playRollAnimation():void{
            this.view.bigSpinner.resume();
            this.view.littleSpinner.resume();
            this.swapImageTimer.start();
            this.swapItems(null);
        }

        private function swapItems(_arg1:TimerEvent):void{
            var _local3:Array;
            var _local4:int;
            var _local2:Array = [];
            for each (_local3 in this.boxConfig) {
                _local4 = Math.floor((Math.random() * _local3.length));
                _local2.push(_local3[_local4]);
            };
            this.view.displayItems(_local2);
        }

        private function onClose(_arg1:BaseButton):void{
            this.closePopupSignal.dispatch(this.view);
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.rollModal

