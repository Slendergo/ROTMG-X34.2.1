// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.mapeditor.Chooser

package com.company.assembleegameclient.mapeditor{
    import flash.display.Sprite;
    import flash.display.IGraphicsData;
    import com.company.util.GraphicsUtil;
    import com.company.assembleegameclient.mapeditor.Element;
    import com.company.assembleegameclient.ui.Scrollbar;
    import flash.display.GraphicsSolidFill;
    import flash.display.GraphicsStroke;
    import flash.display.GraphicsPath;
    import flash.display.LineScaleMode;
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.events.MouseEvent;
    import flash.display.Shape;
    import flash.events.Event;
    import flash.utils.ByteArray;
    import flash.net.FileReference;
    import flash.display.BitmapData;
    import com.adobe.images.PNGEncoder;
    import com.company.assembleegameclient.mapeditor.*;

    class Chooser extends Sprite {

        public static const WIDTH:int = 136;
        public static const HEIGHT:int = 430;
        public static const SCROLLBAR_WIDTH:int = 20;

        private var graphicsData_:Vector.<IGraphicsData>;
        public var layer_:int;
        public var selected_:Element;
        protected var elementContainer_:Sprite;
        protected var scrollBar_:Scrollbar;
        private var elements_:Vector.<Element>;
        private var outlineFill_:GraphicsSolidFill;
        private var lineStyle_:GraphicsStroke;
        private var backgroundFill_:GraphicsSolidFill;
        private var path_:GraphicsPath;
        private var _hasBeenLoaded:Boolean;

        public function Chooser(_arg1:int){
            this.elements_ = new Vector.<Element>();
            this.outlineFill_ = new GraphicsSolidFill(0xFFFFFF, 1);
            this.lineStyle_ = new GraphicsStroke(1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, this.outlineFill_);
            this.backgroundFill_ = new GraphicsSolidFill(0x363636, 1);
            this.path_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
            this.graphicsData_ = new <flash.display.IGraphicsData>[lineStyle_, backgroundFill_, path_, com.company.util.GraphicsUtil.END_FILL, com.company.util.GraphicsUtil.END_STROKE];
            super();
            this.layer_ = _arg1;
            this.init();
        }

        public function selectedType():int{
            return (this.selected_.type_);
        }

        public function setSelectedType(_arg1:int):void{
            var _local2:Element;
            for each (_local2 in this.elements_) {
                if (_local2.type_ == _arg1){
                    this.setSelected(_local2);
                    return;
                };
            };
        }

        protected function addElement(_arg1:Element):void{
            var _local2:int = this.elements_.length;
            _arg1.x = ((((_local2 % 2))==0) ? 0 : (2 + Element.WIDTH));
            _arg1.y = ((int((_local2 / 2)) * Element.HEIGHT) + 6);
            this.elementContainer_.addChild(_arg1);
            if (_local2 == 0){
                this.setSelected(_arg1);
            };
            _arg1.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.elements_.push(_arg1);
        }

        protected function removeElements():void{
            this.elementContainer_.removeChildren();
            if (!this.elements_){
                this.elements_ = new Vector.<Element>();
            }
            else {
                this.cleanupElements();
            };
            this._hasBeenLoaded = false;
        }

        private function cleanupElements():void{
            var _local2:Element;
            var _local1:int = (this.elements_.length - 1);
            while (_local1 >= 0) {
                _local2 = this.elements_.pop();
                _local2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                _local1--;
            };
        }

        protected function setSelected(_arg1:Element):void{
            if (this.selected_ != null){
                this.selected_.setSelected(false);
            };
            this.selected_ = _arg1;
            this.selected_.setSelected(true);
        }

        private function init():void{
            this.drawBackground();
            this.elementContainer_ = new Sprite();
            this.elementContainer_.x = 4;
            this.elementContainer_.y = 6;
            addChild(this.elementContainer_);
            this.scrollBar_ = new Scrollbar(SCROLLBAR_WIDTH, (HEIGHT - 8), 0.1, this);
            this.scrollBar_.x = ((WIDTH - SCROLLBAR_WIDTH) - 6);
            this.scrollBar_.y = 4;
            var _local1:Shape = new Shape();
            _local1.graphics.beginFill(0);
            _local1.graphics.drawRect(0, 2, ((Chooser.WIDTH - SCROLLBAR_WIDTH) - 4), (Chooser.HEIGHT - 4));
            addChild(_local1);
            this.elementContainer_.mask = _local1;
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        private function downloadElement(_arg1:Element):void{
            var _local3:ByteArray;
            var _local4:FileReference;
            var _local2:BitmapData = _arg1.objectBitmap;
            if (_local2 != null){
                _local3 = PNGEncoder.encode(_arg1.objectBitmap);
                _local4 = new FileReference();
                _local4.save(_local3, (_arg1.type_ + ".png"));
            };
        }

        private function drawBackground():void{
            GraphicsUtil.clearPath(this.path_);
            GraphicsUtil.drawCutEdgeRect(0, 0, WIDTH, HEIGHT, 4, [1, 1, 1, 1], this.path_);
            graphics.drawGraphicsData(this.graphicsData_);
        }

        protected function onMouseDown(_arg1:MouseEvent):void{
            var _local2:Element = (_arg1.currentTarget as Element);
            if (_local2.downloadOnly){
                this.downloadElement(_local2);
            }
            else {
                this.setSelected(_local2);
            };
        }

        protected function onScrollBarChange(_arg1:Event):void{
            this.elementContainer_.y = (6 - (this.scrollBar_.pos() * ((this.elementContainer_.height + 12) - HEIGHT)));
        }

        protected function onAddedToStage(_arg1:Event):void{
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.scrollBar_.addEventListener(Event.CHANGE, this.onScrollBarChange);
            this.scrollBar_.setIndicatorSize(HEIGHT, this.elementContainer_.height);
            addChild(this.scrollBar_);
        }

        protected function onRemovedFromStage(_arg1:Event):void{
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        public function get hasBeenLoaded():Boolean{
            return (this._hasBeenLoaded);
        }

        public function set hasBeenLoaded(_arg1:Boolean):void{
            this._hasBeenLoaded = _arg1;
        }


    }
}//package com.company.assembleegameclient.mapeditor

