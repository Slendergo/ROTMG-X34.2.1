// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.tooltip.TooltipHelper

package com.company.assembleegameclient.ui.tooltip{
    public class TooltipHelper {

        public static const BETTER_COLOR:uint = 0xFF00;
        public static const WORSE_COLOR:uint = 0xFF0000;
        public static const NO_DIFF_COLOR:uint = 16777103;
        public static const NO_DIFF_COLOR_INACTIVE:uint = 6842444;
        public static const WIS_BONUS_COLOR:uint = 4219875;
        public static const UNTIERED_COLOR:uint = 9055202;
        public static const SET_COLOR:uint = 0xFF9900;
        public static const SET_COLOR_INACTIVE:uint = 6835752;


        public static function wrapInFontTag(_arg1:String, _arg2:String):String{
            var _local3 = (((('<font color="' + _arg2) + '">') + _arg1) + "</font>");
            return (_local3);
        }

        public static function getOpenTag(_arg1:uint):String{
            return ((('<font color="#' + _arg1.toString(16)) + '">'));
        }

        public static function getCloseTag():String{
            return ("</font>");
        }

        public static function getFormattedRangeString(_arg1:Number):String{
            var _local2:Number = (_arg1 - int(_arg1));
            return ((((int((_local2 * 10)))==0) ? int(_arg1).toString() : _arg1.toFixed(1)));
        }

        public static function compareAndGetPlural(_arg1:Number, _arg2:Number, _arg3:String, _arg4:Boolean=true, _arg5:Boolean=true):String{
            return (wrapInFontTag(getPlural(_arg1, _arg3), ("#" + getTextColor((((_arg4) ? (_arg1 - _arg2) : (_arg2 - _arg1)) * int(_arg5))).toString(16))));
        }

        public static function compare(_arg1:Number, _arg2:Number, _arg3:Boolean=true, _arg4:String="", _arg5:Boolean=false, _arg6:Boolean=true):String{
            return (wrapInFontTag((((_arg5) ? Math.abs(_arg1) : _arg1) + _arg4), ("#" + getTextColor((((_arg3) ? (_arg1 - _arg2) : (_arg2 - _arg1)) * int(_arg6))).toString(16))));
        }

        public static function getPlural(_arg1:Number, _arg2:String):String{
            var _local3:String = ((_arg1 + " ") + _arg2);
            if (_arg1 != 1){
                return ((_local3 + "s"));
            };
            return (_local3);
        }

        public static function getTextColor(_arg1:Number):uint{
            if (_arg1 < 0){
                return (WORSE_COLOR);
            };
            if (_arg1 > 0){
                return (BETTER_COLOR);
            };
            return (NO_DIFF_COLOR);
        }


    }
}//package com.company.assembleegameclient.ui.tooltip

