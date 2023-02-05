﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.board.EditBoard

package com.company.assembleegameclient.ui.board{
    import flash.display.Sprite;
    import flash.display.IGraphicsData;
    import com.company.util.GraphicsUtil;
    import com.company.ui.BaseSimpleText;
    import com.company.assembleegameclient.ui.Scrollbar;
    import com.company.assembleegameclient.ui.DeprecatedTextButton;
    import flash.display.GraphicsSolidFill;
    import flash.display.GraphicsStroke;
    import flash.display.GraphicsPath;
    import flash.display.LineScaleMode;
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.display.Shape;
    import flash.display.Graphics;
    import flash.events.Event;
    import kabam.rotmg.text.model.TextKey;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.ui.board.*;

    class EditBoard extends Sprite {

        public static const TEXT_WIDTH:int = 400;
        public static const TEXT_HEIGHT:int = 400;

        private var graphicsData_:Vector.<IGraphicsData>;
        private var text_:String;
        public var w_:int;
        public var h_:int;
        private var boardText_:BaseSimpleText;
        private var mainSprite_:Sprite;
        private var scrollBar_:Scrollbar;
        private var cancelButton_:DeprecatedTextButton;
        private var saveButton_:DeprecatedTextButton;
        private var backgroundFill_:GraphicsSolidFill;
        private var outlineFill_:GraphicsSolidFill;
        private var lineStyle_:GraphicsStroke;
        private var path_:GraphicsPath;

        public function EditBoard(_arg1:String){
            this.backgroundFill_ = new GraphicsSolidFill(0x333333, 1);
            this.outlineFill_ = new GraphicsSolidFill(0xFFFFFF, 1);
            this.lineStyle_ = new GraphicsStroke(2, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, this.outlineFill_);
            this.path_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
            this.graphicsData_ = new <flash.display.IGraphicsData>[lineStyle_, backgroundFill_, path_, com.company.util.GraphicsUtil.END_FILL, com.company.util.GraphicsUtil.END_STROKE];
            super();
            this.text_ = _arg1;
            this.mainSprite_ = new Sprite();
            var _local2:Shape = new Shape();
            var _local3:Graphics = _local2.graphics;
            _local3.beginFill(0);
            _local3.drawRect(0, 0, TEXT_WIDTH, TEXT_HEIGHT);
            _local3.endFill();
            this.mainSprite_.addChild(_local2);
            this.mainSprite_.mask = _local2;
            addChild(this.mainSprite_);
            this.boardText_ = new BaseSimpleText(16, 0xB3B3B3, true, TEXT_WIDTH, TEXT_HEIGHT);
            this.boardText_.border = false;
            this.boardText_.mouseEnabled = true;
            this.boardText_.multiline = true;
            this.boardText_.wordWrap = true;
            this.boardText_.embedFonts = true;
            this.boardText_.text = _arg1;
            this.boardText_.useTextDimensions();
            this.boardText_.addEventListener(Event.CHANGE, this.onTextChange);
            this.boardText_.addEventListener(Event.SCROLL, this.onTextChange);
            this.mainSprite_.addChild(this.boardText_);
            this.scrollBar_ = new Scrollbar(16, (TEXT_HEIGHT - 4));
            this.scrollBar_.x = (TEXT_WIDTH + 6);
            this.scrollBar_.y = 0;
            this.scrollBar_.setIndicatorSize(400, this.boardText_.height);
            this.scrollBar_.addEventListener(Event.CHANGE, this.onScrollBarChange);
            addChild(this.scrollBar_);
            this.w_ = (TEXT_WIDTH + 26);
            this.cancelButton_ = new DeprecatedTextButton(14, TextKey.FRAME_CANCEL, 120);
            this.cancelButton_.x = 4;
            this.cancelButton_.y = (TEXT_HEIGHT + 4);
            this.cancelButton_.addEventListener(MouseEvent.CLICK, this.onCancel);
            addChild(this.cancelButton_);
            this.saveButton_ = new DeprecatedTextButton(14, TextKey.EDIT_GUILD_BOARD_SAVE, 120);
            this.saveButton_.x = (this.w_ - 124);
            this.saveButton_.y = (TEXT_HEIGHT + 4);
            this.saveButton_.addEventListener(MouseEvent.CLICK, this.onSave);
            this.saveButton_.textChanged.add(this.layoutBackground);
            addChild(this.saveButton_);
        }

        private function layoutBackground():void{
            this.h_ = ((TEXT_HEIGHT + this.saveButton_.height) + 8);
            x = ((800 / 2) - (this.w_ / 2));
            y = ((600 / 2) - (this.h_ / 2));
            graphics.clear();
            GraphicsUtil.clearPath(this.path_);
            GraphicsUtil.drawCutEdgeRect(-6, -6, (this.w_ + 12), (this.h_ + 12), 4, [1, 1, 1, 1], this.path_);
            graphics.drawGraphicsData(this.graphicsData_);
            this.scrollBar_.setIndicatorSize(TEXT_HEIGHT, this.boardText_.textHeight, false);
        }

        public function getText():String{
            return (this.boardText_.text);
        }

        private function onScrollBarChange(_arg1:Event):void{
            this.boardText_.scrollV = (1 + (this.scrollBar_.pos() * this.boardText_.maxScrollV));
        }

        private function onCancel(_arg1:Event):void{
            dispatchEvent(new Event(Event.CANCEL));
        }

        private function onSave(_arg1:Event):void{
            dispatchEvent(new Event(Event.COMPLETE));
        }

        private function onTextChange(_arg1:Event):void{
            if (this.scrollBar_ == null){
                return;
            }
            this.scrollBar_.setIndicatorSize(TEXT_HEIGHT, this.boardText_.textHeight, false);
            if (this.boardText_.maxScrollV == 1){
                this.scrollBar_.setPos(0);
            }
            else {
                this.scrollBar_.setPos(((this.boardText_.scrollV - 1) / (this.boardText_.maxScrollV - 1)));
            }
        }


    }
}//package com.company.assembleegameclient.ui.board

