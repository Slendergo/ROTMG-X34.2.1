// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.util.MoreObjectUtil

package com.company.util{
    public class MoreObjectUtil {
        public static function addToObject(_arg1:Object, _arg2:Object):void{
            var _local3:String;
            for (_local3 in _arg2) {
                _arg1[_local3] = _arg2[_local3];
            }
        }
    }
}//package com.company.util

