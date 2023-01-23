// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.DeprecatedTextButtonStatic

package com.company.assembleegameclient.ui{
    import org.osflash.signals.Signal;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

    public class DeprecatedTextButtonStatic extends TextButtonBase {

        public const textChanged:Signal = new Signal();

        public function DeprecatedTextButtonStatic(_arg1:int, _arg2:String, _arg3:int=0){
            super(_arg3);
            addText(_arg1);
            text_.setStringBuilder(new StaticStringBuilder(_arg2));
            text_.textChanged.addOnce(this.onTextChanged);
        }

        protected function onTextChanged():void{
            initText();
            this.textChanged.dispatch();
        }


    }
}//package com.company.assembleegameclient.ui

