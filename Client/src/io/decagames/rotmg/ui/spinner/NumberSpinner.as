// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.spinner.NumberSpinner

package io.decagames.rotmg.ui.spinner{
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.labels.UILabel;
    import org.osflash.signals.Signal;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFieldAutoSize;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;

    public class NumberSpinner extends Sprite {

        private var _upArrow:SliceScalingButton;
        private var _downArrow:SliceScalingButton;
        private var startValue:int;
        private var minValue:int;
        private var maxValue:int;
        protected var suffix:String;
        protected var label:UILabel;
        protected var _value:int;
        private var _step:int;
        public var valueWasChanged:Signal;

        public function NumberSpinner(_arg1:SliceScalingBitmap, _arg2:int, _arg3:int, _arg4:int, _arg5:int, _arg6:String=""){
            this._upArrow = new SliceScalingButton(_arg1);
            this.startValue = _arg2;
            this.minValue = _arg3;
            this.maxValue = _arg4;
            this.suffix = _arg6;
            this._step = _arg5;
            this.valueWasChanged = new Signal();
            this.label = new UILabel();
            DefaultLabelFormat.numberSpinnerLabel(this.label);
            this.label.autoSize = TextFieldAutoSize.LEFT;
            this.label.text = (_arg2.toString() + _arg6);
            this.label.x = (-(this.label.width) / 2);
            this._upArrow.x = (-(this._upArrow.width) / 2);
            this._upArrow.y = 6;
            this.label.y = (this._upArrow.height + 4);
            addChild(this.label);
            addChild(this._upArrow);
            this._downArrow = new SliceScalingButton(_arg1.clone());
            this._downArrow.rotation = 180;
            this._downArrow.x = (this._downArrow.width / 2);
            this._downArrow.y = ((this.label.y + this.label.height) + 6);
            addChild(this._downArrow);
            this._value = _arg2;
        }

        protected function updateLabel():void{
            this.label.text = (this._value.toString() + this.suffix);
            this.label.x = (-(this.label.width) / 2);
        }

        public function addToValue(_arg1:int):void{
            var _local2:int = this._value;
            this._value = (this._value + _arg1);
            if (this._value > this.maxValue){
                this._value = this.maxValue;
            }
            if (this._value < this.minValue){
                this._value = this.minValue;
            }
            if (this._value != _local2){
                this.valueWasChanged.dispatch(this.value);
            }
            this.updateLabel();
        }

        public function setValue(_arg1:int):void{
            var _local2:int = this._value;
            this._value = _arg1;
            if (this._value != _local2){
                this.valueWasChanged.dispatch(this.value);
            }
            this.updateLabel();
        }

        public function get value():int{
            return (this._value);
        }

        public function set value(_arg1:int):void{
            this._value = _arg1;
        }

        public function get upArrow():SliceScalingButton{
            return (this._upArrow);
        }

        public function get downArrow():SliceScalingButton{
            return (this._downArrow);
        }

        public function get step():int{
            return (this._step);
        }

        public function dispose():void{
            this._upArrow.dispose();
            this._downArrow.dispose();
            this.valueWasChanged.removeAll();
        }


    }
}//package io.decagames.rotmg.ui.spinner

