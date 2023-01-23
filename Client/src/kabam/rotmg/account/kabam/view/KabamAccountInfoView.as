﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.kabam.view.KabamAccountInfoView

package kabam.rotmg.account.kabam.view{
    import flash.display.Sprite;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import flash.text.TextFieldAutoSize;
    import flash.filters.DropShadowFilter;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.text.model.TextKey;
    import kabam.rotmg.account.core.view.*;

    public class KabamAccountInfoView extends Sprite implements AccountInfoView {

        private static const FONT_SIZE:int = 18;

        private var accountText:TextFieldDisplayConcrete;
        private var userName:String = "";
        private var isRegistered:Boolean;

        public function KabamAccountInfoView(){
            this.makeAccountText();
        }

        private function makeAccountText():void{
            this.accountText = new TextFieldDisplayConcrete().setSize(FONT_SIZE).setColor(0xB3B3B3);
            this.accountText.setAutoSize(TextFieldAutoSize.CENTER);
            this.accountText.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4)];
            addChild(this.accountText);
        }

        public function setInfo(_arg1:String, _arg2:Boolean):void{
            this.userName = _arg1;
            this.isRegistered = _arg2;
            this.accountText.setStringBuilder(new LineBuilder().setParams(TextKey.KABAMACCOUNTINFOVIEW_ACCOUNTINFO, {userName:_arg1}));
        }


    }
}//package kabam.rotmg.account.kabam.view

