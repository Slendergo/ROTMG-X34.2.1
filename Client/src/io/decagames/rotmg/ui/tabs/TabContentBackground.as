// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.tabs.TabContentBackground

package io.decagames.rotmg.ui.tabs{
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import flash.geom.Point;

    public class TabContentBackground extends SliceScalingBitmap {

        private var decorBitmapData:BitmapData;
        private var decorSliceRectangle:Rectangle;

        public function TabContentBackground(){
            super(TextureParser.instance.getTexture("UI", "tab_cointainer_background").bitmapData, SliceScalingBitmap.SCALE_TYPE_9, new Rectangle(15, 15, 1, 1));
        }

        override public function dispose():void{
            this.decorBitmapData.dispose();
            super.dispose();
        }

        public function addDecor(_arg1:int, _arg2:int, _arg3:int, _arg4:int):void{
            this.render();
            if (_arg3 == 0){
                this.decorBitmapData = TextureParser.instance.getTexture("UI", "tab_open_decor_left").bitmapData;
                this.decorSliceRectangle = new Rectangle(21, 0, 1, 14);
                _arg1 = (_arg1 - 7);
                _arg2 = (_arg2 - 4);
            }
            else {
                if (_arg3 == (_arg4 - 1)){
                    this.decorBitmapData = TextureParser.instance.getTexture("UI", "tab_open_decor_right").bitmapData;
                    this.decorSliceRectangle = new Rectangle(18, 0, 1, 14);
                }
                else {
                    this.decorBitmapData = TextureParser.instance.getTexture("UI", "tab_open_decor_center").bitmapData;
                    this.decorSliceRectangle = new Rectangle(18, 0, 1, 14);
                };
            };
            this.bitmapData.copyPixels(this.decorBitmapData, new Rectangle(0, 0, this.decorSliceRectangle.x, this.decorBitmapData.height), new Point(_arg1, 0));
            var _local5:int = _arg1;
            while (_local5 < _arg2) {
                this.bitmapData.copyPixels(this.decorBitmapData, new Rectangle(this.decorSliceRectangle.x, 0, this.decorSliceRectangle.width, this.decorBitmapData.height), new Point((this.decorSliceRectangle.x + _local5), 0));
                _local5++;
            };
            this.bitmapData.copyPixels(this.decorBitmapData, new Rectangle((this.decorSliceRectangle.x + this.decorSliceRectangle.width), 0, (this.decorBitmapData.width - (this.decorSliceRectangle.x + this.decorSliceRectangle.width)), this.decorBitmapData.height), new Point(_arg2, 0));
        }


    }
}//package io.decagames.rotmg.ui.tabs

