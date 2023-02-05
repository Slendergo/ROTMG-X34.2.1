// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.labels.UILabel

package io.decagames.rotmg.ui.labels{
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;

    public class UILabel extends TextField {

        public static var DEBUG:Boolean = false;

        private var chromeFixMargin:int = 2;

        public function UILabel(){
            if (DEBUG){
                this.debugDraw();
            }
            if (WebMain.USER_AGENT == "Chrome"){
                super.y = this.chromeFixMargin;
            }
            this.embedFonts = true;
            this.selectable = false;
            this.autoSize = TextFieldAutoSize.LEFT;
        }

        private function debugDraw():void{
            this.border = true;
            this.borderColor = 0xFF0000;
        }

        override public function set y(_arg1:Number):void{
            if (WebMain.USER_AGENT == "Chrome"){
                super.y = (_arg1 + this.chromeFixMargin);
            }
            else {
                super.y = _arg1;
            }
        }

        override public function get textWidth():Number{
            return ((super.textWidth + 4));
        }


    }
}//package io.decagames.rotmg.ui.labels

