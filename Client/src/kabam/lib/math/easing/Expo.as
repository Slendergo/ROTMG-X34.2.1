// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.lib.math.easing.Expo

package kabam.lib.math.easing{
    public class Expo {


        public static function easeIn(_arg1:Number):Number{
            return ((((_arg1 == 0)) ? 0 : (Math.pow(2, (10 * (_arg1 - 1))) - 0.001)));
        }

        public static function easeOut(_arg1:Number):Number{
            return ((((_arg1 == 1)) ? 1 : (-(Math.pow(2, (-10 * _arg1))) + 1)));
        }

        public static function easeInOut(_arg1:Number):Number{
            if ((((_arg1 == 0)) || ((_arg1 == 1)))){
                return (_arg1);
            }
            _arg1 = (_arg1 * 2);
            if (_arg1 < 1){
                return ((0.5 * Math.pow(2, (10 * (_arg1 - 1)))));
            }
            return ((0.5 * (-(Math.pow(2, (-10 * (_arg1 - 1)))) + 2)));
        }


    }
}//package kabam.lib.math.easing

