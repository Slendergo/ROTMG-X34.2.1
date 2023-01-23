﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.tutorial.TutorialMessage

package com.company.assembleegameclient.tutorial{
    import flash.display.Sprite;
    import flash.display.IGraphicsData;
    import com.company.util.GraphicsUtil;
    import flash.geom.Rectangle;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import com.company.assembleegameclient.ui.DeprecatedTextButton;
    import flash.display.GraphicsSolidFill;
    import flash.display.GraphicsStroke;
    import flash.display.GraphicsPath;
    import flash.display.LineScaleMode;
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.utils.getTimer;

    public class TutorialMessage extends Sprite {

        public static const BORDER:int = 8;

        private const graphicsData_:Vector.<IGraphicsData> = new <flash.display.IGraphicsData>[lineStyle_, fill_, path_, com.company.util.GraphicsUtil.END_FILL, com.company.util.GraphicsUtil.END_STROKE];

        private var tutorial_:Tutorial;
        private var rect_:Rectangle;
        private var messageText_:TextFieldDisplayConcrete;
        private var nextButton_:DeprecatedTextButton = null;
        private var startTime_:int;
        private var fill_:GraphicsSolidFill;
        private var lineStyle_:GraphicsStroke;
        private var path_:GraphicsPath;

        public function TutorialMessage(_arg1:Tutorial, _arg2:String, _arg3:Boolean, _arg4:Rectangle){
            this.fill_ = new GraphicsSolidFill(0x363636, 1);
            this.lineStyle_ = new GraphicsStroke(1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, new GraphicsSolidFill(0xFFFFFF));
            this.path_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
            super();
            this.tutorial_ = _arg1;
            this.rect_ = _arg4.clone();
            x = this.rect_.x;
            y = this.rect_.y;
            this.rect_.x = 0;
            this.rect_.y = 0;
            this.messageText_ = new TextFieldDisplayConcrete().setSize(15).setColor(0xFFFFFF).setTextWidth((this.rect_.width - (4 * BORDER)));
            this.messageText_.setStringBuilder(new LineBuilder().setParams(_arg2));
            this.messageText_.x = (2 * BORDER);
            this.messageText_.y = (2 * BORDER);
            if (_arg3){
                this.nextButton_ = new DeprecatedTextButton(18, "Next");
                this.nextButton_.addEventListener(MouseEvent.CLICK, this.onNextButton);
                this.nextButton_.x = ((this.rect_.width - this.nextButton_.width) - 20);
                this.nextButton_.y = ((this.rect_.height - this.nextButton_.height) - 10);
            };
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        private function drawRect():void{
            var _local1:Number = Math.min(1, (0.1 + ((0.9 * (getTimer() - this.startTime_)) / 200)));
            if (_local1 == 1){
                addChild(this.messageText_);
                if (this.nextButton_ != null){
                    addChild(this.nextButton_);
                };
                removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            };
            var _local2:Rectangle = this.rect_.clone();
            _local2.inflate(((-((1 - _local1)) * this.rect_.width) / 2), ((-((1 - _local1)) * this.rect_.height) / 2));
            GraphicsUtil.clearPath(this.path_);
            GraphicsUtil.drawCutEdgeRect(_local2.x, _local2.y, _local2.width, _local2.height, 4, [1, 1, 1, 1], this.path_);
            graphics.clear();
            graphics.drawGraphicsData(this.graphicsData_);
        }

        private function onAddedToStage(_arg1:Event):void{
            this.startTime_ = getTimer();
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }

        private function onRemovedFromStage(_arg1:Event):void{
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }

        private function onEnterFrame(_arg1:Event):void{
            this.drawRect();
        }

        private function onNextButton(_arg1:MouseEvent):void{
            this.tutorial_.doneAction(Tutorial.NEXT_ACTION);
        }


    }
}//package com.company.assembleegameclient.tutorial

