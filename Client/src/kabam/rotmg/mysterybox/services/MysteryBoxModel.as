// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.mysterybox.services.MysteryBoxModel

package kabam.rotmg.mysterybox.services{
    import org.osflash.signals.Signal;
    import kabam.rotmg.mysterybox.model.MysteryBoxInfo;

    public class MysteryBoxModel {

        public const updateSignal:Signal = new Signal();

        private var models:Object;
        private var initialized:Boolean = false;
        private var _isNew:Boolean = false;
        private var maxSlots:int = 18;


        public function getBoxesOrderByWeight():Object{
            return (this.models);
        }

        public function getBoxesForGrid():Vector.<MysteryBoxInfo>{
            var _local2:MysteryBoxInfo;
            var _local1:Vector.<MysteryBoxInfo> = new Vector.<MysteryBoxInfo>(this.maxSlots);
            for each (_local2 in this.models) {
                if (((!((_local2.slot == 0))) && (this.isBoxValid(_local2)))){
                    _local1[(_local2.slot - 1)] = _local2;
                };
            };
            return (_local1);
        }

        private function isBoxValid(_arg1:MysteryBoxInfo):Boolean{
            return ((((((_arg1.unitsLeft == -1)) || ((_arg1.unitsLeft > 0)))) && ((((_arg1.maxPurchase == -1)) || ((_arg1.purchaseLeft > 0))))));
        }

        public function getBoxById(_arg1:String):MysteryBoxInfo{
            var _local2:MysteryBoxInfo;
            for each (_local2 in this.models) {
                if (_local2.id == _arg1){
                    return (_local2);
                };
            };
            return (null);
        }

        public function setMysetryBoxes(_arg1:Array):void{
            var _local2:MysteryBoxInfo;
            this.models = {};
            for each (_local2 in _arg1) {
                this.models[_local2.id] = _local2;
            };
            this.updateSignal.dispatch();
            this.initialized = true;
        }

        public function isInitialized():Boolean{
            return (this.initialized);
        }

        public function setInitialized(_arg1:Boolean):void{
            this.initialized = _arg1;
        }

        public function get isNew():Boolean{
            return (this._isNew);
        }

        public function set isNew(_arg1:Boolean):void{
            this._isNew = _arg1;
        }


    }
}//package kabam.rotmg.mysterybox.services

