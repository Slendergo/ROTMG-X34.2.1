// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap

package io.decagames.rotmg.ui.sliceScaling{
    import flash.display.Bitmap;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Matrix;

    public class SliceScalingBitmap extends Bitmap {

        public static var SCALE_TYPE_NONE:String = "none";
        public static var SCALE_TYPE_3:String = "3grid";
        public static var SCALE_TYPE_9:String = "9grid";

        private var scaleGrid:Rectangle;
        private var currentWidth:int;
        private var currentHeight:int;
        private var bitmapDataToSlice:BitmapData;
        private var _scaleType:String;
        private var fillColor:uint;
        protected var margin:Point;
        private var fillColorAlpha:Number;
        private var _forceRenderInNextFrame:Boolean;
        private var _sourceBitmapName:String;

        public function SliceScalingBitmap(_arg1:BitmapData, _arg2:String, _arg3:Rectangle=null, _arg4:uint=0, _arg5:Number=1){
            this.margin = new Point();
            super();
            this.bitmapDataToSlice = _arg1;
            this.scaleGrid = _arg3;
            this.currentWidth = _arg1.width;
            this.currentHeight = _arg1.height;
            this._scaleType = _arg2;
            this.fillColor = _arg4;
            this.fillColorAlpha = _arg5;
            if (_arg2 != SCALE_TYPE_NONE){
                this.render();
            }
            else {
                this.bitmapData = _arg1;
            }
        }

        public function clone():SliceScalingBitmap{
            var _local1:SliceScalingBitmap = new SliceScalingBitmap(this.bitmapDataToSlice.clone(), this.scaleType, this.scaleGrid, this.fillColor, this.fillColorAlpha);
            _local1.sourceBitmapName = this._sourceBitmapName;
            return (_local1);
        }

        override public function set width(_arg1:Number):void{
            if (((!((_arg1 == this.currentWidth))) || (this._forceRenderInNextFrame))){
                this.currentWidth = _arg1;
                this.render();
            }
        }

        override public function set height(_arg1:Number):void{
            if (_arg1 != this.currentHeight){
                this.currentHeight = _arg1;
                this.render();
            }
        }

        override public function get width():Number{
            return (this.currentWidth);
        }

        override public function get height():Number{
            return (this.currentHeight);
        }

        protected function render():void{
            if (this._scaleType == SCALE_TYPE_NONE){
                return;
            }
            if (this.bitmapData){
                this.bitmapData.dispose();
            }
            if (this._scaleType == SCALE_TYPE_3){
                this.prepare3grid();
            }
            if (this._scaleType == SCALE_TYPE_9){
                this.prepare9grid();
            }
            if (this._forceRenderInNextFrame){
                this._forceRenderInNextFrame = false;
            }
        }

        private function prepare3grid():void{
            var _local1:int;
            var _local2:int;
            var _local3:int;
            var _local4:int;
            if (this.scaleGrid.y == 0){
                _local1 = ((this.currentWidth - this.bitmapDataToSlice.width) + this.scaleGrid.width);
                this.bitmapData = new BitmapData((this.currentWidth + this.margin.x), (this.currentHeight + this.margin.y), true, 0);
                this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, 0, this.scaleGrid.x, this.bitmapDataToSlice.height), new Point(this.margin.x, this.margin.y));
                _local2 = 0;
                while (_local2 < _local1) {
                    this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(this.scaleGrid.x, 0, this.scaleGrid.width, this.bitmapDataToSlice.height), new Point(((this.scaleGrid.x + _local2) + this.margin.x), this.margin.y));
                    _local2++;
                }
                this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle((this.scaleGrid.x + this.scaleGrid.width), 0, (this.bitmapDataToSlice.width - (this.scaleGrid.x + this.scaleGrid.width)), this.bitmapDataToSlice.height), new Point(((this.scaleGrid.x + _local1) + this.margin.x), this.margin.y));
            }
            else {
                _local3 = ((this.currentHeight - this.bitmapDataToSlice.height) + this.scaleGrid.height);
                this.bitmapData = new BitmapData((this.currentWidth + this.margin.x), (this.currentHeight + this.margin.y), true, 0);
                this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, 0, this.bitmapDataToSlice.width, this.scaleGrid.y), new Point(this.margin.x, this.margin.y));
                _local4 = 0;
                while (_local4 < _local3) {
                    this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, this.scaleGrid.y, this.scaleGrid.width, this.bitmapDataToSlice.height), new Point(this.margin.x, ((this.margin.y + this.scaleGrid.y) + _local4)));
                    _local4++;
                }
                this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, (this.scaleGrid.y + this.scaleGrid.height), this.bitmapDataToSlice.width, (this.bitmapDataToSlice.height - (this.scaleGrid.y + this.scaleGrid.height))), new Point(this.margin.x, ((this.margin.y + this.scaleGrid.y) + _local3)));
            }
        }

        private function prepare9grid():void{
            var _local10:int;
            var _local1:Rectangle = new Rectangle();
            var _local2:Rectangle = new Rectangle();
            var _local3:Matrix = new Matrix();
            var _local4:BitmapData = new BitmapData((this.currentWidth + this.margin.x), (this.currentHeight + this.margin.y), true, 0);
            var _local5:Array = [0, this.scaleGrid.top, this.scaleGrid.bottom, this.bitmapDataToSlice.height];
            var _local6:Array = [0, this.scaleGrid.left, this.scaleGrid.right, this.bitmapDataToSlice.width];
            var _local7:Array = [0, this.scaleGrid.top, (this.currentHeight - (this.bitmapDataToSlice.height - this.scaleGrid.bottom)), this.currentHeight];
            var _local8:Array = [0, this.scaleGrid.left, (this.currentWidth - (this.bitmapDataToSlice.width - this.scaleGrid.right)), this.currentWidth];
            var _local9:int;
            while (_local9 < 3) {
                _local10 = 0;
                while (_local10 < 3) {
                    _local1.setTo(_local6[_local9], _local5[_local10], (_local6[(_local9 + 1)] - _local6[_local9]), (_local5[(_local10 + 1)] - _local5[_local10]));
                    _local2.setTo(_local8[_local9], _local7[_local10], (_local8[(_local9 + 1)] - _local8[_local9]), (_local7[(_local10 + 1)] - _local7[_local10]));
                    _local3.identity();
                    _local3.a = (_local2.width / _local1.width);
                    _local3.d = (_local2.height / _local1.height);
                    _local3.tx = (_local2.x - (_local1.x * _local3.a));
                    _local3.ty = (_local2.y - (_local1.y * _local3.d));
                    _local4.draw(this.bitmapDataToSlice, _local3, null, null, _local2);
                    _local10++;
                }
                _local9++;
            }
            this.bitmapData = _local4;
        }

        public function addMargin(_arg1:int, _arg2:int):void{
            this.margin = new Point(_arg1, _arg2);
        }

        public function dispose():void{
            this.bitmapData.dispose();
            this.bitmapDataToSlice.dispose();
        }

        public function get scaleType():String{
            return (this._scaleType);
        }

        public function set scaleType(_arg1:String):void{
            this._scaleType = _arg1;
        }

        override public function set x(_arg1:Number):void{
            super.x = Math.round(_arg1);
        }

        override public function set y(_arg1:Number):void{
            super.y = Math.round(_arg1);
        }

        public function get forceRenderInNextFrame():Boolean{
            return (this._forceRenderInNextFrame);
        }

        public function set forceRenderInNextFrame(_arg1:Boolean):void{
            this._forceRenderInNextFrame = _arg1;
        }

        public function get marginX():int{
            return (this.margin.x);
        }

        public function get marginY():int{
            return (this.margin.y);
        }

        public function get sourceBitmapName():String{
            return (this._sourceBitmapName);
        }

        public function set sourceBitmapName(_arg1:String):void{
            this._sourceBitmapName = _arg1;
        }


    }
}//package io.decagames.rotmg.ui.sliceScaling

