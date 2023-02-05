﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.util.FameUtil

package com.company.assembleegameclient.util{
    import flash.geom.ColorTransform;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import flash.display.Sprite;
    import flash.filters.DropShadowFilter;
    import com.company.rotmg.graphics.StarGraphic;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import com.company.util.AssetLibrary;
    import flash.display.BitmapData;

    public class FameUtil {

        public static const MAX_STARS:int = 80;
        public static const STARS:Vector.<int> = new <int>[20, 150, 400, 800, 2000];
        private static const lightBlueCT:ColorTransform = new ColorTransform((138 / 0xFF), (152 / 0xFF), (222 / 0xFF));
        private static const darkBlueCT:ColorTransform = new ColorTransform((49 / 0xFF), (77 / 0xFF), (219 / 0xFF));
        private static const redCT:ColorTransform = new ColorTransform((193 / 0xFF), (39 / 0xFF), (45 / 0xFF));
        private static const orangeCT:ColorTransform = new ColorTransform((247 / 0xFF), (147 / 0xFF), (30 / 0xFF));
        private static const yellowCT:ColorTransform = new ColorTransform((0xFF / 0xFF), (0xFF / 0xFF), (0 / 0xFF));
        public static const COLORS:Vector.<ColorTransform> = new <ColorTransform>[lightBlueCT, darkBlueCT, redCT, orangeCT, yellowCT];


        public static function maxStars():int{
            return ((ObjectLibrary.playerChars_.length * STARS.length));
        }

        public static function numStars(_arg1:int):int{
            var _local2:int;
            while ((((_local2 < STARS.length)) && ((_arg1 >= STARS[_local2])))) {
                _local2++;
            }
            return (_local2);
        }

        public static function nextStarFame(_arg1:int, _arg2:int):int{
            var _local3:int = Math.max(_arg1, _arg2);
            var _local4:int;
            while (_local4 < STARS.length) {
                if (STARS[_local4] > _local3){
                    return (STARS[_local4]);
                }
                _local4++;
            }
            return (-1);
        }

        public static function numAllTimeStars(_arg1:int, _arg2:int, _arg3:XML):int{
            var _local6:XML;
            var _local4:int;
            var _local5:int;
            for each (_local6 in _arg3.ClassStats) {
                if (_arg1 == int(_local6.@objectType)){
                    _local5 = int(_local6.BestFame);
                }
                else {
                    _local4 = (_local4 + FameUtil.numStars(_local6.BestFame));
                }
            }
            _local4 = (_local4 + FameUtil.numStars(Math.max(_local5, _arg2)));
            return (_local4);
        }

        public static function numStarsToBigImage(_arg1:int):Sprite{
            var _local3:Sprite = numStarsToImage(_arg1)
            _local3.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
            _local3.scaleX = 1.4;
            _local3.scaleY = 1.4;
            return (_local3);
        }

        public static function numStarsToImage(_arg1:int):Sprite{
            var _local2:Sprite = new StarGraphic();
            if (_arg1 < ObjectLibrary.playerChars_.length){
                _local2.transform.colorTransform = lightBlueCT;
            }
            else {
                if (_arg1 < (ObjectLibrary.playerChars_.length * 2)){
                    _local2.transform.colorTransform = darkBlueCT;
                }
                else {
                    if (_arg1 < (ObjectLibrary.playerChars_.length * 3)){
                        _local2.transform.colorTransform = redCT;
                    }
                    else {
                        if (_arg1 < (ObjectLibrary.playerChars_.length * 4)){
                            _local2.transform.colorTransform = orangeCT;
                        }
                        else {
                            if (_arg1 < (ObjectLibrary.playerChars_.length * 5)){
                                _local2.transform.colorTransform = yellowCT;
                            }
                        }
                    }
                }
            }
            return (_local2);
        }

        public static function numStarsToIcon(_arg1:int):Sprite{
            var _local3:Sprite = numStarsToImage(_arg1);
            var _local4:Sprite = new Sprite();
            _local4.addChild(_local3);
            _local4.filters = [new DropShadowFilter(0, 0, 0, 0.5, 6, 6, 1)];
            return (_local4);
        }

        public static function getFameIcon():BitmapData{
            var _local1:BitmapData = AssetLibrary.getImageFromSet("lofiObj3", 224);
            return (TextureRedrawer.redraw(_local1, 40, true, 0));
        }


    }
}//package com.company.assembleegameclient.util

