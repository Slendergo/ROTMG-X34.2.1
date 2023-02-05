// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.lib.util.VectorAS3Util

package kabam.lib.util{
    public class VectorAS3Util {


        public static function toArray(_arg1:Object):Array{
            var _local3:Object;
            var _local2:Array = [];
            for each (_local3 in _arg1) {
                _local2.push(_local3);
            }
            return (_local2);
        }


    }
}//package kabam.lib.util

