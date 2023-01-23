﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.components.TimerDisplay

package com.company.assembleegameclient.ui.components{
    import flash.display.Sprite;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.lib.util.TimeWriter;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

    public class TimerDisplay extends Sprite {

        private var _textField:TextFieldDisplayConcrete;
        private var stringifier:TimeWriter;

        public function TimerDisplay(_arg1:TextFieldDisplayConcrete){
            this.stringifier = new TimeWriter();
            super();
            this.initTextField(_arg1);
        }

        private function initTextField(_arg1:TextFieldDisplayConcrete):void{
            addChild((this._textField = _arg1));
        }

        public function update(_arg1:Number):void{
            this._textField.setStringBuilder(new StaticStringBuilder(this.stringifier.parseTime(_arg1)));
        }


    }
}//package com.company.assembleegameclient.ui.components

