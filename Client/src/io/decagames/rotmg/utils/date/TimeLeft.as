// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.utils.date.TimeLeft

package io.decagames.rotmg.utils.date{
    import com.company.assembleegameclient.util.TimeUtil;

    public class TimeLeft {


        public static function parse(_arg1:int, _arg2:String):String{
            var _local3:int;
            var _local4:int;
            var _local5:int;
            if (_arg2.indexOf("%d") >= 0){
                _local3 = Math.floor((_arg1 / 86400));
                _arg1 = (_arg1 - (_local3 * 86400));
                _arg2 = _arg2.replace("%d", _local3);
            };
            if (_arg2.indexOf("%h") >= 0){
                _local4 = Math.floor((_arg1 / 3600));
                _arg1 = (_arg1 - (_local4 * 3600));
                _arg2 = _arg2.replace("%h", _local4);
            };
            if (_arg2.indexOf("%m") >= 0){
                _local5 = Math.floor((_arg1 / 60));
                _arg1 = (_arg1 - (_local5 * 60));
                _arg2 = _arg2.replace("%m", _local5);
            };
            _arg2 = _arg2.replace("%s", _arg1);
            return (_arg2);
        }

        public static function getStartTimeString(_arg1:Date):String{
            var _local2 = "";
            var _local3:Date = new Date();
            var _local4:Number = ((_arg1.time - _local3.time) / 1000);
            if (_local4 <= 0){
                return ("");
            };
            if (_local4 > TimeUtil.DAY_IN_S){
                _local2 = (_local2 + TimeLeft.parse(_local4, "%dd %hh"));
            }
            else {
                if (_local4 > TimeUtil.HOUR_IN_S){
                    _local2 = (_local2 + TimeLeft.parse(_local4, "%hh %mm"));
                }
                else {
                    if (_local4 > TimeUtil.MIN_IN_S){
                        _local2 = (_local2 + TimeLeft.parse(_local4, "%mm %ss"));
                    }
                    else {
                        _local2 = (_local2 + TimeLeft.parse(_local4, "%ss"));
                    };
                };
            };
            return (_local2);
        }


    }
}//package io.decagames.rotmg.utils.date

