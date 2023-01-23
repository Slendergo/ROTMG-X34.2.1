// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.textField.InputTextField

package io.decagames.rotmg.ui.textField{
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.text.TextFieldType;
    import flash.text.TextFieldAutoSize;
    import flash.events.FocusEvent;
    import flash.events.Event;

    public class InputTextField extends UILabel {

        private var _wasModified:Boolean;
        private var placeholder:String;

        public function InputTextField(_arg1:String=""){
            this.placeholder = _arg1;
            this.text = _arg1;
            this.type = TextFieldType.INPUT;
            this.autoSize = TextFieldAutoSize.LEFT;
            this.selectable = true;
            this.wordWrap = true;
            this.multiline = false;
            this.addEventListener(FocusEvent.FOCUS_IN, this.onFocusHandler);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoveEvent);
        }

        public function reset():void{
            this.text = this.placeholder;
            this._wasModified = false;
        }

        private function onRemoveEvent(_arg1:Event):void{
            this.removeEventListener(FocusEvent.FOCUS_IN, this.onFocusHandler);
            this.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoveEvent);
        }

        private function onFocusHandler(_arg1:FocusEvent):void{
            if (!this._wasModified){
                this._wasModified = true;
                this.text = "";
            };
        }

        public function get wasModified():Boolean{
            return (this._wasModified);
        }


    }
}//package io.decagames.rotmg.ui.textField

