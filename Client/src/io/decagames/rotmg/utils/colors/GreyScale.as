// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.utils.colors.GreyScale

package io.decagames.rotmg.utils.colors{
    import flash.filters.ColorMatrixFilter;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;

    public class GreyScale {


        public static function setGreyScale(_arg1:BitmapData):BitmapData{
            var _local2:Number = 0.2225;
            var _local3:Number = 0.7169;
            var _local4:Number = 0.0606;
            var _local5:Array = [_local2, _local3, _local4, 0, 0, _local2, _local3, _local4, 0, 0, _local2, _local3, _local4, 0, 0, 0, 0, 0, 1, 0];
            var _local6:ColorMatrixFilter = new ColorMatrixFilter(_local5);
            _arg1.applyFilter(_arg1, new Rectangle(0, 0, _arg1.width, _arg1.height), new Point(0, 0), _local6);
            return (_arg1);
        }

        public static function greyScaleToDisplayObject(_arg1:DisplayObject, _arg2:Boolean):void{
            var _local3:Number = 0.2225;
            var _local4:Number = 0.7169;
            var _local5:Number = 0.0606;
            var _local6:Array = [_local3, _local4, _local5, 0, 0, _local3, _local4, _local5, 0, 0, _local3, _local4, _local5, 0, 0, 0, 0, 0, 1, 0];
            var _local7:ColorMatrixFilter = new ColorMatrixFilter(_local6);
            if (_arg2){
                _arg1.filters = [_local7];
            }
            else {
                _arg1.filters = [];
            };
        }


    }
}//package io.decagames.rotmg.utils.colors

