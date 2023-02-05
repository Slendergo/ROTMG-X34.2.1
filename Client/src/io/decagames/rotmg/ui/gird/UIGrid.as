// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.gird.UIGrid

package io.decagames.rotmg.ui.gird{
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.scroll.UIScrollbar;
    import flash.events.Event;
    import flash.display.DisplayObject;
    import io.decagames.rotmg.ui.texture.TextureParser;

    public class UIGrid extends Sprite {

        private var elements:Vector.<UIGridElement>;
        private var decors:Vector.<SliceScalingBitmap>;
        private var gridMargin:int;
        private var gridWidth:int;
        private var numberOfColumns:int;
        private var scrollHeight:int;
        private var scroll:UIScrollbar;
        private var gridContent:Sprite;
        private var gridMask:Sprite;
        private var _centerLastRow:Boolean;
        private var lastRenderedItemsNumber:int = 0;
        private var elementWidth:int;
        private var _decorBitmap:String = "";

        public function UIGrid(_arg1:int, _arg2:int, _arg3:int, _arg4:int=-1, _arg5:int=0, _arg6:DisplayObject=null){
            this.elements = new Vector.<UIGridElement>();
            this.decors = new Vector.<SliceScalingBitmap>();
            this.gridMargin = _arg3;
            this.gridWidth = _arg1;
            this.gridContent = new Sprite();
            this.addChild(this.gridContent);
            this.scrollHeight = _arg4;
            if (_arg4 > 0){
                this.scroll = new UIScrollbar(_arg4);
                this.scroll.x = (_arg1 + _arg5);
                addChild(this.scroll);
                this.scroll.content = this.gridContent;
                this.scroll.scrollObject = _arg6;
                this.gridMask = new Sprite();
            }
            this.numberOfColumns = _arg2;
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedHandler);
        }

        override public function set width(_arg1:Number):void{
            this.gridWidth = _arg1;
            this.render();
        }

        public function get numberOfElements():int{
            return (this.elements.length);
        }

        private function onAddedHandler(_arg1:Event):void{
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedHandler);
            this.addEventListener(Event.ENTER_FRAME, this.onUpdate);
            this.render();
        }

        public function addGridElement(_arg1:UIGridElement):void{
            if (this.elements){
                this.elements.push(_arg1);
                this.gridContent.addChild(_arg1);
                if (this.stage){
                    this.render();
                }
            }
        }

        private function addDecorToRow(_arg1:int, _arg2:int, _arg3:int):void{
            var _local5:SliceScalingBitmap;
            _arg3--;
            if (_arg3 == 0){
                _arg3 = 1;
            }
            var _local4:int;
            while (_local4 < _arg3) {
                _local5 = TextureParser.instance.getSliceScalingBitmap("UI", this._decorBitmap);
                _local5.x = Math.round((((_local4 * (this.gridMargin / 2)) + ((_local4 + 1) * (this.elementWidth + (this.gridMargin / 2)))) - (_local5.width / 2)));
                _local5.y = Math.round((((_arg1 + _arg2) - (_local5.height / 2)) + (this.gridMargin / 2)));
                this.gridContent.addChild(_local5);
                this.decors.push(_local5);
                _local4++;
            }
        }

        public function clearGrid():void{
            var _local1:UIGridElement;
            var _local2:SliceScalingBitmap;
            for each (_local1 in this.elements) {
                this.gridContent.removeChild(_local1);
                _local1.dispose();
            }
            for each (_local2 in this.decors) {
                this.gridContent.removeChild(_local2);
                _local2.dispose();
            }
            if (this.elements){
                this.elements.length = 0;
            }
            if (this.decors){
                this.decors.length = 0;
            }
            this.lastRenderedItemsNumber = 0;
        }

        public function render():void{
            var _local8:UIGridElement;
            var _local9:int;
            if (this.lastRenderedItemsNumber == this.elements.length){
                return;
            }
            this.elementWidth = ((this.gridWidth - ((this.numberOfColumns - 1) * this.gridMargin)) / this.numberOfColumns);
            var _local1:int = 1;
            var _local2:int;
            var _local3:int;
            var _local4:int;
            var _local5:int = Math.ceil((this.elements.length / this.numberOfColumns));
            var _local6:int = 1;
            var _local7:int;
            for each (_local8 in this.elements) {
                _local8.resize(this.elementWidth);
                if (_local8.height > _local4){
                    _local4 = _local8.height;
                }
                _local8.x = _local2;
                _local8.y = _local3;
                _local1++;
                if (_local1 > this.numberOfColumns){
                    if (this._decorBitmap != ""){
                        _local7 = _local6;
                        this.addDecorToRow(_local3, _local4, (_local1 - 1));
                    }
                    _local6++;
                    _local2 = 0;
                    if ((((_local6 == _local5)) && (this._centerLastRow))){
                        _local9 = ((_local6 * this.numberOfColumns) - this.elements.length);
                        _local2 = Math.round((((_local9 * this.elementWidth) + ((_local9 - 1) * this.gridMargin)) / 2));
                    }
                    _local3 = (_local3 + (_local4 + this.gridMargin));
                    _local4 = 0;
                    _local1 = 1;
                }
                else {
                    _local2 = (_local2 + (this.elementWidth + this.gridMargin));
                }
            }
            if (((!((this._decorBitmap == ""))) && (!((_local7 == _local6))))){
                this.addDecorToRow(_local3, _local4, (_local1 - 1));
            }
            if (this.scrollHeight != -1){
                this.gridMask.graphics.clear();
                this.gridMask.graphics.beginFill(0xFF0000);
                this.gridMask.graphics.drawRect(0, 0, this.gridWidth, this.scrollHeight);
                this.gridContent.mask = this.gridMask;
                addChild(this.gridMask);
            }
            this.lastRenderedItemsNumber = this.elements.length;
        }

        public function dispose():void{
            var _local1:UIGridElement;
            var _local2:SliceScalingBitmap;
            this.removeEventListener(Event.ENTER_FRAME, this.onUpdate);
            for each (_local1 in this.elements) {
                _local1.dispose();
            }
            for each (_local2 in this.decors) {
                _local2.dispose();
            }
            this.elements = null;
        }

        private function onUpdate(_arg1:Event):void{
            var _local2:UIGridElement;
            for each (_local2 in this.elements) {
                _local2.update();
            }
        }

        public function get centerLastRow():Boolean{
            return (this._centerLastRow);
        }

        public function set centerLastRow(_arg1:Boolean):void{
            this._centerLastRow = _arg1;
        }

        public function get decorBitmap():String{
            return (this._decorBitmap);
        }

        public function set decorBitmap(_arg1:String):void{
            this._decorBitmap = _arg1;
        }


    }
}//package io.decagames.rotmg.ui.gird

