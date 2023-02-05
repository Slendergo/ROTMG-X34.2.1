// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.lib.math.easing.Back

package kabam.lib.math.easing{
    public class Back {


        public static function easeIn(_arg1:Number):Number{
            return (((_arg1 * _arg1) * ((2.70158 * _arg1) - 1.70158)));
        }

        public static function easeOut(_arg1:Number):Number{
            --_arg1;
            return ((((_arg1 * _arg1) * ((2.70158 * _arg1) + 1.70158)) + 1));
        }

        public static function easeInOut(_arg1:Number):Number{
            _arg1 = (_arg1 * 2);
            if (_arg1 < 1){
                return ((((0.5 * _arg1) * _arg1) * ((3.5949095 * _arg1) - 2.5949095)));
            }
            _arg1 = (_arg1 - 2);
            return ((0.5 * (((_arg1 * _arg1) * ((3.5949095 * _arg1) + 2.5949095)) + 2)));
        }


    }
}//package kabam.lib.math.easing

