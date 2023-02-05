﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.lib.math.easing.Quart

package kabam.lib.math.easing{
    public class Quart {


        public static function easeIn(_arg1:Number):Number{
            return ((((_arg1 * _arg1) * _arg1) * _arg1));
        }

        public static function easeOut(_arg1:Number):Number{
            --_arg1;
            return (-(((((_arg1 * _arg1) * _arg1) * _arg1) - 1)));
        }

        public static function easeInOut(_arg1:Number):Number{
            _arg1 = (_arg1 * 2);
            if (_arg1 < 1){
                return (((((0.5 * _arg1) * _arg1) * _arg1) * _arg1));
            }
            _arg1 = (_arg1 - 2);
            return ((-0.5 * ((((_arg1 * _arg1) * _arg1) * _arg1) - 2)));
        }


    }
}//package kabam.lib.math.easing

