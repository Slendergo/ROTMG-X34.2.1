// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.RankText

package com.company.assembleegameclient.ui{
    import flash.display.Sprite;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.ui.view.SignalWaiter;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.text.model.TextKey;
    import flash.filters.DropShadowFilter;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import com.company.assembleegameclient.util.FameUtil;

    public class RankText extends Sprite {

        public var background:Sprite = null;
        public var largeText_:Boolean;
        private var numStars_:int = -1;
        private var starBg_:int;
        private var prefix_:TextFieldDisplayConcrete = null;
        private var waiter:SignalWaiter;
        private var icon:Sprite;

        public function RankText(_arg1:int, _arg2:Boolean, _arg3:Boolean, _arg4:int=0){
            this.waiter = new SignalWaiter();
            super();
            this.largeText_ = _arg2;
            if (_arg3){
                this.prefix_ = this.makeText();
                this.prefix_.setStringBuilder(new LineBuilder().setParams(TextKey.RANK_TEXT_RANK));
                this.prefix_.filters = [new DropShadowFilter(0, 0, 0)];
                this.prefix_.textChanged.addOnce(this.position);
                addChild(this.prefix_);
            };
            mouseEnabled = false;
            mouseChildren = false;
            this.draw(_arg1, _arg4);
        }

        public function makeText():TextFieldDisplayConcrete{
            var _local1:int = ((this.largeText_) ? 18 : 16);
            var _local2:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
            _local2.setSize(_local1).setColor(0xB3B3B3);
            _local2.setBold(this.largeText_);
            return (_local2);
        }

        public function draw(_arg1:int, _arg2:int):void{
            var text:TextFieldDisplayConcrete;
            var onTextChanged:Function;
            var numStars:int = _arg1;
            var starBg:int = _arg2;
            onTextChanged = function ():void{
                icon.x = (text.width + 2);
                text.y = ((largeText_) ? ((icon.y + text.height) + 4) : (icon.y + text.height));
                var _local1:int = (icon.x + icon.width);
                background.graphics.clear();
                background.graphics.beginFill(0, 0.4);
                var _local2:Number = icon.height;
                var _local3:int = icon.y;
                background.graphics.drawRoundRect(-2, _local3, (_local1 + 6), _local2, 12, 12);
                background.graphics.endFill();
                position();
            };
            if ((((numStars == this.numStars_)) && ((starBg == this.starBg_)))){
                return;
            };
            this.numStars_ = numStars;
            this.starBg_ = (((starBg >= 0)) ? starBg : 0);
            if (((!((this.background == null))) && (contains(this.background)))){
                removeChild(this.background);
            };
            if (this.numStars_ < 0){
                return;
            };
            this.background = new Sprite();
            text = this.makeText();
            text.setVerticalAlign(TextFieldDisplayConcrete.BOTTOM);
            text.setStringBuilder(new StaticStringBuilder(this.numStars_.toString()));
            text.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
            this.background.addChild(text);
            this.icon = ((this.largeText_) ? FameUtil.numStarsToBigImage(this.numStars_, this.starBg_) : FameUtil.numStarsToImage(this.numStars_, this.starBg_));
            this.background.addChild(this.icon);
            text.textChanged.addOnce(onTextChanged);
            addChild(this.background);
            if (this.prefix_ != null){
                this.positionWhenTextIsReady();
            };
        }

        private function positionWhenTextIsReady():void{
            if (this.waiter.isEmpty()){
                this.position();
            }
            else {
                this.waiter.complete.addOnce(this.position);
            };
        }

        private function position():void{
            if (this.prefix_){
                this.background.x = this.prefix_.width;
                this.prefix_.y = (this.icon.y - 3);
                if (((!(this.largeText_)) && ((this.starBg_ > 0)))){
                    this.background.y = (this.background.y - 3);
                };
            };
        }


    }
}//package com.company.assembleegameclient.ui

