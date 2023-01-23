﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.options.BaseOption

package com.company.assembleegameclient.ui.options{
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import flash.filters.DropShadowFilter;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import kabam.rotmg.text.view.stringBuilder.StringBuilder;

    public class BaseOption extends Option {

        public var paramName_:String;
        private var tooltipText_:String;
        protected var tooltip_:TextToolTip;
        protected var desc_:TextFieldDisplayConcrete;

        public function BaseOption(_arg1:String, _arg2:String, _arg3:String){
            this.paramName_ = _arg1;
            this.tooltipText_ = _arg3;
            this.desc_ = new TextFieldDisplayConcrete().setSize(18).setColor(0xB3B3B3);
            this.desc_.setStringBuilder(new LineBuilder().setParams(_arg2));
            this.desc_.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
            this.desc_.x = (KeyCodeBox.WIDTH + 24);
            this.desc_.mouseEnabled = true;
            this.desc_.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            this.desc_.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            addChild(this.desc_);
            this.tooltip_ = new TextToolTip(0x272727, 0x828282, null, this.tooltipText_, 150);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            textChanged = this.desc_.textChanged;
        }

        public function setDescription(_arg1:StringBuilder):void{
            this.desc_.setStringBuilder(_arg1);
        }

        public function setTooltipText(_arg1:StringBuilder):void{
            this.tooltip_.setText(_arg1);
        }

        public function refresh():void{
        }

        private function onMouseOver(_arg1:MouseEvent):void{
            parent.parent.addChild(this.tooltip_);
        }

        private function onRollOut(_arg1:MouseEvent):void{
            this.removeToolTip();
        }

        private function onRemovedFromStage(_arg1:Event):void{
            this.removeToolTip();
        }

        private function removeToolTip():void{
            if (((!((this.tooltip_ == null))) && (parent.parent.contains(this.tooltip_)))){
                parent.parent.removeChild(this.tooltip_);
            };
        }


    }
}//package com.company.assembleegameclient.ui.options

