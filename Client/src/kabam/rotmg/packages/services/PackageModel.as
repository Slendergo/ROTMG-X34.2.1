// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.packages.services.PackageModel

package kabam.rotmg.packages.services{
    import org.osflash.signals.Signal;
    import kabam.rotmg.packages.model.PackageInfo;
    import kabam.rotmg.packages.model.*;

    public class PackageModel {

        public static const TARGETING_BOX_SLOT:int = 100;

        public const updateSignal:Signal = new Signal();

        public var numSpammed:int = 0;
        private var models:Object;
        private var initialized:Boolean;
        private var maxSlots:int = 18;

        public function PackageModel(){
            this.models = {};
            super();
        }

        public function getBoxesForGrid():Vector.<PackageInfo>{
            var _local2:PackageInfo;
            var _local1:Vector.<PackageInfo> = new Vector.<PackageInfo>(this.maxSlots);
            for each (_local2 in this.models) {
                if (((((!((_local2.slot == 0))) && (!((_local2.slot == TARGETING_BOX_SLOT))))) && (this.isPackageValid(_local2)))){
                    _local1[(_local2.slot - 1)] = _local2;
                };
            };
            return (_local1);
        }

        public function getTargetingBoxesForGrid():Vector.<PackageInfo>{
            var _local2:PackageInfo;
            var _local1:Vector.<PackageInfo> = new Vector.<PackageInfo>(this.maxSlots);
            for each (_local2 in this.models) {
                if ((((_local2.slot == TARGETING_BOX_SLOT)) && (this.isPackageValid(_local2)))){
                    _local1.push(_local2);
                };
            };
            return (_local1);
        }

        private function isPackageValid(_arg1:PackageInfo):Boolean{
            return ((((((_arg1.unitsLeft == -1)) || ((_arg1.unitsLeft > 0)))) && ((((_arg1.maxPurchase == -1)) || ((_arg1.purchaseLeft > 0))))));
        }

        public function startupPackage():PackageInfo{
            var _local2:PackageInfo;
            var _local1:PackageInfo;
            for each (_local2 in this.models) {
                if (_local2.slot == TARGETING_BOX_SLOT){
                    return (_local2);
                };
                if (((((this.isPackageValid(_local2)) && (_local2.showOnLogin))) && (!((_local2.popupImage == ""))))){
                    if (_local1 != null){
                        if (((!((_local2.unitsLeft == -1))) || (!((_local2.maxPurchase == -1))))){
                            _local1 = _local2;
                        };
                    }
                    else {
                        _local1 = _local2;
                    };
                };
            };
            return (_local1);
        }

        public function getInitialized():Boolean{
            return (this.initialized);
        }

        public function getPackageById(_arg1:int):PackageInfo{
            return (this.models[_arg1]);
        }

        public function hasPackage(_arg1:int):Boolean{
            return ((_arg1 in this.models));
        }

        public function setPackages(_arg1:Array):void{
            var _local2:PackageInfo;
            this.models = {};
            for each (_local2 in _arg1) {
                this.models[_local2.id] = _local2;
            };
            this.updateSignal.dispatch();
            this.initialized = true;
        }

        public function canPurchasePackage(_arg1:int):Boolean{
            var _local2:PackageInfo = this.models[_arg1];
            return (!((_local2 == null)));
        }

        public function getPriorityPackage():PackageInfo{
            var _local1:PackageInfo;
            return (_local1);
        }

        public function setInitialized(_arg1:Boolean):void{
            this.initialized = _arg1;
        }

        public function hasPackages():Boolean{
            var _local1:Object;
            for each (_local1 in this.models) {
                return (true);
            };
            return (false);
        }


    }
}//package kabam.rotmg.packages.services

