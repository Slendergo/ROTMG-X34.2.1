// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.util.TimeUtil

package com.company.assembleegameclient.util{
    public class TimeUtil {

        public static const DAY_IN_MS:int = 86400000;
        public static const DAY_IN_S:int = 86400;
        public static const HOUR_IN_S:int = 3600;
        public static const MIN_IN_S:int = 60;


        public static function secondsToDays(_arg1:Number):Number{
            return ((_arg1 / DAY_IN_S));
        }

        public static function secondsToHours(_arg1:Number):Number{
            return ((_arg1 / HOUR_IN_S));
        }

        public static function secondsToMins(_arg1:Number):Number{
            return ((_arg1 / MIN_IN_S));
        }

        public static function parseUTCDate(_arg1:String):Date{
            var _local2:Array = _arg1.match(/(\d\d\d\d)-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d)/);
            var _local3:Date = new Date();
            _local3.setUTCFullYear(int(_local2[1]), (int(_local2[2]) - 1), int(_local2[3]));
            _local3.setUTCHours(int(_local2[4]), int(_local2[5]), int(_local2[6]), 0);
            return (_local3);
        }

        public static function humanReadableTime(_arg1:int):String{
            var _local2:String;
            var _local3:int;
            var _local4:int;
            var _local5:int;
            var _local6:int;
            _local6 = (((_arg1)>=0) ? _arg1 : 0);
            _local3 = (_local6 / DAY_IN_S);
            _local6 = (_local6 % DAY_IN_S);
            _local4 = (_local6 / HOUR_IN_S);
            _local6 = (_local6 % HOUR_IN_S);
            _local5 = (_local6 / MIN_IN_S);
            _local2 = _getReadableTime(_arg1, _local3, _local4, _local5);
            return (_local2);
        }

        private static function _getReadableTime(_arg1:int, _arg2:int, _arg3:int, _arg4:int):String{
            var _local5:String;
            if (_arg1 >= DAY_IN_S){
                if ((((_arg3 == 0)) && ((_arg4 == 0)))){
                    _local5 = (_arg2.toString() + (((_arg2 > 1)) ? "days" : "day"));
                    return (_local5);
                }
                if (_arg4 == 0){
                    _local5 = (_arg2.toString() + (((_arg2 > 1)) ? " days" : " day"));
                    _local5 = (_local5 + ((", " + _arg3.toString()) + (((_arg3 > 1)) ? " hours" : " hour")));
                    return (_local5);
                }
                _local5 = (_arg2.toString() + (((_arg2 > 1)) ? " days" : " day"));
                _local5 = (_local5 + ((", " + _arg3.toString()) + (((_arg3 > 1)) ? " hours" : " hour")));
                _local5 = (_local5 + ((" and " + _arg4.toString()) + (((_arg4 > 1)) ? " minutes" : " minute")));
                return (_local5);
            }
            if (_arg1 >= HOUR_IN_S){
                if (_arg4 == 0){
                    _local5 = (_arg3.toString() + (((_arg3 > 1)) ? " hours" : " hour"));
                    return (_local5);
                }
                _local5 = (_arg3.toString() + (((_arg3 > 1)) ? " hours" : " hour"));
                _local5 = (_local5 + ((" and " + _arg4.toString()) + (((_arg4 > 1)) ? " minutes" : " minute")));
                return (_local5);
            }
            _local5 = (_arg4.toString() + (((_arg4 > 1)) ? " minutes" : " minute"));
            return (_local5);
        }


    }
}//package com.company.assembleegameclient.util

