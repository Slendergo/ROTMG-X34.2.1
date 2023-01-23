// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.DeprecatedClickableText

package com.company.assembleegameclient.ui{
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;

    public class DeprecatedClickableText extends ClickableTextBase {

        public function DeprecatedClickableText(_arg1:int, _arg2:Boolean, _arg3:String){
            super(_arg1, _arg2, _arg3);
        }

        override protected function makeText():TextFieldDisplayConcrete{
            return (new TextFieldDisplayConcrete());
        }


    }
}//package com.company.assembleegameclient.ui

