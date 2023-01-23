// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.util.MathUtil

package com.company.assembleegameclient.util{
    public class MathUtil {

        public static const TO_DEG:Number = (180 / Math.PI);//57.2957795130823
        public static const TO_RAD:Number = (Math.PI / 180);//0.0174532925199433


        public static function round(_arg1:Number, _arg2:int=0):Number{
            var _local3:int = Math.pow(10, _arg2);
            return ((Math.round((_arg1 * _local3)) / _local3));
        }


    }
}//package com.company.assembleegameclient.util

