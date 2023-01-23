// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.social.widgets.BaseInfoItem

package io.decagames.rotmg.social.widgets{
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;

    public class BaseInfoItem extends Sprite {

        protected var _width:int;
        protected var _height:int;

        public function BaseInfoItem(_arg1:int, _arg2:int){
            this._width = _arg1;
            this._height = _arg2;
            this.intit();
        }

        private function intit():void{
            this.createBackground();
        }

        private function createBackground():void{
            var _local1:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "listitem_content_background");
            _local1.height = this._height;
            _local1.width = this._width;
            addChild(_local1);
        }


    }
}//package io.decagames.rotmg.social.widgets

