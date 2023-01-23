// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo

package io.decagames.rotmg.shop.genericBox.data{
    import org.osflash.signals.Signal;
    import com.company.assembleegameclient.util.TimeUtil;
    import io.decagames.rotmg.utils.date.TimeLeft;

    public class GenericBoxInfo {

        public const updateSignal:Signal = new Signal();

        protected var _id:String;
        protected var _title:String;
        protected var _description:String;
        protected var _weight:String;
        protected var _contents:String;
        protected var _priceAmount:int;
        protected var _priceCurrency:int;
        protected var _saleAmount:int;
        protected var _saleCurrency:int;
        protected var _quantity:int;
        protected var _startTime:Date;
        protected var _endTime:Date;
        protected var _unitsLeft:int = -1;
        protected var _totalUnits:int = -1;
        protected var _maxPurchase:int = -1;
        protected var _purchaseLeft:int = -1;
        protected var _slot:int = 0;
        protected var _tags:String = "";


        public function get id():String{
            return (this._id);
        }

        public function set id(_arg1:String):void{
            this._id = _arg1;
        }

        public function get title():String{
            return (this._title);
        }

        public function set title(_arg1:String):void{
            this._title = _arg1;
        }

        public function get description():String{
            return (this._description);
        }

        public function set description(_arg1:String):void{
            this._description = _arg1;
        }

        public function get weight():String{
            return (this._weight);
        }

        public function set weight(_arg1:String):void{
            this._weight = _arg1;
        }

        public function get contents():String{
            return (this._contents);
        }

        public function set contents(_arg1:String):void{
            this._contents = _arg1;
        }

        public function get priceAmount():int{
            return (this._priceAmount);
        }

        public function set priceAmount(_arg1:int):void{
            this._priceAmount = _arg1;
        }

        public function get priceCurrency():int{
            return (this._priceCurrency);
        }

        public function set priceCurrency(_arg1:int):void{
            this._priceCurrency = _arg1;
        }

        public function get saleAmount():int{
            return (this._saleAmount);
        }

        public function set saleAmount(_arg1:int):void{
            this._saleAmount = _arg1;
        }

        public function get saleCurrency():int{
            return (this._saleCurrency);
        }

        public function set saleCurrency(_arg1:int):void{
            this._saleCurrency = _arg1;
        }

        public function get quantity():int{
            return (this._quantity);
        }

        public function set quantity(_arg1:int):void{
            this._quantity = _arg1;
        }

        public function get startTime():Date{
            return (this._startTime);
        }

        public function set startTime(_arg1:Date):void{
            this._startTime = _arg1;
        }

        public function get endTime():Date{
            return (this._endTime);
        }

        public function set endTime(_arg1:Date):void{
            this._endTime = _arg1;
        }

        public function get unitsLeft():int{
            return (this._unitsLeft);
        }

        public function set unitsLeft(_arg1:int):void{
            this._unitsLeft = _arg1;
            this.updateSignal.dispatch();
        }

        public function get totalUnits():int{
            return (this._totalUnits);
        }

        public function set totalUnits(_arg1:int):void{
            this._totalUnits = _arg1;
        }

        public function get slot():int{
            return (this._slot);
        }

        public function set slot(_arg1:int):void{
            this._slot = _arg1;
        }

        public function get tags():String{
            return (this._tags);
        }

        public function set tags(_arg1:String):void{
            this._tags = _arg1;
        }

        public function getSecondsToEnd():Number{
            if (!this._endTime){
                return (int.MAX_VALUE);
            };
            var _local1:Date = new Date();
            return (((this._endTime.time - _local1.time) / 1000));
        }

        public function getSecondsToStart():Number{
            var _local1:Date = new Date();
            return (((this._startTime.time - _local1.time) / 1000));
        }

        public function isOnSale():Boolean{
            return ((this._saleAmount > -1));
        }

        public function isNew():Boolean{
            var _local1:Date = new Date();
            if (this._startTime.time > _local1.time){
                return (false);
            };
            return ((Math.ceil(TimeUtil.secondsToDays(((_local1.time - this._startTime.time) / 1000))) <= 1));
        }

        public function getStartTimeString():String{
            var _local1 = "Available in: ";
            var _local2:Number = this.getSecondsToStart();
            if (_local2 <= 0){
                return ("");
            };
            if (_local2 > TimeUtil.DAY_IN_S){
                _local1 = (_local1 + TimeLeft.parse(_local2, "%dd %hh"));
            }
            else {
                if (_local2 > TimeUtil.HOUR_IN_S){
                    _local1 = (_local1 + TimeLeft.parse(_local2, "%hh %mm"));
                }
                else {
                    _local1 = (_local1 + TimeLeft.parse(_local2, "%mm %ss"));
                };
            };
            return (_local1);
        }

        public function getEndTimeString():String{
            if (!this._endTime){
                return ("");
            };
            var _local1 = "Ends in: ";
            var _local2:Number = this.getSecondsToEnd();
            if (_local2 <= 0){
                return ("");
            };
            if (_local2 > TimeUtil.DAY_IN_S){
                _local1 = (_local1 + TimeLeft.parse(_local2, "%dd %hh"));
            }
            else {
                if (_local2 > TimeUtil.HOUR_IN_S){
                    _local1 = (_local1 + TimeLeft.parse(_local2, "%hh %mm"));
                }
                else {
                    _local1 = (_local1 + TimeLeft.parse(_local2, "%mm %ss"));
                };
            };
            return (_local1);
        }

        public function get maxPurchase():int{
            return (this._maxPurchase);
        }

        public function set maxPurchase(_arg1:int):void{
            this._maxPurchase = _arg1;
        }

        public function get purchaseLeft():int{
            return (this._purchaseLeft);
        }

        public function set purchaseLeft(_arg1:int):void{
            this._purchaseLeft = _arg1;
            this.updateSignal.dispatch();
        }


    }
}//package io.decagames.rotmg.shop.genericBox.data

