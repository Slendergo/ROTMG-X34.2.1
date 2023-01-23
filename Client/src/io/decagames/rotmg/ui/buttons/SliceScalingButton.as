// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.buttons.SliceScalingButton

package io.decagames.rotmg.ui.buttons{
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.utils.Dictionary;
    import flash.geom.Point;
    import io.decagames.rotmg.utils.colors.Tint;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    import io.decagames.rotmg.utils.colors.GreyScale;
    import flash.events.Event;
    import io.decagames.rotmg.ui.texture.TextureParser;

    public class SliceScalingButton extends BaseButton {

        private var staticWidth:Boolean;
        private var _bitmapWidth:int;
        private var disableBitmap:SliceScalingBitmap;
        private var rollOverBitmap:SliceScalingBitmap;
        private var _label:UILabel;
        private var stateFactories:Dictionary;
        private var _bitmap:SliceScalingBitmap;
        private var _autoDispose:Boolean;
        protected var _interactionEffects:Boolean = true;
        protected var labelMargin:Point;

        public function SliceScalingButton(_arg1:SliceScalingBitmap, _arg2:SliceScalingBitmap=null, _arg3:SliceScalingBitmap=null){
            this.labelMargin = new Point();
            this._bitmap = _arg1;
            addChild(this._bitmap);
            this.rollOverBitmap = _arg3;
            this.disableBitmap = _arg2;
            this._label = new UILabel();
            this.stateFactories = new Dictionary();
            super();
        }

        public function setLabelMargin(_arg1:int, _arg2:int):void{
            this.labelMargin.x = _arg1;
            this.labelMargin.y = _arg2;
        }

        override protected function onRollOverHandler(_arg1:MouseEvent):void{
            if (((this._interactionEffects) && (!(_disabled)))){
                Tint.add(this._bitmap, 0xFFFF, 0.1);
                this._bitmap.scaleX = 1;
                this._bitmap.scaleY = 1;
                this._bitmap.x = 0;
                this._bitmap.y = 0;
            };
            super.onRollOverHandler(_arg1);
        }

        override protected function onMouseDownHandler(_arg1:MouseEvent):void{
            if (((this._interactionEffects) && (!(_disabled)))){
                this._bitmap.scaleX = 0.9;
                this._bitmap.scaleY = 0.9;
                this._bitmap.x = ((this._bitmap.width * 0.1) / 2);
                this._bitmap.y = ((this._bitmap.height * 0.1) / 2);
            };
            super.onMouseDownHandler(_arg1);
        }

        override protected function onClickHandler(_arg1:MouseEvent):void{
            if (this._interactionEffects){
                this._bitmap.scaleX = 1;
                this._bitmap.scaleY = 1;
                this._bitmap.x = 0;
                this._bitmap.y = 0;
            };
            super.onClickHandler(_arg1);
        }

        override protected function onRollOutHandler(_arg1:MouseEvent):void{
            if (this._interactionEffects){
                this._bitmap.transform.colorTransform = new ColorTransform();
                this._bitmap.scaleX = 1;
                this._bitmap.scaleY = 1;
                this._bitmap.x = 0;
                this._bitmap.y = 0;
            };
            super.onRollOutHandler(_arg1);
        }

        override public function set disabled(_arg1:Boolean):void{
            super.disabled = _arg1;
            var _local2:Function = this.stateFactories[ButtonStates.DISABLED];
            if (_local2 != null){
                (_local2(this._label));
            };
            if (this._interactionEffects){
                if (_arg1){
                    GreyScale.setGreyScale(this._bitmap.bitmapData);
                }
                else {
                    this.changeBitmap(this._bitmap.sourceBitmapName, new Point(this._bitmap.marginX, this._bitmap.marginY));
                };
            };
            this.render();
        }

        public function setLabel(_arg1:String, _arg2:Function=null, _arg3:String="idle"):void{
            if (_arg3 == ButtonStates.IDLE){
                if (_arg2 != null){
                    (_arg2(this._label));
                };
                this._label.text = _arg1;
                addChild(this._label);
                this.render();
            };
            this.stateFactories[_arg3] = _arg2;
        }

        override protected function onAddedToStage(_arg1:Event):void{
            super.onAddedToStage(_arg1);
            this.render();
        }

        override public function set width(_arg1:Number):void{
            _arg1 = Math.round(_arg1);
            this.staticWidth = true;
            this._bitmapWidth = _arg1;
            this.render();
        }

        public function render():void{
            if (this.staticWidth){
                this._bitmap.width = this._bitmapWidth;
            };
            this._label.x = ((((this._bitmapWidth - this._label.textWidth) / 2) + this._bitmap.marginX) + this.labelMargin.x);
            this._label.y = ((((this._bitmap.height - this._label.textHeight) / 2) + this._bitmap.marginY) + this.labelMargin.y);
        }

        override public function dispose():void{
            this._bitmap.dispose();
            if (this.disableBitmap){
                this.disableBitmap.dispose();
            };
            if (this.rollOverBitmap){
                this.rollOverBitmap.dispose();
            };
            super.dispose();
        }

        public function changeBitmap(_arg1:String, _arg2:Point=null):void{
            removeChild(this._bitmap);
            this._bitmap.dispose();
            this._bitmap = TextureParser.instance.getSliceScalingBitmap("UI", _arg1);
            if (_arg2 != null){
                this._bitmap.addMargin(_arg2.x, _arg2.y);
            };
            addChildAt(this._bitmap, 0);
            this._bitmap.forceRenderInNextFrame = true;
            this.render();
        }

        public function get label():UILabel{
            return (this._label);
        }

        public function get autoDispose():Boolean{
            return (this._autoDispose);
        }

        public function set autoDispose(_arg1:Boolean):void{
            this._autoDispose = _arg1;
        }

        public function get interactionEffects():Boolean{
            return (this._interactionEffects);
        }

        public function set interactionEffects(_arg1:Boolean):void{
            this._interactionEffects = _arg1;
        }

        public function get bitmapWidth():int{
            return (this._bitmapWidth);
        }

        public function get bitmap():SliceScalingBitmap{
            return (this._bitmap);
        }


    }
}//package io.decagames.rotmg.ui.buttons

