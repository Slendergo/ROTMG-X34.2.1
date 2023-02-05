// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.texture.TextureParser

package io.decagames.rotmg.ui.texture{
    import flash.utils.Dictionary;
    import kabam.lib.json.JsonParser;
    import kabam.rotmg.core.StaticInjectorContext;
    import io.decagames.rotmg.ui.assets.UIAssets;
    import flash.display.Bitmap;
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    import flash.display.BitmapData;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;

    public class TextureParser {

        private static var _instance:TextureParser;

        private var textures:Dictionary;
        private var json:JsonParser;

        public function TextureParser(){
            this.textures = new Dictionary();
            this.json = StaticInjectorContext.getInjector().getInstance(JsonParser);
            this.registerTexture(new UIAssets.UI(), new UIAssets.UI_CONFIG(), new UIAssets.UI_SLICE_CONFIG(), "UI");
        }

        public static function get instance():TextureParser{
            if (_instance == null){
                _instance = new (TextureParser)();
            }
            return (_instance);
        }


        public function registerTexture(_arg1:Bitmap, _arg2:String, _arg3:String, _arg4:String):void{
            this.textures[_arg4] = {
                texture:_arg1,
                configuration:this.json.parse(_arg2),
                sliceRectangles:this.json.parse(_arg3)
            }
        }

        private function getConfiguration(_arg1:String, _arg2:String):Object{
            if (!this.textures[_arg1]){
                throw (new Error(("Can't find set name " + _arg1)));
            }
            if (!this.textures[_arg1].configuration.frames[(_arg2 + ".png")]){
                throw (new Error(("Can't find config for " + _arg2)));
            }
            return (this.textures[_arg1].configuration.frames[(_arg2 + ".png")]);
        }

        private function getBitmapUsingConfig(_arg1:String, _arg2:Object):Bitmap{
            var _local3:Bitmap = this.textures[_arg1].texture;
            var _local4:ByteArray = _local3.bitmapData.getPixels(new Rectangle(_arg2.frame.x, _arg2.frame.y, _arg2.frame.w, _arg2.frame.h));
            _local4.position = 0;
            var _local5:BitmapData = new BitmapData(_arg2.frame.w, _arg2.frame.h);
            _local5.setPixels(new Rectangle(0, 0, _arg2.frame.w, _arg2.frame.h), _local4);
            return (new Bitmap(_local5));
        }

        public function getTexture(_arg1:String, _arg2:String):Bitmap{
            var _local3:Object = this.getConfiguration(_arg1, _arg2);
            return (this.getBitmapUsingConfig(_arg1, _local3));
        }

        public function getSliceScalingBitmap(_arg1:String, _arg2:String, _arg3:int=0):SliceScalingBitmap{
            var _local4:Bitmap = this.getTexture(_arg1, _arg2);
            var _local5:Object = this.textures[_arg1].sliceRectangles.slices[(_arg2 + ".png")];
            var _local6:Rectangle;
            var _local7:String = SliceScalingBitmap.SCALE_TYPE_NONE;
            if (_local5){
                _local6 = new Rectangle(_local5.rectangle.x, _local5.rectangle.y, _local5.rectangle.w, _local5.rectangle.h);
                _local7 = _local5.type;
            }
            var _local8:SliceScalingBitmap = new SliceScalingBitmap(_local4.bitmapData, _local7, _local6);
            _local8.sourceBitmapName = _arg2;
            if (_arg3 != 0){
                _local8.width = _arg3;
            }
            return (_local8);
        }


    }
}//package io.decagames.rotmg.ui.texture

