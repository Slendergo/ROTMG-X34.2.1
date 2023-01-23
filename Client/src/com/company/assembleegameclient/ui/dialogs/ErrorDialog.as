﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.dialogs.ErrorDialog

package com.company.assembleegameclient.ui.dialogs{
    import flash.display.Sprite;
    import flash.display.IGraphicsData;
    import com.company.util.GraphicsUtil;
    import org.osflash.signals.Signal;
    import flash.display.Shape;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import com.company.assembleegameclient.ui.DeprecatedTextButton;
    import com.company.assembleegameclient.util.StageProxy;
    import flash.display.GraphicsSolidFill;
    import flash.display.GraphicsStroke;
    import flash.display.GraphicsPath;
    import kabam.rotmg.ui.view.SignalWaiter;
    import flash.display.LineScaleMode;
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import org.osflash.signals.natives.NativeMappedSignal;
    import flash.text.TextFieldAutoSize;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import flash.filters.DropShadowFilter;
    import flash.events.MouseEvent;
    import kabam.rotmg.core.service.GoogleAnalytics;
    import kabam.rotmg.core.StaticInjectorContext;
    import flash.display.Graphics;
    import flash.events.Event;

    public class ErrorDialog extends Sprite {

        public static const GREY:int = 0xB3B3B3;
        protected static const WIDTH:int = 300;

        protected const graphicsData_:Vector.<IGraphicsData> = new <flash.display.IGraphicsData>[lineStyle_, backgroundFill_, path_, com.company.util.GraphicsUtil.END_FILL, com.company.util.GraphicsUtil.END_STROKE];

        public var ok:Signal;
        public var box_:Sprite;
        public var rect_:Shape;
        public var textText_:TextFieldDisplayConcrete;
        public var titleText_:TextFieldDisplayConcrete = null;
        public var button1_:DeprecatedTextButton = null;
        public var button2_:DeprecatedTextButton = null;
        public var analyticsPageName_:String = null;
        public var offsetX:Number = 0;
        public var offsetY:Number = 0;
        public var stageProxy:StageProxy;
        private var outlineFill_:GraphicsSolidFill;
        private var lineStyle_:GraphicsStroke;
        private var backgroundFill_:GraphicsSolidFill;
        protected var path_:GraphicsPath;
        protected var uiWaiter:SignalWaiter;

        public function ErrorDialog(_arg1:String){
            this.box_ = new Sprite();
            this.rect_ = new Shape();
            this.outlineFill_ = new GraphicsSolidFill(0xFFFFFF, 1);
            this.lineStyle_ = new GraphicsStroke(1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, this.outlineFill_);
            this.backgroundFill_ = new GraphicsSolidFill(0x363636, 1);
            this.path_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
            this.uiWaiter = new SignalWaiter();
            super();
            var _local2:String = ["An error has occured:", _arg1].join("\n");
            this.stageProxy = new StageProxy(this);
            this.analyticsPageName_ = "/error";
            this._makeUIAndAdd(_local2, "D'oh, this isn't good", "ErrorWindow.buttonOK", null);
            this.makeUIAndAdd();
            this.uiWaiter.complete.addOnce(this.onComplete);
            addChild(this.box_);
            this.ok = new NativeMappedSignal(this, Dialog.LEFT_BUTTON);
        }

        private function _makeUIAndAdd(_arg1:String, _arg2:String, _arg3:String, _arg4:String):void{
            this.initText(_arg1);
            this.addTextFieldDisplay(this.textText_);
            this.initNonNullTitleAndAdd(_arg2);
            this.makeNonNullButtons(_arg3, _arg4);
        }

        protected function makeUIAndAdd():void{
        }

        protected function initText(_arg1:String):void{
            this.textText_ = new TextFieldDisplayConcrete().setSize(14).setColor(GREY);
            this.textText_.setTextWidth((WIDTH - 40));
            this.textText_.x = 20;
            this.textText_.setMultiLine(true).setWordWrap(true).setAutoSize(TextFieldAutoSize.CENTER);
            this.textText_.setStringBuilder(new StaticStringBuilder(_arg1));
            this.textText_.mouseEnabled = true;
            this.textText_.filters = [new DropShadowFilter(0, 0, 0, 1, 6, 6, 1)];
        }

        private function addTextFieldDisplay(_arg1:TextFieldDisplayConcrete):void{
            this.box_.addChild(_arg1);
            this.uiWaiter.push(_arg1.textChanged);
        }

        private function initNonNullTitleAndAdd(_arg1:String):void{
            if (_arg1 != null){
                this.titleText_ = new TextFieldDisplayConcrete().setSize(18).setColor(5746018);
                this.titleText_.setTextWidth(WIDTH);
                this.titleText_.setBold(true);
                this.titleText_.setAutoSize(TextFieldAutoSize.CENTER);
                this.titleText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8, 1)];
                this.titleText_.setStringBuilder(new StaticStringBuilder(_arg1));
                this.addTextFieldDisplay(this.titleText_);
            };
        }

        private function makeNonNullButtons(_arg1:String, _arg2:String):void{
            if (_arg1 != null){
                this.button1_ = new DeprecatedTextButton(16, _arg1, 120);
                this.button1_.addEventListener(MouseEvent.CLICK, this.onButton1Click);
            };
            if (_arg2 != null){
                this.button2_ = new DeprecatedTextButton(16, _arg2, 120);
                this.button2_.addEventListener(MouseEvent.CLICK, this.onButton2Click);
            };
        }

        private function onComplete():void{
            this.draw();
            this.positionDialogAndTryAnalytics();
        }

        private function positionDialogAndTryAnalytics():void{
            this.box_.x = ((this.offsetX + (this.stageProxy.getStageWidth() / 2)) - (this.box_.width / 2));
            this.box_.y = ((this.offsetY + (this.stageProxy.getStageHeight() / 2)) - (this.getBoxHeight() / 2));
            if (this.analyticsPageName_ != null){
                this.tryAnalytics();
            };
        }

        private function tryAnalytics():void{
            var _local1:GoogleAnalytics;
            try {
                _local1 = StaticInjectorContext.getInjector().getInstance(GoogleAnalytics);
                if (_local1){
                    _local1.trackPageView(this.analyticsPageName_);
                };
            }
            catch(error:Error) {
            };
        }

        private function draw():void{
            this.drawTitleAndText();
            this.drawAdditionalUI();
            this.drawButtonsAndBackground();
        }

        protected function drawAdditionalUI():void{
        }

        protected function drawButtonsAndBackground():void{
            if (this.box_.contains(this.rect_)){
                this.box_.removeChild(this.rect_);
            };
            this.removeButtonsIfAlreadyAdded();
            this.addButtonsAndLayout();
            this.drawBackground();
            this.box_.addChildAt(this.rect_, 0);
            this.box_.filters = [new DropShadowFilter(0, 0, 0, 1, 16, 16, 1)];
        }

        private function drawBackground():void{
            GraphicsUtil.clearPath(this.path_);
            GraphicsUtil.drawCutEdgeRect(0, 0, WIDTH, (this.getBoxHeight() + 10), 4, [1, 1, 1, 1], this.path_);
            var _local1:Graphics = this.rect_.graphics;
            _local1.clear();
            _local1.drawGraphicsData(this.graphicsData_);
        }

        protected function getBoxHeight():Number{
            return (this.box_.height);
        }

        private function addButtonsAndLayout():void{
            var _local1:int;
            if (this.button1_ != null){
                _local1 = (this.box_.height + 16);
                this.box_.addChild(this.button1_);
                this.button1_.y = _local1;
                if (this.button2_ == null){
                    this.button1_.x = ((WIDTH / 2) - (this.button1_.width / 2));
                }
                else {
                    this.button1_.x = ((WIDTH / 4) - (this.button1_.width / 2));
                    this.box_.addChild(this.button2_);
                    this.button2_.x = (((3 * WIDTH) / 4) - (this.button2_.width / 2));
                    this.button2_.y = _local1;
                };
            };
        }

        private function removeButtonsIfAlreadyAdded():void{
            if (((this.button1_) && (this.box_.contains(this.button1_)))){
                this.box_.removeChild(this.button1_);
            };
            if (((this.button2_) && (this.box_.contains(this.button2_)))){
                this.box_.removeChild(this.button2_);
            };
        }

        private function drawTitleAndText():void{
            if (this.titleText_ != null){
                this.titleText_.y = 2;
                this.textText_.y = (this.titleText_.height + 8);
            }
            else {
                this.textText_.y = 4;
            };
        }

        private function onButton1Click(_arg1:MouseEvent):void{
            dispatchEvent(new Event(Dialog.LEFT_BUTTON));
        }

        private function onButton2Click(_arg1:Event):void{
            dispatchEvent(new Event(Dialog.RIGHT_BUTTON));
        }

        public function setBaseAlpha(_arg1:Number):void{
            this.rect_.alpha = (((_arg1 > 1)) ? 1 : (((_arg1 < 0)) ? 0 : _arg1));
        }


    }
}//package com.company.assembleegameclient.ui.dialogs

