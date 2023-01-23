﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.dropdown.DropDownItem

package com.company.assembleegameclient.ui.dropdown{
    import flash.display.Sprite;
    import com.company.ui.BaseSimpleText;
    import flash.filters.DropShadowFilter;
    import flash.events.MouseEvent;

    public class DropDownItem extends Sprite {

        public var w_:int;
        public var h_:int;
        private var nameText_:BaseSimpleText;

        public function DropDownItem(_arg1:String, _arg2:int, _arg3:int){
            this.w_ = _arg2;
            this.h_ = _arg3;
            this.nameText_ = new BaseSimpleText(13, 0xB3B3B3, false, 0, 0);
            this.nameText_.setBold(true);
            this.nameText_.text = _arg1;
            this.nameText_.updateMetrics();
            this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
            this.nameText_.x = ((this.w_ / 2) - (this.nameText_.width / 2));
            this.nameText_.y = ((this.h_ / 2) - (this.nameText_.height / 2));
            addChild(this.nameText_);
            this.drawBackground(0x363636);
            addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        }

        public function getValue():String{
            return (this.nameText_.text);
        }

        private function onMouseOver(_arg1:MouseEvent):void{
            this.drawBackground(0x565656);
        }

        private function onMouseOut(_arg1:MouseEvent):void{
            this.drawBackground(0x363636);
        }

        private function drawBackground(_arg1:uint):void{
            graphics.clear();
            graphics.lineStyle(1, 0xB3B3B3);
            graphics.beginFill(_arg1, 1);
            graphics.drawRect(0, 0, this.w_, this.h_);
            graphics.endFill();
            graphics.lineStyle();
        }


    }
}//package com.company.assembleegameclient.ui.dropdown

