﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.game.view.TextPanel

package kabam.rotmg.game.view{
    import com.company.assembleegameclient.ui.panels.Panel;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import com.company.assembleegameclient.game.GameSprite;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import flash.text.TextFieldAutoSize;
    import kabam.rotmg.text.model.TextKey;
    import flash.filters.DropShadowFilter;

    public class TextPanel extends Panel {

        private var textField:TextFieldDisplayConcrete;
        private var virtualWidth:Number;
        private var virtualHeight:Number;

        public function TextPanel(_arg1:GameSprite){
            super(_arg1);
            this.initTextfield();
        }

        public function init(_arg1:String):void{
            this.textField.setStringBuilder(new LineBuilder().setParams(_arg1));
            this.textField.setAutoSize(TextFieldAutoSize.CENTER).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
            this.textField.x = (WIDTH / 2);
            this.textField.y = (HEIGHT / 2);
        }

        private function initTextfield():void{
            this.textField = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF);
            this.textField.setBold(true);
            this.textField.setStringBuilder(new LineBuilder().setParams(TextKey.TEXTPANEL_GIFTCHESTISEMPTY));
            this.textField.filters = [new DropShadowFilter(0, 0, 0)];
            addChild(this.textField);
        }


    }
}//package kabam.rotmg.game.view

