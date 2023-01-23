// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.packages.services.GetPackagesTask

package kabam.rotmg.packages.services{
    import kabam.lib.tasks.BaseTask;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.account.core.Account;
    import robotlegs.bender.framework.api.ILogger;
    import kabam.rotmg.language.model.LanguageModel;
    import kabam.rotmg.packages.model.PackageInfo;
    import com.company.assembleegameclient.util.TimeUtil;

    public class GetPackagesTask extends BaseTask {

        private static var version:String = "0";

        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var packageModel:PackageModel;
        [Inject]
        public var account:Account;
        [Inject]
        public var logger:ILogger;
        [Inject]
        public var languageModel:LanguageModel;


        override protected function startTask():void{
            var _local1:Object = this.account.getCredentials();
            _local1.language = this.languageModel.getLanguage();
            _local1.version = version;
            this.client.sendRequest("/package/getPackages", _local1);
            this.client.complete.addOnce(this.onComplete);
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            if (_arg1){
                this.handleOkay(_arg2);
            }
            else {
                this.logger.warn("GetPackageTask.onComplete: Request failed.");
                completeTask(true);
            };
            reset();
        }

        private function handleOkay(_arg1):void{
            version = XML(_arg1).attribute("version").toString();
            var _local2:XMLList = XML(_arg1).child("Package");
            var _local3:XMLList = XML(_arg1).child("SoldCounter");
            if (_local3.length() > 0){
                this.updateSoldCounters(_local3);
            };
            if (_local2.length() > 0){
                this.parse(_local2);
            }
            else {
                if (this.packageModel.getInitialized()){
                    this.packageModel.updateSignal.dispatch();
                };
            };
            completeTask(true);
        }

        private function updateSoldCounters(_arg1:XMLList):void{
            var _local2:XML;
            var _local3:PackageInfo;
            for each (_local2 in _arg1) {
                _local3 = this.packageModel.getPackageById(_local2.attribute("id").toString());
                if (_local3 != null){
                    if (_local2.attribute("left") != "-1"){
                        _local3.unitsLeft = _local2.attribute("left");
                    };
                    if (_local2.attribute("purchaseLeft") != "-1"){
                        _local3.purchaseLeft = _local2.attribute("purchaseLeft");
                    };
                };
            };
        }

        private function hasNoPackage(_arg1):Boolean{
            var _local2:XMLList = XML(_arg1).children();
            var _local3 = (_local2.length() == 0);
            return (_local3);
        }

        private function parse(_arg1:XMLList):void{
            var _local3:XML;
            var _local4:PackageInfo;
            var _local2:Array = [];
            for each (_local3 in _arg1) {
                _local4 = new PackageInfo();
                _local4.id = _local3.attribute("id").toString();
                _local4.title = _local3.attribute("title").toString();
                _local4.weight = _local3.attribute("weight").toString();
                _local4.description = _local3.Description.toString();
                _local4.contents = _local3.Contents.toString();
                _local4.priceAmount = int(_local3.Price.attribute("amount").toString());
                _local4.priceCurrency = _local3.Price.attribute("currency").toString();
                if (_local3.hasOwnProperty("Sale")){
                    _local4.saleAmount = int(_local3.Sale.attribute("price").toString());
                    _local4.saleCurrency = int(_local3.Sale.attribute("currency").toString());
                };
                if (_local3.hasOwnProperty("Left")){
                    _local4.unitsLeft = _local3.Left;
                };
                if (_local3.hasOwnProperty("MaxPurchase")){
                    _local4.maxPurchase = _local3.MaxPurchase;
                };
                if (_local3.hasOwnProperty("PurchaseLeft")){
                    _local4.purchaseLeft = _local3.PurchaseLeft;
                };
                if (_local3.hasOwnProperty("ShowOnLogin")){
                    _local4.showOnLogin = (int(_local3.ShowOnLogin) == 1);
                };
                if (_local3.hasOwnProperty("Total")){
                    _local4.totalUnits = _local3.Total;
                };
                if (_local3.hasOwnProperty("Slot")){
                    _local4.slot = _local3.Slot;
                };
                if (_local3.hasOwnProperty("Tags")){
                    _local4.tags = _local3.Tags;
                };
                if (_local3.StartTime.toString()){
                    _local4.startTime = TimeUtil.parseUTCDate(_local3.StartTime.toString());
                };
                if (_local3.EndTime.toString()){
                    _local4.endTime = TimeUtil.parseUTCDate(_local3.EndTime.toString());
                };
                _local4.image = _local3.Image.toString();
                _local4.charSlot = int(_local3.CharSlot.toString());
                _local4.vaultSlot = int(_local3.VaultSlot.toString());
                _local4.gold = int(_local3.Gold.toString());
                if (_local3.PopupImage.toString() != ""){
                    _local4.popupImage = _local3.PopupImage.toString();
                };
                _local2.push(_local4);
            };
            this.packageModel.setPackages(_local2);
        }


    }
}//package kabam.rotmg.packages.services

