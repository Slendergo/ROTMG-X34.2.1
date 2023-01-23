// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.mysterybox.services.GetMysteryBoxesTask

package kabam.rotmg.mysterybox.services{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.fortune.services.FortuneModel;
    import kabam.rotmg.account.core.Account;
    import robotlegs.bender.framework.api.ILogger;
    import kabam.rotmg.language.model.LanguageModel;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.fortune.model.FortuneInfo;
    import com.company.assembleegameclient.util.TimeUtil;
    import kabam.rotmg.mysterybox.model.MysteryBoxInfo;

    public class GetMysteryBoxesTask extends BaseTask {

        private static var version:String = "0";

        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var mysteryBoxModel:MysteryBoxModel;
        [Inject]
        public var fortuneModel:FortuneModel;
        [Inject]
        public var account:Account;
        [Inject]
        public var logger:ILogger;
        [Inject]
        public var languageModel:LanguageModel;
        [Inject]
        public var openDialogSignal:OpenDialogSignal;


        override protected function startTask():void{
            var _local1:Object = this.account.getCredentials();
            _local1.language = this.languageModel.getLanguage();
            _local1.version = version;
            this.client.sendRequest("/mysterybox/getBoxes", _local1);
            this.client.complete.addOnce(this.onComplete);
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            if (_arg1){
                this.handleOkay(_arg2);
            }
            else {
                this.logger.warn("GetMysteryBox.onComplete: Request failed.");
                completeTask(true);
            };
            reset();
        }

        private function handleOkay(_arg1):void{
            version = XML(_arg1).attribute("version").toString();
            var _local2:XMLList = XML(_arg1).child("MysteryBox");
            var _local3:XMLList = XML(_arg1).child("SoldCounter");
            if (_local3.length() > 0){
                this.updateSoldCounters(_local3);
            };
            if (_local2.length() > 0){
                this.parse(_local2);
            }
            else {
                if (this.mysteryBoxModel.isInitialized()){
                    this.mysteryBoxModel.updateSignal.dispatch();
                };
            };
            var _local4:XMLList = XML(_arg1).child("FortuneGame");
            if (_local4.length() > 0){
                this.parseFortune(_local4);
            };
            completeTask(true);
        }

        private function hasNoBoxes(_arg1):Boolean{
            var _local2:XMLList = XML(_arg1).children();
            var _local3 = (_local2.length() == 0);
            return (_local3);
        }

        private function parseFortune(_arg1:XMLList):void{
            var _local2:FortuneInfo = new FortuneInfo();
            _local2.id = _arg1.attribute("id").toString();
            _local2.title = _arg1.attribute("title").toString();
            _local2.weight = _arg1.attribute("weight").toString();
            _local2.description = _arg1.Description.toString();
            _local2.contents = _arg1.Contents.toString();
            _local2.priceFirstInGold = _arg1.Price.attribute("firstInGold").toString();
            _local2.priceFirstInToken = _arg1.Price.attribute("firstInToken").toString();
            _local2.priceSecondInGold = _arg1.Price.attribute("secondInGold").toString();
            _local2.iconImageUrl = _arg1.Icon.toString();
            _local2.infoImageUrl = _arg1.Image.toString();
            _local2.startTime = TimeUtil.parseUTCDate(_arg1.StartTime.toString());
            _local2.endTime = TimeUtil.parseUTCDate(_arg1.EndTime.toString());
            _local2.parseContents();
            this.fortuneModel.setFortune(_local2);
        }

        private function updateSoldCounters(_arg1:XMLList):void{
            var _local2:XML;
            var _local3:MysteryBoxInfo;
            for each (_local2 in _arg1) {
                _local3 = this.mysteryBoxModel.getBoxById(_local2.attribute("id").toString());
                if (_local2.attribute("left") != "-1"){
                    _local3.unitsLeft = _local2.attribute("left");
                };
                if (_local2.attribute("purchaseLeft") != "-1"){
                    _local3.purchaseLeft = _local2.attribute("purchaseLeft");
                };
            };
        }

        private function parse(_arg1:XMLList):void{
            var _local4:XML;
            var _local5:MysteryBoxInfo;
            var _local2:Array = [];
            var _local3:Boolean;
            for each (_local4 in _arg1) {
                _local5 = new MysteryBoxInfo();
                _local5.id = _local4.attribute("id").toString();
                _local5.title = _local4.attribute("title").toString();
                _local5.weight = _local4.attribute("weight").toString();
                _local5.description = _local4.Description.toString();
                _local5.contents = _local4.Contents.toString();
                _local5.priceAmount = int(_local4.Price.attribute("amount").toString());
                _local5.priceCurrency = _local4.Price.attribute("currency").toString();
                if (_local4.hasOwnProperty("Sale")){
                    _local5.saleAmount = _local4.Sale.attribute("price").toString();
                    _local5.saleCurrency = _local4.Sale.attribute("currency").toString();
                };
                if (_local4.hasOwnProperty("Left")){
                    _local5.unitsLeft = _local4.Left;
                };
                if (_local4.hasOwnProperty("Total")){
                    _local5.totalUnits = _local4.Total;
                };
                if (_local4.hasOwnProperty("Slot")){
                    _local5.slot = _local4.Slot;
                };
                if (_local4.hasOwnProperty("Jackpots")){
                    _local5.jackpots = _local4.Jackpots;
                };
                if (_local4.hasOwnProperty("DisplayedItems")){
                    _local5.displayedItems = _local4.DisplayedItems;
                };
                if (_local4.hasOwnProperty("Rolls")){
                    _local5.rolls = int(_local4.Rolls);
                };
                if (_local4.hasOwnProperty("Tags")){
                    _local5.tags = _local4.Tags;
                };
                if (_local4.hasOwnProperty("MaxPurchase")){
                    _local5.maxPurchase = _local4.MaxPurchase;
                };
                if (_local4.hasOwnProperty("PurchaseLeft")){
                    _local5.purchaseLeft = int(_local4.PurchaseLeft);
                };
                _local5.iconImageUrl = _local4.Icon.toString();
                _local5.infoImageUrl = _local4.Image.toString();
                _local5.startTime = TimeUtil.parseUTCDate(_local4.StartTime.toString());
                if (_local4.EndTime.toString()){
                    _local5.endTime = TimeUtil.parseUTCDate(_local4.EndTime.toString());
                };
                _local5.parseContents();
                if (((!(_local3)) && (((_local5.isNew()) || (_local5.isOnSale()))))){
                    _local3 = true;
                };
                _local2.push(_local5);
            };
            this.mysteryBoxModel.setMysetryBoxes(_local2);
            this.mysteryBoxModel.isNew = _local3;
        }


    }
}//package kabam.rotmg.mysterybox.services

