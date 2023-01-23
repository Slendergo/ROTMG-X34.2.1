// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.spinner.FixedNumbersSpinner

package io.decagames.rotmg.ui.spinner{
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;

    public class FixedNumbersSpinner extends NumberSpinner {

        private var _numbers:Vector.<int>;

        public function FixedNumbersSpinner(_arg1:SliceScalingBitmap, _arg2:int, _arg3:Vector.<int>, _arg4:String=""){
            super(_arg1, _arg2, 0, (_arg3.length - 1), 1, _arg4);
            this._numbers = _arg3;
            this.updateLabel();
        }

        override protected function updateLabel():void{
            label.text = (this._numbers[_value] + suffix);
            label.x = (-(label.width) / 2);
        }

        override public function get value():int{
            return (this._numbers[_value]);
        }

        override public function set value(_arg1:int):void{
            var _local2:int = _value;
            _value = this._numbers.indexOf(_arg1);
            if (_value < 0){
                _value = 0;
            };
            if (_value != _local2){
                valueWasChanged.dispatch(this.value);
            };
            this.updateLabel();
        }


    }
}//package io.decagames.rotmg.ui.spinner

