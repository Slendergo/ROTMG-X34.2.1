// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.utils.colors.Tint

package io.decagames.rotmg.utils.colors{
    import flash.geom.ColorTransform;
    import flash.display.DisplayObject;

    public class Tint {


        public static function add(_arg1:DisplayObject, _arg2:uint, _arg3:Number):void{
            var _local4:ColorTransform = _arg1.transform.colorTransform;
            _local4.color = _arg2;
            var _local5:Number = (_arg3 / (1 - (((_local4.redMultiplier + _local4.greenMultiplier) + _local4.blueMultiplier) / 3)));
            _local4.redOffset = (_local4.redOffset * _local5);
            _local4.greenOffset = (_local4.greenOffset * _local5);
            _local4.blueOffset = (_local4.blueOffset * _local5);
            _local4.redMultiplier = (_local4.greenMultiplier = (_local4.blueMultiplier = (1 - _arg3)));
            _arg1.transform.colorTransform = _local4;
        }


    }
}//package io.decagames.rotmg.utils.colors

