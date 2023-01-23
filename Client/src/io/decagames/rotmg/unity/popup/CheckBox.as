// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.unity.popup.CheckBox

package io.decagames.rotmg.unity.popup{
    import flash.display.Sprite;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import flash.filters.DropShadowFilter;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import flash.events.MouseEvent;
    import kabam.rotmg.text.view.stringBuilder.StringBuilder;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import flash.display.Graphics;
    import flash.display.LineScaleMode;
    import flash.display.CapsStyle;
    import flash.display.JointStyle;

    public class CheckBox extends Sprite {

        public var checkBox_:Sprite;
        public var text_:TextFieldDisplayConcrete;
        public var errorText_:TextFieldDisplayConcrete;
        private var hasError:Boolean;
        private var _checked:Boolean;
        private var _text:String;
        private var _fontSize:int;
        private var _boxSize:int;

        public function CheckBox(_arg1:String, _arg2:Boolean, _arg3:uint=16, _arg4:int=20){
            this._text = _arg1;
            this._checked = _arg2;
            this._fontSize = _arg3;
            this._boxSize = _arg4;
            this.init();
        }

        private function init():void{
            this.createCheckbox();
            this.createText();
            this.createErrorText();
        }

        private function createErrorText():void{
            this.errorText_ = new TextFieldDisplayConcrete().setSize(12).setColor(16549442);
            this.errorText_.filters = [new DropShadowFilter(0, 0, 0)];
            addChild(this.errorText_);
        }

        private function createText():void{
            this.text_ = new TextFieldDisplayConcrete().setSize(this._fontSize).setColor(0xB3B3B3);
            this.text_.setTextWidth(243);
            this.text_.x = ((this.checkBox_.x + this._boxSize) + 8);
            this.text_.setBold(true);
            this.text_.setMultiLine(true);
            this.text_.setWordWrap(true);
            this.text_.setHTML(true);
            this.text_.setStringBuilder(new LineBuilder().setParams(this._text));
            this.text_.mouseEnabled = true;
            this.text_.filters = [new DropShadowFilter(0, 0, 0)];
            this.text_.textChanged.addOnce(this.onTextChanged);
            addChild(this.text_);
        }

        private function createCheckbox():void{
            this.checkBox_ = new Sprite();
            this.checkBox_.x = 2;
            this.checkBox_.y = 2;
            this.redrawCheckBox();
            this.checkBox_.addEventListener(MouseEvent.CLICK, this.onClick);
            addChild(this.checkBox_);
        }

        public function setTextStringBuilder(_arg1:StringBuilder):void{
            this.text_.setStringBuilder(_arg1);
        }

        private function onTextChanged():void{
            this.errorText_.x = this.text_.x;
            this.errorText_.y = (this.text_.y + 20);
        }

        private function onClick(_arg1:MouseEvent):void{
            this.errorText_.setStringBuilder(new StaticStringBuilder(""));
            this._checked = !(this._checked);
            this.redrawCheckBox();
        }

        public function setErrorHighlight(_arg1:Boolean):void{
            this.hasError = _arg1;
            this.redrawCheckBox();
        }

        private function redrawCheckBox():void{
            var _local2:Number;
            var _local1:Graphics = this.checkBox_.graphics;
            _local1.clear();
            _local1.beginFill(0x333333, 1);
            _local1.drawRect(0, 0, this._boxSize, this._boxSize);
            _local1.endFill();
            if (this._checked){
                _local1.lineStyle(2, 0xB3B3B3, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND, JointStyle.ROUND);
                _local1.moveTo(2, 2);
                _local1.lineTo((this._boxSize - 2), (this._boxSize - 2));
                _local1.moveTo(2, (this._boxSize - 2));
                _local1.lineTo((this._boxSize - 2), 2);
                _local1.lineStyle();
                this.hasError = false;
            };
            if (this.hasError){
                _local2 = 16549442;
            }
            else {
                _local2 = 0x454545;
            };
            _local1.lineStyle(2, _local2, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND, JointStyle.ROUND);
            _local1.drawRect(0, 0, this._boxSize, this._boxSize);
            _local1.lineStyle();
        }

        public function isChecked():Boolean{
            return (this._checked);
        }

        public function setChecked():void{
            this._checked = true;
            this.redrawCheckBox();
        }

        public function setUnchecked():void{
            this._checked = false;
            this.redrawCheckBox();
        }

        public function setError(_arg1:String):void{
            this.errorText_.setStringBuilder(new LineBuilder().setParams(_arg1));
        }


    }
}//package io.decagames.rotmg.unity.popup

