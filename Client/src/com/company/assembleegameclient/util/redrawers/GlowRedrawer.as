// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.util.redrawers.GlowRedrawer

package com.company.assembleegameclient.util.redrawers{
    import flash.filters.GlowFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.geom.Matrix;
    import flash.display.Shape;
    import flash.utils.Dictionary;
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.display.Bitmap;
    import com.company.assembleegameclient.util.TextureRedrawer;
    import com.company.util.PointUtil;
    import com.company.assembleegameclient.parameters.Parameters;
    import flash.display.GradientType;

    public class GlowRedrawer {

        private static const GRADIENT_MAX_SUB:uint = 0x282828;
        private static const GLOW_FILTER:GlowFilter = new GlowFilter(0, 0.3, 12, 12, 2, BitmapFilterQuality.LOW, false, false);
        private static const GLOW_FILTER_ALT:GlowFilter = new GlowFilter(0, 0.5, 16, 16, 3, BitmapFilterQuality.LOW, false, false);
        private static const GLOW_FILTER_SUPPORT:GlowFilter = new GlowFilter(0, 0.3, 12, 12, 3, BitmapFilterQuality.LOW, false, false);
        private static const GLOW_FILTER_SUPPORT_DARK:GlowFilter = new GlowFilter(0, 0.4, 6, 6, 2, BitmapFilterQuality.LOW, false, false);
        private static const GLOW_FILTER_SUPPORT_OUTLINE:GlowFilter = new GlowFilter(0, 1, 2, 2, 0xFF, BitmapFilterQuality.LOW, false, false);
        private static const GLOW_FILTER_SUPPORT_ALT:GlowFilter = new GlowFilter(0, 0.3, 12, 12, 4, BitmapFilterQuality.LOW, false, false);
        private static const GLOW_FILTER_SUPPORT_DARK_ALT:GlowFilter = new GlowFilter(0, 0.4, 6, 6, 2, BitmapFilterQuality.LOW, false, false);
        private static const GLOW_FILTER_SUPPORT_OUTLINE_ALT:GlowFilter = new GlowFilter(0, 1, 2, 2, 0xFF, BitmapFilterQuality.LOW, false, false);

        private static var tempMatrix_:Matrix = new Matrix();
        private static var gradient_:Shape = getGradient();
        private static var glowHashes:Dictionary = new Dictionary();


        public static function outlineGlow(_arg1:BitmapData, _arg2:uint, _arg3:Number=1.4, _arg4:Boolean=false, _arg5:int=0, _arg6:Boolean=false):BitmapData{
            var _local7:String = getHash(_arg2, _arg3, _arg5);
            if (((_arg4) && (isCached(_arg1, _local7)))){
                return (glowHashes[_arg1][_local7]);
            };
            var _local8:BitmapData = _arg1.clone();
            tempMatrix_.identity();
            tempMatrix_.scale((_arg1.width / 0x0100), (_arg1.height / 0x0100));
            _local8.draw(gradient_, tempMatrix_, null, BlendMode.SUBTRACT);
            var _local9:Bitmap = new Bitmap(_arg1);
            _local8.draw(_local9, null, null, BlendMode.ALPHA);
            TextureRedrawer.OUTLINE_FILTER.blurX = _arg3;
            TextureRedrawer.OUTLINE_FILTER.blurY = _arg3;
            TextureRedrawer.OUTLINE_FILTER.color = _arg5;
            _local8.applyFilter(_local8, _local8.rect, PointUtil.ORIGIN, TextureRedrawer.OUTLINE_FILTER);
            if (_arg2 != 0xFFFFFFFF){
                if (((Parameters.isGpuRender()) && (!((_arg2 == 0))))){
                    if (!_arg6){
                        GLOW_FILTER_ALT.color = _arg2;
                        _local8.applyFilter(_local8, _local8.rect, PointUtil.ORIGIN, GLOW_FILTER_ALT);
                    }
                    else {
                        GLOW_FILTER_SUPPORT_ALT.color = _arg2;
                        GLOW_FILTER_SUPPORT_DARK_ALT.color = (_arg2 - 0x246600);
                        GLOW_FILTER_SUPPORT_OUTLINE_ALT.color = _arg2;
                        _local8.applyFilter(_local8, _local8.rect, PointUtil.ORIGIN, GLOW_FILTER_SUPPORT_OUTLINE_ALT);
                        _local8.applyFilter(_local8, _local8.rect, PointUtil.ORIGIN, GLOW_FILTER_SUPPORT_DARK_ALT);
                        _local8.applyFilter(_local8, _local8.rect, PointUtil.ORIGIN, GLOW_FILTER_SUPPORT_ALT);
                    };
                }
                else {
                    if (!_arg6){
                        GLOW_FILTER.color = _arg2;
                        _local8.applyFilter(_local8, _local8.rect, PointUtil.ORIGIN, GLOW_FILTER);
                    }
                    else {
                        GLOW_FILTER_SUPPORT.color = _arg2;
                        GLOW_FILTER_SUPPORT_DARK.color = (_arg2 - 0x246600);
                        GLOW_FILTER_SUPPORT_OUTLINE.color = _arg2;
                        _local8.applyFilter(_local8, _local8.rect, PointUtil.ORIGIN, GLOW_FILTER_SUPPORT_OUTLINE);
                        _local8.applyFilter(_local8, _local8.rect, PointUtil.ORIGIN, GLOW_FILTER_SUPPORT_DARK);
                        _local8.applyFilter(_local8, _local8.rect, PointUtil.ORIGIN, GLOW_FILTER_SUPPORT);
                    };
                };
            };
            if (_arg4){
                cache(_arg1, _arg2, _arg3, _local8, _arg5);
            };
            return (_local8);
        }

        private static function cache(_arg1:BitmapData, _arg2:uint, _arg3:Number, _arg4:BitmapData, _arg5:int):void{
            var _local7:Object;
            var _local6:String = getHash(_arg2, _arg3, _arg5);
            if ((_arg1 in glowHashes)){
                glowHashes[_arg1][_local6] = _arg4;
            }
            else {
                _local7 = {};
                _local7[_local6] = _arg4;
                glowHashes[_arg1] = _local7;
            };
        }

        private static function isCached(_arg1:BitmapData, _arg2:String):Boolean{
            var _local3:Object;
            if ((_arg1 in glowHashes)){
                _local3 = glowHashes[_arg1];
                if ((_arg2 in _local3)){
                    return true;
                };
            };
            return false;
        }

        private static function getHash(_arg1:uint, _arg2:Number, _arg3:int):String{
            return (((int((_arg2 * 10)).toString() + _arg1) + _arg3));
        }

        private static function getGradient():Shape{
            var _local1:Shape = new Shape();
            var _local2:Matrix = new Matrix();
            _local2.createGradientBox(0x0100, 0x0100, (Math.PI / 2), 0, 0);
            _local1.graphics.beginGradientFill(GradientType.LINEAR, [0, GRADIENT_MAX_SUB], [1, 1], [127, 0xFF], _local2);
            _local1.graphics.drawRect(0, 0, 0x0100, 0x0100);
            _local1.graphics.endFill();
            return (_local1);
        }


    }
}//package com.company.assembleegameclient.util.redrawers

